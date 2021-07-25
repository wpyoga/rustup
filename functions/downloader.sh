# This wraps curl or wget. Try curl first, if not installed,
# use wget instead.
downloader() {
    local _dld
    local _ciphersuites
    local _err
    local _status
    if check_cmd curl; then
        _dld=curl
    elif check_cmd wget; then
        _dld=wget
    else
        _dld='curl or wget' # to be used in error message of need_cmd
    fi

    if [ "$1" = --check ]; then
        need_cmd "$_dld"
    elif [ "$_dld" = curl ]; then
        get_ciphersuites_for_curl
        _ciphersuites="$RETVAL"
        if [ -n "$_ciphersuites" ]; then
            _err=$(curl --proto '=https' --tlsv1.2 --ciphers "$_ciphersuites" --silent --show-error --fail --location "$1" --output "$2" 2>&1)
            _status=$?
        else
            echo "Warning: Not enforcing strong cipher suites for TLS, this is potentially less secure"
            if ! check_help_for "$3" curl --proto --tlsv1.2; then
                echo "Warning: Not enforcing TLS v1.2, this is potentially less secure"
                _err=$(curl --silent --show-error --fail --location "$1" --output "$2" 2>&1)
                _status=$?
            else
                _err=$(curl --proto '=https' --tlsv1.2 --silent --show-error --fail --location "$1" --output "$2" 2>&1)
                _status=$?
            fi
        fi
        if [ -n "$_err" ]; then
            echo "$_err" >&2
            if echo "$_err" | grep -q 404$; then
                err "installer for platform '$3' not found, this may be unsupported"
            fi
        fi
        return $_status
    elif [ "$_dld" = wget ]; then
        get_ciphersuites_for_wget
        _ciphersuites="$RETVAL"
        if [ -n "$_ciphersuites" ]; then
            _err=$(wget --https-only --secure-protocol=TLSv1_2 --ciphers "$_ciphersuites" "$1" -O "$2" 2>&1)
            _status=$?
        else
            echo "Warning: Not enforcing strong cipher suites for TLS, this is potentially less secure"
            if ! check_help_for "$3" wget --https-only --secure-protocol; then
                echo "Warning: Not enforcing TLS v1.2, this is potentially less secure"
                _err=$(wget "$1" -O "$2" 2>&1)
                _status=$?
            else
                _err=$(wget --https-only --secure-protocol=TLSv1_2 "$1" -O "$2" 2>&1)
                _status=$?
            fi
        fi
        if [ -n "$_err" ]; then
            echo "$_err" >&2
            if echo "$_err" | grep -q ' 404 Not Found$'; then
                err "installer for platform '$3' not found, this may be unsupported"
            fi
        fi
        return $_status
    else
        err "Unknown downloader"   # should not reach here
    fi
}
