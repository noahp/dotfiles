# Import Cyrus gdb dashboard
source ~/.gdb-cyrus-dashboard

# Bring in backtrace colorize and typeof
source ~/.tromey-gdb-helpers/gdbhelpers/colorize.py
source ~/.tromey-gdb-helpers/gdbhelpers/typeof.py

# Tweak some defaults
set history save on
set history size 10000
set history filename ~/.gdb_history
set confirm off
set verbose off
set print pretty on
#set print array on
set print array-indexes on
set python print-stack full

# Disable threads display by default
dashboard threads

# Add xxd command.
define xxd
    dump binary memory dump.bin $arg0 $arg0+$arg1
    shell xxd dump.bin
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
