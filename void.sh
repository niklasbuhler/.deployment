# install required packages
xbps-install -S -y emacs vim lilypond zsh git opendoas pass github-cli tmux dcron groff rsync borg unison ledger jack supercollider texlive-full xtools rclone ffmpeg sox pfetch

# make me a doas user
echo 'permit persist niklas' > /etc/doas.conf

# install flatpak
xbps-install -S flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.spotify.Client com.frescobaldi.Frescobaldi com.bitwig.BitwigStudio org.signal.Signal

# install desktop apps
xbps-install -S -y xorg dunst picom emacs-gtk3 feh qjackctl zathura zathura-pdf-poppler audacity

# install suckless utils
# dependencies first
xbps-install -S -y make gcc libX11-devel libXinerama-devel libXft-devel
# create dirs
mkdir /root/git
# do it
cd /root/git
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

# needs additional dependencies
xbps-install -S -y pkg-config
cd /root/git
git clone https://git.suckless.org/st
cd st/
make clean install

# install multimedia apps (should this be a flatpak?!)
xbps-install -S -y blender gimp

# remove sudo
echo "ignorepkg=sudo" > /etc/xbps.d/sudo.conf
xbps-remove sudo
