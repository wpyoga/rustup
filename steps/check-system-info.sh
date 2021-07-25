get_architecture || return 1
local _arch="$RETVAL"
assert_nz "$_arch" "arch"

local _ext=""
case "$_arch" in
    *windows*)
        _ext=".exe"
        ;;
esac
