#!/usr/bin/env bash

# Re-exec under bash if invoked from zsh, sh, or another non-bash shell.
if [ -z "${BASH_VERSION:-}" ]; then
    if command -v bash >/dev/null 2>&1; then
        exec bash "$0" "$@"
    elif [ -x /bin/bash ]; then
        exec /bin/bash "$0" "$@"
    else
        echo "Error: bash is required to run this installer." >&2
        exit 1
    fi
fi

set -e

# some helper functions, credits to Ben "cowboy" Alman
# see https://github.com/cowboy/dotfiles/blob/master/bin/dotfiles#L26-L30
function e_header()  { echo -e "\n\033[1m$*\033[0m"; }
function e_success() { echo -e " \033[1;32m✔\033[0m  $*"; }
function e_error()   { echo -e " \033[1;31m✖\033[0m  $*"; }
function e_arrow()   { echo -e " \033[1;34m➜\033[0m  $*"; }

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# prerequisites
e_header "Checking prerequisites..."

if ! command -v zsh >/dev/null 2>&1; then
    e_error "zsh is not installed!"
    e_arrow "install it with: sudo apt-get install zsh (Linux) or brew install zsh (macOS)"
    exit 1
fi
e_success "zsh is installed"

if [ "$(basename "$SHELL")" != "zsh" ]; then
    e_arrow "zsh is not your default shell, change it with: chsh -s $(which zsh)"
fi

e_header "Initializing submodules..."
git -C "$DOTFILES_DIR" submodule update --init --recursive
e_success "submodules initialized"

function symlink() {
    local src="$1"
    local dest="$2"
    local dir_to_create
    if [ ! -e "$src" ]; then
        e_error "Symlink source ($src) does not exist!"
        return 1
    fi
    dir_to_create=$(dirname "$dest")
    if [ ! -d "$dir_to_create" ]; then
        e_error "directory $dir_to_create does not exist, let's create it"
        mkdir -p "$dir_to_create"
    fi
    if [ -h "$dest" ]; then
        local target
        target=$(readlink "$dest")
        if [ "$src" = "$target" ]; then
            # don't create symlink if it exists and the target is the same
            return 0
        fi
        rm -f "$dest"
    elif [ -f "$dest" ] || [ -d "$dest" ]; then
        e_error "File ($dest) already exists!"
        local newname
        newname=$dest.$(date +%s)
        mv "$dest" "$newname" && e_success "renamed to $newname"
    fi
    ln -s "$src" "$dest"
}

# zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    e_error "oh-my-zsh not found!"
    e_header "install it automatically..."
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
    if [ -d "$HOME/.oh-my-zsh" ]; then
        e_success "installed oh-my-zsh"
    fi
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
    symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    e_success "created zsh symlinks"
else
    e_error "something gone wrong, you need to install oh-my-zsh manually"
fi

# hyperterm stuff
symlink "$DOTFILES_DIR/.hyper.js" "$HOME/.hyper.js"
e_success "created hyper.js symlinks"

# VIM stuff
symlink "$DOTFILES_DIR/.vim" "$HOME/.vim"
symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
e_success "created vim symlinks"

# sublime-text
SUBLIME_TEXT_USER_PATH=""
SUBLIME_TEXT_DOTFILES_PATH="$DOTFILES_DIR/sublime-text"
case "$(uname -s)" in
  Darwin)
    SUBLIME_TEXT_USER_PATH="$HOME/Library/Application Support/Sublime Text/Packages/User"
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/Default_(OSX).sublime-keymap" "$SUBLIME_TEXT_USER_PATH/Default (OSX).sublime-keymap"
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/Default_(OSX).sublime-mousemap" "$SUBLIME_TEXT_USER_PATH/Default (OSX).sublime-mousemap"
    e_success "configured sublime text (OSX)"
    ;;
  Linux)
    SUBLIME_TEXT_USER_PATH="$HOME/.config/sublime-text-3/Packages/User"
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/Default_(Linux).sublime-keymap" "$SUBLIME_TEXT_USER_PATH/Default (Linux).sublime-keymap"
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/Default_(Linux).sublime-mousemap" "$SUBLIME_TEXT_USER_PATH/Default (Linux).sublime-mousemap"
    e_success "configured sublime text (Linux)"
    ;;
esac

if [ -n "$SUBLIME_TEXT_USER_PATH" ]; then
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/Preferences.sublime-settings" "$SUBLIME_TEXT_USER_PATH/Preferences.sublime-settings"
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/phpcs.sublime-settings" "$SUBLIME_TEXT_USER_PATH/phpcs.sublime-settings"
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/Snippets" "$SUBLIME_TEXT_USER_PATH/Snippets"
    symlink "$SUBLIME_TEXT_DOTFILES_PATH/Package_Control.sublime-settings" "$SUBLIME_TEXT_USER_PATH/Package Control.sublime-settings"
fi

# other
symlink "$DOTFILES_DIR/.ctags" "$HOME/.ctags"
symlink "$DOTFILES_DIR/.ackrc" "$HOME/.ackrc"
symlink "$DOTFILES_DIR/.ripgreprc" "$HOME/.ripgreprc"
symlink "$DOTFILES_DIR/.curlrc" "$HOME/.curlrc"
symlink "$DOTFILES_DIR/.editorconfig" "$HOME/.editorconfig"
symlink "$DOTFILES_DIR/.wgetrc" "$HOME/.wgetrc"
symlink "$DOTFILES_DIR/.colordiffrc" "$HOME/.colordiffrc"
symlink "$DOTFILES_DIR/.tmux" "$HOME/.tmux"
symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
symlink "$DOTFILES_DIR/.tmux-mac" "$HOME/.tmux-mac"
symlink "$DOTFILES_DIR/.tmux-linux" "$HOME/.tmux-linux"
symlink "$DOTFILES_DIR/herdr/config.toml" "$HOME/.config/herdr/config.toml"
e_success "symlinked other stuff"

# git
symlink "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
symlink "$DOTFILES_DIR/.gitconfig.inc" "$HOME/.gitconfig.inc"
git config --global include.path "$HOME/.gitconfig.inc"
symlink "$DOTFILES_DIR/.gitattributes_global" "$HOME/.gitattributes_global"
e_success "configured git"
e_arrow "reminder: set your git name and email like this: \
\n\t git config --global user.email \"foo@bar.com\" \
\n\t git config --global user.name \"Foo Bar\""
