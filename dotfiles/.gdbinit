define hook-quit
    set confirm off
end

set history save on
set history size 5000
set debuginfod enabled on

# Optional per-site overlay (bootstrap creates an empty file when absent)
source ~/.gdbinit.local
