# Installation

1. Clone this repo: `cd ~ && git clone git@github.com:alfredbez/dotfiles.git`

1. `cd` into the repo: `cd dotfiles`

1. symlink files to your home-directory

##VIM
`ln -s dotfiles/.vim ~/.vim && ln -s dotfiles/.vimrc ~/.vimrc`

##ZSH
Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) first.
Then symlink `.zshrc` to your home-directory:
`ln -s dotfiles/.zshrc ~/.zshrc`

##global .gitignore
`ln -s dotfiles/.gitignore_global ~/.gitignore_global && git config --global core.excludesfile ~/.gitignore_global`
