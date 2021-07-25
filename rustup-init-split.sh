#!/bin/sh
# shellcheck shell=dash

# This is just a little script that can be downloaded from the internet to
# install rustup. It just does platform detection, downloads the installer
# and runs it.

# It runs on Unix shells like {a,ba,da,k,z}sh. It uses the common `local`
# extension. Note: Most shells limit `local` to 1 var per line, contra bash.

# @MERGE
. sections/init.sh

# @MERGE
. functions/usage.sh

main() {
    # @MERGE
    . steps/prerequisites.sh

    # @MERGE
    . steps/check-system-info.sh

    # @MERGE
    . steps/initialize.sh

    # @MERGE
    . steps/terminal-properties.sh

    # @MERGE
    . steps/handle-args.sh

    # @MERGE
    . steps/download-installer.sh

    # @MERGE
    . steps/run-installer.sh

    # @MERGE
    . steps/cleanup.sh

    return "$_retval"
}

# @MERGE
. sections/system.sh

# @MERGE
. sections/util-functions.sh

main "$@" || exit 1
