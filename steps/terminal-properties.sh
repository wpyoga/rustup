local _ansi_escapes_are_valid=false
if [ -t 2 ]; then
    if [ "${TERM+set}" = 'set' ]; then
        case "$TERM" in
            xterm*|rxvt*|urxvt*|linux*|vt*)
                _ansi_escapes_are_valid=true
            ;;
        esac
    fi
fi
