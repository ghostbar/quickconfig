echo "Installing basic packages: git tig tmux zsh vim-nox python-setuptools"
sudo apt-get install git tig tmux zsh vim-nox python-setuptools -y

echo "Change terminal to zsh"
chsh -s /usr/bin/zsh

echo "Installing pip"
sudo easy_install pip

echo "Installing oh-my-zsh"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

echo "zsh-syntax-highlighting"
mkdir -p ~/.oh-my-zsh/custom/plugins
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ~/.oh-my.zsh/custom/plugins/zsh-syntax-highlighting

echo "Powerline"
sudo pip install -t /usr/local/lib/python2.7/site-packages git+git://github.com/Lokaltog/powerline
sudo pip install git+git://github.com/Lokaltog/powerline

echo "Now dotfiles"
mkdir ~/config

echo "First dotfiles"
git clone git@github.com:ghostbar/dotfiles.git ~/config/dotfiles
sh ~/config/dotfiles/install.sh -a

echo "Now dotvim"
git clone git@github.com:ghostbar/dotvim.git ~/config/dotvim
sh ~/config/dotvim/install.sh

echo "DONE!!!! :D :D :D"
echo "\n"
echo "Don't forget to remove the reattach stuff in ~/.tmux.conf that's only for Mac OSX!!!!!!!!"
