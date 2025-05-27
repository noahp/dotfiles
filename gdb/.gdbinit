# Import Cyrus gdb dashboard
source ~/.gdb-cyrus-dashboard

# Bring in typeof
source ~/.tromey-gdb-helpers/gdbhelpers/typeof.py

set auto-load safe-path /

# Tweak some defaults
set history save on
set history size 10000
set history filename ~/.gdb_history
set confirm off
set verbose off
set print pretty on
set print array on
set print array-indexes on
set python print-stack full

# useful in case there's weak refs matching a symbol name
set multiple-symbols ask

# Disable threads display by default
dashboard threads

# Add xxd command.
define xxd
    dump binary memory /tmp/dump.bin $arg0 $arg0+$arg1
    eval "shell xxd -o %d /tmp/dump.bin", (char *) $arg0
end
document xxd
Run xxd on specified memory region. Usage:
  xxd <object> <length in bytes>
Must have xxd installed for it to work.
end

# Print arm exception state.
# https://mcuoneclipse.com/2015/07/05/debugging-arm-cortex-m-hard-faults-with-gdb-custom-command/
define armex
  printf "EXEC_RETURN (LR):\n",
  info registers $lr
    if (($lr & 0x4) == 0x4)
      printf "Uses PSP 0x%x return.\n", $psp
      set $armex_base = $psp
    else
      printf "Uses MSP 0x%x return.\n", $msp
      set $armex_base = $msp
    end

    printf "xPSR            0x%x\n", *(uint32_t *)($armex_base+28)
    printf "ReturnAddress   0x%x\n", *(uint32_t *)($armex_base+24)
    printf "LR (R14)        0x%x\n", *(uint32_t *)($armex_base+20)
    printf "R12             0x%x\n", *(uint32_t *)($armex_base+16)
    printf "R3              0x%x\n", *(uint32_t *)($armex_base+12)
    printf "R2              0x%x\n", *(uint32_t *)($armex_base+8)
    printf "R1              0x%x\n", *(uint32_t *)($armex_base+4)
    printf "R0              0x%x\n", *(uint32_t *)($armex_base)
    printf "Return instruction:\n"
    x/i *(uint32_t *)($armex_base+24)
    printf "LR instruction:\n"
    x/i *(uint32_t *)($armex_base+20)
end

document armex
ARMv7 Exception entry behavior.
xPSR, ReturnAddress, LR (R14), R12, R3, R2, R1, and R0
end

define iregs
  info registers
end

document iregs
Run 'info registers'
end

# Only source the local gdbinit file if it exists
python
import os
gdbinit_local = os.path.expanduser("~/.gdbinit-local")
if os.path.exists(gdbinit_local):
  gdb.execute("source {}".format(gdbinit_local))
end

python
class NvicInfo(gdb.Command):
    """Pretty print out interesting ARMv7m NVIC registers"""

    def __init__(self):
        super(NvicInfo, self).__init__(
            "nvicinfo", gdb.COMMAND_USER
        )

    def invoke(self, args, from_tty):
        del args
        del from_tty

        # deets: https://developer.arm.com/documentation/ddi0439/b/Nested-Vectored-Interrupt-Controller/NVIC-programmers-model
        # 7 of each of these
        nvic_regs = {
            "ISER" : 0xE000E100,
            "ISPR" : 0xE000E200,
            "IABR" : 0xE000E300,
        }

        for name, address in nvic_regs.items():
            active = []
            for i in range(7):
                bit = 0
                val = self._read32(address + i * 4)
                val = format(val, '032b')
                active.extend([(j + i*32) for j, ltr in enumerate(val) if ltr == '1'])
            print("{} :\n\t{}".format(name, "\n\t".join(active)))

    @staticmethod
    def _read32(address):
      """read 32 bit val from memory address"""
      value = gdb.selected_inferior().read_memory(address, 4)
      return struct.unpack_from("<I", value)[0]

NvicInfo()
end

python
import gdb

class PrintEnumCmd(gdb.Command):
  """print all elements of the given enum type"""

  def __init__(self):
    super(PrintEnumCmd, self).__init__("print-enum", gdb.COMMAND_DATA, gdb.COMPLETE_EXPRESSION)

  def invoke(self, argstr, from_tty):
    typename = argstr
    if not typename or typename.isspace():
      raise gdb.GdbError("Usage: print-enum type")

    try:
      t = gdb.lookup_type(typename)
    except gdb.error:
      typename = "enum " + typename
      try:
        t = gdb.lookup_type(typename)
      except gdb.error:
        raise gdb.GdbError("type " + typename + " not found")

    if t.code != gdb.TYPE_CODE_ENUM:
      raise gdb.GdbError("type " + typename + " is not an enum")

    for f in t.fields():
      print(f.name, "=", f.enumval)

PrintEnumCmd()
end

python
import gdb

class StackDeltaCommand(gdb.Command):
    """Compute and display the stack delta for each frame in the backtrace."""

    def __init__(self):
        super(StackDeltaCommand, self).__init__("stack-deltas", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        # Get the newest (currently selected) frame
        frame = gdb.newest_frame()

        if frame is None:
            print("No stack frames found.")
            return

        deltas = []
        sp_values = []

        # Traverse frames and collect $sp values
        while frame is not None:
            try:
                sp_val = int(frame.read_register("sp"))
                sp_values.append((frame, sp_val))
            except ValueError:
                print(f"Could not read $sp for frame: {frame.name()}")
                break
            frame = frame.older()

        # Compute deltas between adjacent frames
        print("Stack deltas (in bytes):")
        for i in range(len(sp_values) - 1):
            frame, sp = sp_values[i]
            _, next_sp = sp_values[i + 1]
            delta = sp - next_sp
            print(f"Frame {i} ({frame.name()}): delta = {delta}")

        # Print the last frame (no delta)
        if sp_values:
            last_frame, _ = sp_values[-1]
            print(f"Frame {len(sp_values)-1} ({last_frame.name()}): delta = N/A")


StackDeltaCommand()
end
