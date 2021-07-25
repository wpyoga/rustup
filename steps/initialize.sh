local _url="${RUSTUP_UPDATE_ROOT}/dist/${_arch}/rustup-init${_ext}"

local _dir
_dir="$(ensure mktemp -d)"
local _file="${_dir}/rustup-init${_ext}"
