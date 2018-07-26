#!/bin/bash

# some helper functions, credits to Ben "cowboy" Alman
# see https://github.com/cowboy/dotfiles/blob/master/bin/dotfiles#L26-L30
function e_header()  { echo -e "\n\033[1m$@\033[0m"; }
function e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()   { echo -e " \033[1;34m➜\033[0m  $@"; }

function symlink() {
    if [ -h "$2" ]; then
        local target="$(readlink -f ${2})"
        if [ "$1" == "$target" ]; then
            # don't create symlink if it exists and the target is the same
            return 0
        fi
    fi
    if [ -f "$2" ]; then
        e_error "File ($2) already exists!"
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
    e_success "created zsh symlinks"
else
    e_error "something gone wrong, you need to install oh-my-zsh on manually"
fi

# hyperterm stuff
symlink "$HOME/.dotfiles/.hyper.js" "$HOME/.hyper.js"
e_success "created hyper.js symlinks"

# VIM stuff
symlink "$HOME/.dotfiles/.vim" "$HOME/.vim"
symlink "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"
e_success "created vim symlinks"

# sublime-text
SUBLIME_TEXT_USER_PATH=""
SUBLIME_TEXT_DOTFILES_PATH="$HOME/.dotfiles/sublime-text"
if [ "$(uname)" == "Darwin" ]; then
  # OS X
  SUBLIME_TEXT_USER_PATH="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
  symlink "$SUBLIME_TEXT_DOTFILES_PATH/Default_(OSX).sublime-keymap" "$SUBLIME_TEXT_USER_PATH/Default (OSX).sublime-keymap"
  symlink "$SUBLIME_TEXT_DOTFILES_PATH/Default_(OSX).sublime-mousemap" "$SUBLIME_TEXT_USER_PATH/Default (OSX).sublime-mousemap"
  e_success "configured sublime text (OSX)"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Linux
  SUBLIME_TEXT_USER_PATH="$HOME/.config/sublime-text-3/Packages/User"
  symlink "$SUBLIME_TEXT_DOTFILES_PATH/Default_(Linux).sublime-keymap" "$SUBLIME_TEXT_USER_PATH/Default (Linux).sublime-keymap"
  symlink "$SUBLIME_TEXT_DOTFILES_PATH/Default_(Linux).sublime-mousemap" "$SUBLIME_TEXT_USER_PATH/Default (Linux).sublime-mousemap"
  e_success "configured sublime text (Linux)"
fi

if [ ! "$SUBLIME_TEXT_USER_PATH" == "" ]; then
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/Preferences.sublime-settings" "$SUBLIME_TEXT_USER_PATH/Preferences.sublime-settings"
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/phpcs.sublime-settings" "$SUBLIME_TEXT_USER_PATH/phpcs.sublime-settings"
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/Snippets" "$SUBLIME_TEXT_USER_PATH/Snippets"
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/Package_Control.sublime-settings" "$SUBLIME_TEXT_USER_PATH/Package Control.sublime-settings"
fi

# random
symlink "$HOME/.dotfiles/.ctags" "$HOME/.ctags"
symlink "$HOME/.dotfiles/.ackrc" "$HOME/.ackrc"
symlink "$HOME/.dotfiles/.curlrc" "$HOME/.curlrc"
symlink "$HOME/.dotfiles/.editorconfig" "$HOME/.editorconfig"
symlink "$HOME/.dotfiles/.wgetrc" "$HOME/.wgetrc"
symlink "$HOME/.dotfiles/.colordiffrc" "$HOME/.colordiffrc"
e_success "symlinked random stuff"

# git
symlink "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
git config --global core.excludesfile $HOME/.gitignore_global
symlink "$HOME/.dotfiles/.gitconfig.inc" "$HOME/.gitconfig.inc"
git config --global include.path $HOME/.gitconfig.inc
e_success "configured git"
e_arrow "reminder: set your git name and email like this: \
\n\t git config --global user.email \"foo@bar.com\" \
\n\t git config --global user.name \"Foo Bar\""

