#!/bin/bash

set -e

brew install bash bash-completion@2
brew install gnu-sed
# Ripgrep is a faster grep alternative
brew install ripgrep
# Install Coursier for Scala support and improve dependency management
brew install coursier/formulas/coursier && cs setup

brew install gawk grep gnu-sed coreutils

# Install FZF and set it up w/ tab completion support
brew install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
git clone git clone https://github.com/lincheney/fzf-tab-completion ~/fzf-tab-completion/
~/.fzf/install # Install tab completion
