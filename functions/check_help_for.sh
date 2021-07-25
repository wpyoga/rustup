check_help_for() {
    local _arch
    local _cmd
    local _arg
    _arch="$1"
    shift
    _cmd="$1"
    shift

    local _category
    if "$_cmd" --help | grep -q 'For all options use the manual or "--help all".'; then
      _category="all"
    else
      _category=""
    fi

    case "$_arch" in

        *darwin*)
        if check_cmd sw_vers; then
            case $(sw_vers -productVersion) in
                10.*)
                    # If we're running on macOS, older than 10.13, then we always
                    # fail to find these options to force fallback
                    if [ "$(sw_vers -productVersion | cut -d. -f2)" -lt 13 ]; then
                        # Older than 10.13
                        echo "Warning: Detected macOS platform older than 10.13"
                        return 1
                    fi
                    ;;
                11.*)
                    # We assume Big Sur will be OK for now
                    ;;
                *)
                    # Unknown product version, warn and continue
                    echo "Warning: Detected unknown macOS major version: $(sw_vers -productVersion)"
                    echo "Warning TLS capabilities detection may fail"
                    ;;
            esac
        fi
        ;;

    esac

    for _arg in "$@"; do
        if ! "$_cmd" --help $_category | grep -q -- "$_arg"; then
            return 1
        fi
    done

    true # not strictly needed
}
