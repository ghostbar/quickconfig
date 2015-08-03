Quick Config
============

This is how ends up:

![Screenshot](https://i.cloudup.com/bvwxtsZ7Ny.png)

TL;DR
-----

Requires `sudo` powers and `bash` (not `sh`, very important to use `bash`).

Generating a SSH key and uploading it is good to have.

    ssh-keygen -t rsa -b 4096

Download `install.sh`:

    wget https://github.com/ghostbar/quickconfig/raw/master/install.sh

If installing on Linux, then:

    bash install.sh --linux

If installing on Mac, then:

    bash install.sh --mac

Help?

    bash install.sh --help

What's this?
------------
This will leave a shell with the following installed:

+ `git` and `tig` (a `gitk` for the terminal) with basic `gitconfig` and `gitignore` from [`ghostbar/dotfiles`](https://github.com/ghostbar/dotfiles).
+ `tmux` and it's configs from [`ghostbar/dotfiles`](https://github.com/ghostbar/dotfiles).
+ Some basics configs for `bash`.
+ `zsh` and it's configs from [`ghostbar/dotfiles`](https://github.com/ghostbar/dotfiles), together with `prezto` (and defaults to `zsh` on the terminal).
+ `vim` and it's configs from [`ghostbar/dotvim`](https://github.com/ghostbar/dotvim).
+ `powerline` and it's configs from [`ghostbar/dotfiles`](https://github.com/ghostbar/dofiles).
+ `xclip` on Linux for copy and paste support on `tmux` and `vim`.
+ `curl`

How do I update this?
---------------------

    bash install.sh --update

This will update your `powerline`, `prezto`, `dotfiles` and `dotvim`.

Known issues
------------
If `sh` is used instead of `bash` it will fail. `sh` does not have `pushd` on which this `install.sh` script depends heavily.

License
-------
© 2014-2015, Jose-Luis Rivas `<me@ghostbar.co>`

Licensed under the MIT terms.
