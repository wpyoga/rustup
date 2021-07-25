# check if we have to use /dev/tty to prompt the user
local need_tty=yes
for arg in "$@"; do
    case "$arg" in
        --help)
            usage
            exit 0
            ;;
        *)
            OPTIND=1
            if [ "${arg%%--*}" = "" ]; then
                # Long option (other than --help);
                # don't attempt to interpret it.
                continue
            fi
            while getopts :hy sub_arg "$arg"; do
                case "$sub_arg" in
                    h)
                        usage
                        exit 0
                        ;;
                    y)
                        # user wants to skip the prompt --
                        # we don't need /dev/tty
                        need_tty=no
                        ;;
                    *)
                        ;;
                    esac
            done
            ;;
    esac
done
