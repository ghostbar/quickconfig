#!/usr/bin/env bash

# Determine what OS is running
if [ "$(uname)" = "Darwin" ]; then
  OS='mac'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  OS='linux'
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  OS='cygwin'
fi

help='
Usage:

bash install.sh [-l|--linux] [-m|--mac]

Options

-v/--version            - Print version
-h/--help               - Print help
-i/--install            - Install on Linux or Mac OSX (will guess and do the right thing, either apt-get or brew)
-l/--linux              - Install on Linux (Debian-based)
-m/--mac                - Install on Mac OSX (Uses brew)
-u/--update             - Updates an existing installation of quickconfig
'

version='
Version: 1.0.1
© 2014-2016, Jose-Luis Rivas <me@ghostbar.co>
Licensed under the MIT terms.
'

basicAptGet() {
  echo "Installing basic packages: git tig tmux zsh vim-nox python-setuptools build-essential"
  sudo apt-get install git tig tmux zsh vim-nox python-setuptools curl xclip build-essential -y
}

basicBrew() {
  echo "Installing basic packages: git, tig, tmux, zsh, vim, python-setuptools"
  brew install git tmux tig zsh vim python
}

autoBasic() {
  if [ "$OS" == "linux" ]; then
    basicAptGet
  elif [ "$OS" == "mac" ]; then
    basicBrew
  fi
}

changeToZsh() {
  echo "Change terminal to zsh"
  chsh -s /usr/bin/zsh
}

installPrezto() {
  if [ ! -d ~/.zprezto ]; then
    echo "Installing prezto"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
  else
    echo "It seems there's a ~/.zprezto directory already"
  fi
}

updatePrezto() {
  if [ ! -d ~/.zprezto ]; then
    echo "There's no prezto to update"
  else
    echo "Updating prezto"
    pushd ~/.zprezto
    git pull
    git submodule update --init --recursive
  fi
}

basicDotFiles() {
  if [ ! -d ~/config ] && [ ! -e ~/config ]; then
    echo "Now dotfiles"
    mkdir ~/config
  fi
}

dotFiles() {
  echo "First dotfiles"
  git clone git://github.com/ghostbar/dotfiles.git ~/config/dotfiles
  pushd ~/config/dotfiles
  zsh ./install.zsh -a
}

updateDotFiles() {
  if [ -d ~/config/dotfiles ]; then
    echo "Updating dotfiles"
    pushd ~/config/dotfiles
    git pull
  else
    echo "Can't update dotfiles since they don't exist"
  fi
}

dotVim() {
  echo "Now dotvim"
  git clone git://github.com/ghostbar/dotvim.git ~/config/dotvim
  pushd ~/config/dotvim
  zsh ./install.zsh
}

updateDotVim() {
  if [ -d ~/config/dotvim ]; then
    echo "Updating dotvim"
    pushd ~/config/dotvim
    git pull
  else
    echo "Can't update dotvim since it doesn't exists"
  fi
}

showHelp() {
  echo "$version"
  echo "$help"
}

installIt() {
  changeToZsh
  installPrezto
  basicDotFiles
  dotFiles
  dotVim
  echo "Installed! Done!"
}

updateIt() {
  updatePrezto
  updateDotFiles
  updateDotVim
}

while test -n "$1"; do
  case $1 in
    -v|--version)
      echo "$version"
      exit 0;;
    -i|--install)
      autoBasic
      installIt
      exit 0;;
    -l|--linux)
      basicAptGet
      installIt
      exit 0;;
    -m|--mac)
      basicBrew
      installIt
      exit 0;;
    -u|--update)
      updateIt
      exit 0;;
    *)
      showHelp
      exit 0;;
  esac
done

if test -z "$1"; then
  showHelp
  exit 0
fi
