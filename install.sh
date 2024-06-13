#!/bin/bash

set -e

# Location of the backup directory
BAKUP_DIR=bak-$(date +%s)
mkdir -p $BAKUP_DIR

# [ -f ~/.bashrc ] && mv ~/.bashrc $BAKUP_DIR/
# ln $(pwd)/.bashrc ~/.bashrc
#
# [ -d ~/.config ] && mv ~/.config $BAKUP_DIR/
# ln -s $(pwd)/.config ~/.config

# Backs up directory if exists and symlinks new one into its place
symlink_dir() {
	FILEPATH=$1
	SYMLINK_LOCATION=$2
	[ -d $SYMLINK_LOCATION ] && mv $SYMLINK_LOCATION $BAKUP_DIR/
	[ -e "$FILEPATH" ] || ln -s $FILEPATH $SYMLINK_LOCATION
}

# Backs up file if exists and symlinks new one into its place
symlink_file() {
	FILEPATH=$1
	SYMLINK_LOCATION=$2
	[ -f $SYMLINK_LOCATION ] && mv $SYMLINK_LOCATION $BAKUP_DIR/
	[ -e "$FILEPATH" ] || ln -s $FILEPATH $SYMLINK_LOCATION
}

symlink_file $(pwd)/.bashrc ~/.bashrc
symlink_dir $(pwd)/.config ~/.config

# Install brew packages if on MacOS
[[ "$(uname -s)" == "Darwin" ]] && bash ./brew_installs.sh
