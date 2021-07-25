if [ "$KSH_VERSION" = 'Version JM 93t+ 2010-03-05' ]; then
    # The version of ksh93 that ships with many illumos systems does not
    # support the "local" extension.  Print a message rather than fail in
    # subtle ways later on:
    echo 'rustup does not work with this ksh93 version; please try bash!' >&2
    exit 1
fi


set -u

# If RUSTUP_UPDATE_ROOT is unset or empty, default it.
RUSTUP_UPDATE_ROOT="${RUSTUP_UPDATE_ROOT:-https://static.rust-lang.org/rustup}"
