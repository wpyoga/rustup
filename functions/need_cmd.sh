need_cmd() {
    if ! check_cmd "$1"; then
        err "need '$1' (command not found)"
    fi
}
