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
