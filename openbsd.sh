#!/bin/sh
####################### setup

# Install ugprade auztinstall shell? -> s
kbd de
# show disks
sysctl hw.disknames







########################### ROOT
fw_update -a 
echo 'permit persist keepenv niklas' > /etc/doas.conf

################################################ USER
# install desktop
doas pkg_add emacs vim lilypond git git-crypt github-cli groff rsync stow curl unison ledger rclone ffmpeg sox borgbackup password-store flac font-awesome ripgrep
doas pkg_add dunst picom feh zathura zathura-pdf-poppler zathura-ps syncthing neofetch youtube-dl mumble audacity blender gimp mpv thunderbird chrome fish mpd fzf
# must maybe add /usr/local/bin/fish to /etc/shells
chsh -s /usr/local/bin/fish
doas rcctl enable xenodm
doas rcctl enable mpd
doas rcctl enable apmd
doas rcctl set apmd flags -A
doas rcctl start apmd
# clean up
doas sed -i 's/xconsole/#xconsole/' /etc/X11/xenodm/Xsetup_0
doas echo 'xset b off' >> /etc/X11/xenodm/Xsetup_0
# dont ping google
doas sed -i 's/www\.google\.com/www\.openbsd\.org/' /etc/ntpd.conf

# configure resource limits
doas usermod -G staff niklas

gh auth login
git config --global user.name "Niklas Bühler"
git config --global user.email "niklas@klangstellwerk.de"
git config --global init.defaultBranch master

# create dirs
mkdir ~/git
# do it
cd ~/git
git clone https://github.com/niklasbuhler/dwm-openbsd.git
cd dwm-openbsd/
doas make clean install

cd ~/git
git clone https://github.com/niklasbuhler/dmenu-openbsd.git
cd dmenu-openbsd/
make clean install

cd ~/git
git clone https://github.com/niklasbuhler/slstatus-openbsd.git
cd slstatus-openbsd/
make clean install

cd ~/git
git clone https://github.com/niklasbuhler/tabbed-openbsd.git
cd tabbed/
make clean install

cd ~/git
git clone https://github.com/niklasbuhler/st-openbsd.git
cd st/
make clean install

# dotfiles
cd ~/
git clone https://github.com/niklasbuhler/.dotfiles.git ~/git/dotfiles

# install doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# uncomment for normal emacs
# mkdir ~/.emacs.d
# stow ~/git/dotfiles/emacs -t ~/

# install dotfiles
cd ~/git/dotfiles && stow xorg-openbsd/ -t ~/
cd ~/
mkdir ~/.config
mkdir ~/.config/fish
rm ~/.config/fish/config.fish
cd ~/git/dotfiles && stow fish/ -t ~/

doas ifconfig iwm0 up
doas ifconfig iwm0 nwid "IO" wpakey "XXXXXXXXXXXXXX"
doas dhclient iwm0


