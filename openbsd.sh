#!/bin/sh
during setup:

Install ugprade auztinstall shell? -> s
kbd de
# show disks
sysctl hw.disknames







########################### ROOT
fw_update -a 
pkg_add emacs vim lilypond git git-crypt github-cli groff rsync stow curl unison unison ledger rclone ffmpeg sox borgbackup password-store flac
echo 'permit persist niklas' > /etc/doas.conf

################################################ USER
# install desktop
doas pkg_add dunst picom feh zathura zathura-pdf-poppler zathura-ps syncthing neofetch youtube-dl mumble audacity blender gimp mpv  thunderbird fish mpd
# must maybe add /usr/local/bin/fish to /etc/shells
chsh -s /usr/local/bin/fish
doas rcctl enable xenodm
doas rcctl enable mpd


gh auth login
git config --global user.name "Niklas Bühler"
git config --global user.email "niklas@klangstellwerk.de"
git config --global init.defaultBranch master
mkdir ~/git

# create dirs
mkdir ~/git
# do it
cd ~/git
git clone https://git.suckless.org/dwm
cd dwm/
make clean install

cd /root/git
git clone https://git.suckless.org/dmenu
cd dmenu/
make clean install

cd /root/git
git clone https://git.suckless.org/slstatus
cd slstatus/
make clean install

cd /root/git
git clone https://git.suckless.org/tabbed
cd tabbed/
make clean install

cd /root/git
git clone https://git.suckless.org/st
cd st/
make clean install

# dotfiles
cd ~/
git clone https://github.com/niklasbuhler/.dotfiles.git ~/git/dotfiles

mkdir ~/.emacs.d
stow ~/git/dotfiles/emacs -t ~/
stow ~/git/dotfiles/xorg/ -t ~/
mkdir ~/.config
mkdir ~/.config/fish
rm ~/.config/fish/config.fish
stow ~/git/dotfiles/fish -t ~/

doas ifconfig iwm0 up
doas ifconfig iwm0 nwid "IO" wpakey "XXXXXXXXXXXXXX"
doas dhclient iwm0
