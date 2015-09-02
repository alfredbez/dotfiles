# Installation

1. Clone this repo: `git clone git@github.com:alfredbez/dotfiles.git '~/.dotfiles'`

1. symlink files to your home-directory

# Automatic installation

Just run `. ~/.dotfiles/install.sh`

# Manual installation

##VIM
`ln -s ~/.dotfiles/.vim ~/.vim && ln -s ~/.dotfiles/.vimrc ~/.vimrc`

##ZSH
Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) first.
Then symlink `.zshrc` to your home-directory:
````
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/oh-my-zsh-custom ~/.oh-my-zsh/custom
````

##global .gitignore
````
ln -s ~/.dotfiles/.gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
````

##other

````
ln -s ~/.dotfiles/.ackrc ~/.ackrc
ln -s ~/.dotfiles/.curlrc ~/.curlrc
ln -s ~/.dotfiles/.editorconfig ~/.editorconfig
ln -s ~/.dotfiles/.wgetrc ~/.wgetrc
# on OS X
ln -s ~/.dotfiles/sublime-text/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
ln -s ~/.dotfiles/sublime-text/Default\ \(OSX\).sublime-keymap ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
# on Linux
ln -s ~/.dotfiles/sublime-text/Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/
ln -s ~/.dotfiles/sublime-text/Default\ \(Linux\).sublime-keymap ~/.config/sublime-text-3/Packages/User/
````
