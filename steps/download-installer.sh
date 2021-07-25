if $_ansi_escapes_are_valid; then
    printf "\33[1minfo:\33[0m downloading installer\n" 1>&2
else
    printf '%s\n' 'info: downloading installer' 1>&2
fi

ensure mkdir -p "$_dir"
ensure downloader "$_url" "$_file" "$_arch"
ensure chmod u+x "$_file"
if [ ! -x "$_file" ]; then
    printf '%s\n' "Cannot execute $_file (likely because of mounting /tmp as noexec)." 1>&2
    printf '%s\n' "Please copy the file to a location where you can execute binaries and run ./rustup-init${_ext}." 1>&2
    exit 1
fi
