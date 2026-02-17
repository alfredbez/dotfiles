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

if git -C "$DOTFILES_DIR" submodule status | grep -q '^-'; then
    e_error "git submodules not initialized (forgot --recursive?)"
    e_header "initializing submodules..."
    git -C "$DOTFILES_DIR" submodule update --init --recursive
    e_success "submodules initialized"
else
    e_success "git submodules OK"
fi

function symlink() {
    local src="$1"
    local dest="$2"
    local dir_to_create
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
    symlink "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
    e_success "created zsh symlinks"
else
    e_error "something gone wrong, you need to install oh-my-zsh manually"
fi

# hyperterm stuff
symlink "$HOME/.dotfiles/.hyper.js" "$HOME/.hyper.js"
e_success "created hyper.js symlinks"

# VIM stuff
symlink "$HOME/.dotfiles/.vim" "$HOME/.vim"
symlink "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"
symlink "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
e_success "created vim symlinks"

# sublime-text
SUBLIME_TEXT_USER_PATH=""
SUBLIME_TEXT_DOTFILES_PATH="$HOME/.dotfiles/sublime-text"
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
symlink "$HOME/.dotfiles/.ctags" "$HOME/.ctags"
symlink "$HOME/.dotfiles/.ackrc" "$HOME/.ackrc"
symlink "$HOME/.dotfiles/.ripgreprc" "$HOME/.ripgreprc"
symlink "$HOME/.dotfiles/.curlrc" "$HOME/.curlrc"
symlink "$HOME/.dotfiles/.editorconfig" "$HOME/.editorconfig"
symlink "$HOME/.dotfiles/.wgetrc" "$HOME/.wgetrc"
symlink "$HOME/.dotfiles/.colordiffrc" "$HOME/.colordiffrc"
symlink "$HOME/.dotfiles/.tmux" "$HOME/.tmux"
symlink "$HOME/.dotfiles/.tmux.conf" "$HOME/.tmux.conf"
symlink "$HOME/.dotfiles/.tmux-mac" "$HOME/.tmux-mac"
symlink "$HOME/.dotfiles/.tmux-linux" "$HOME/.tmux-linux"
e_success "symlinked other stuff"

# git
symlink "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
symlink "$HOME/.dotfiles/.gitconfig.inc" "$HOME/.gitconfig.inc"
git config --global include.path "$HOME/.gitconfig.inc"
symlink "$HOME/.dotfiles/.gitattributes_global" "$HOME/.gitattributes_global"
e_success "configured git"
e_arrow "reminder: set your git name and email like this: \
\n\t git config --global user.email \"foo@bar.com\" \
\n\t git config --global user.name \"Foo Bar\""
