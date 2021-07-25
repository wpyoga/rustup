assert_nz() {
    if [ -z "$1" ]; then err "assert_nz $2"; fi
}
