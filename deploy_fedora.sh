#!/bin/sh
git clone https://github.com/niklasbuhler/.dotfiles.git

# doom emacs
mv ~/.doom.d ~/.doom.d.backup
cd .dotfiles
stow doom
cd ~/.emacs.d/bin
./doom sync


chsh -s /usr/bin/fish
