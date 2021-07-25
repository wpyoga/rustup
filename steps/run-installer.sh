if [ "$need_tty" = "yes" ]; then
    # The installer is going to want to ask for confirmation by
    # reading stdin.  This script was piped into `sh` though and
    # doesn't have stdin to pass to its children. Instead we're going
    # to explicitly connect /dev/tty to the installer's stdin.
    if [ ! -t 1 ]; then
        err "Unable to run interactively. Run with -y to accept defaults, --help for additional options"
    fi

    ignore "$_file" "$@" < /dev/tty
else
    ignore "$_file" "$@"
fi

local _retval=$?
