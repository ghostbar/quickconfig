#!/usr/bin/env bash

help='
Usage:

bash install.sh [-l|--linux] [-m|--mac]

Options

-v/--version            - Print version
-h/--help               - Print help
-l/--linux              - Install on Linux (Debian-based)
-m/--mac                - Install on Mac OSX (Uses brew)
'

version='
Version: 0.2.0
© 2014, Jose Luis Rivas <me@ghostbar.co>
Licensed under the MIT terms.
'

basicAptGet() {
  echo "Installing basic packages: git tig tmux zsh vim-nox python-setuptools"
  sudo apt-get install git tig tmux zsh vim-nox python-setuptools curl xclip -y
}

basicBrew() {
  echo "Installing basic packages: git, tig, tmux, zsh, vim, python-setuptools"
  sudo brew install git tmux tig zsh vim python
}

changeToZsh() {
  echo "Change terminal to zsh"
  chsh -s /usr/bin/zsh
}

installPip() {
  echo "Installing pip"
  sudo easy_install pip
}

installPrezto() {
  if [ ! -d ~/.zprezto ]; then
    echo "Installing prezto"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
  else
    echo "It seems there's a ~/.zprezto directory already"
  fi
}

installPowerline() {
  echo "Powerline"
  sudo pip install -t /usr/local/lib/python2.7/site-packages git+git://github.com/Lokaltog/powerline
  sudo pip install git+git://github.com/Lokaltog/powerline
}

basicDotFiles() {
  if [ ! -d ~/config && ! -e ~/config ]; then
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

dotVim() {
  echo "Now dotvim"
  git clone git://github.com/ghostbar/dotvim.git ~/config/dotvim
  pushd ~/config/dotvim
  zsh ./install.zsh
}

showHelp() {
  echo "$version"
  echo "$help"
}

installIt() {
  changeToZsh
  installPip
  installPrezto
  installPowerline
  basicDotFiles
  dotFiles
  dotVim
  echo "Installed! Done!"
}

while test -n "$1"; do
  case $1 in
    -v|--version)
      echo "$version"
      exit 0;;
    -l|--linux)
      basicAptGet
      installIt
      exit 0;;
    -m|--mac)
      basicBrew
      installIt
      exit 0;;
    *)
      showHelp
      exit 0;;
  esac
done

if test -z $1; then
  showHelp
  exit 0
fi
