#!/bin/bash

# some helper functions, credits to Ben "cowboy" Alman
# see https://github.com/cowboy/dotfiles/blob/master/bin/dotfiles#L26-L30
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

function symlink() {
	if [ -h "$2" ]; then
		local target="$(readlink -f ${2})"
		if [ "$1" == "$target" ]; then
			# don't create symlink if it exists and the target is the same
			return 0
		fi
	fi
	if [ -f "$2" ]; then
    e_error "File already exists!"
    local newname="$2.$(date +%s)"
    mv "$2" "$newname" && e_success "renamed to $newname"
	fi
	ln -s "$1" "$2"
}

# zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
	e_error "oh-my-zsh not found!"
	e_header "install it automatically..."
	git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
	if [ -d $HOME/.oh-my-zsh ]; then
		e_success "installed oh-my-zsh"
	fi
fi

if [ -d $HOME/.oh-my-zsh ]; then
	symlink "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
	rm -rf "$HOME/.oh-my-zsh/custom"
	symlink "$HOME/.dotfiles/oh-my-zsh-custom" "$HOME/.oh-my-zsh/custom"
	e_success "created zsh symlinks"
else
	e_error "something gone wrong, you need to install oh-my-zsh on manually"
fi

# VIM stuff
symlink "$HOME/.dotfiles/.vim" "$HOME/.vim"
symlink "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"
e_success "created vim symlinks"

# git
symlink "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
git config --global core.excludesfile $HOME/.gitignore_global
e_success "configured git"
e_arrow "reminder: set your git name and email like this: \
\n\t git config --global user.email \"foo@bar.com\" \
\n\t git config --global user.name \"Foo Bar\""

# sublime-text
if [ "$(uname)" == "Darwin" ]; then
  # OS X
  symlink "$HOME/.dotfiles/sublime-text/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
  symlink "$HOME/.dotfiles/sublime-text/Default (OSX).sublime-keymap" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Default (OSX).sublime-keymap"
  symlink "$HOME/.dotfiles/sublime-text/phpcs.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/phpcs.sublime-settings"
  e_success "configured sublime text (OSX)"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	# Linux
  symlink "$HOME/.dotfiles/sublime-text/Preferences.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
  symlink "$HOME/.dotfiles/sublime-text/Default (Linux).sublime-keymap" "$HOME/.config/sublime-text-3/Packages/User/Default (Linux).sublime-keymap"
  symlink "$HOME/.dotfiles/sublime-text/phpcs.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/phpcs.sublime-settings"
  e_success "configured sublime text (Linux)"
fi

# random
symlink "$HOME/.dotfiles/.ackrc" "$HOME/.ackrc"
symlink "$HOME/.dotfiles/.curlrc" "$HOME/.curlrc"
symlink "$HOME/.dotfiles/.editorconfig" "$HOME/.editorconfig"
symlink "$HOME/.dotfiles/.wgetrc" "$HOME/.wgetrc"
e_success "symlinked random stuff"