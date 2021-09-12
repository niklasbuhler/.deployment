#!/bin/sh
sudo apt update -y; sudo apt upgrade -y;
sudo apt install -y emacs fd-find ripgrep git fish mumble lilypond frescobaldi ledger syncthing flatpak stow fish cmake markdown mu4e maildir-utils isync shellcheck supercollider-ide neofetch

# brave
sudo apt install -y apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# flatpaks
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.signal.Signal com.spotify.Client com.bitwig.BitwigStudio

# dotfiles
cd ~/
git clone https://github.com/niklasbuhler/.dotfiles.git

# doom emacs
mv ~/.doom.d ~/.doom.d.backup
cd .dotfiles
stow doom-emacs
cd ~/.emacs.d/bin/
./doom sync

# fish
cd ~/.dotfiles
stow fish/
chsh -s /usr/bin/fish
