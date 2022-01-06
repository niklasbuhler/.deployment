apt update -y; apt upgrade -y;
apt install -y emacs vim lilypond emacs vim lilypond zsh zplug git doas pass tmux groff rsync stow curl borgbackup unison ledger supercollider texlive-full rclone ffmpeg sox

echo 'permit persist niklas' > /etc/doas.conf
# enable firewall
apt install -y ufw
ufw enable
# ALLOw SYNCTHING AND SSH PORTS FORT EXAMPLE HERE

# install desktop
apt install -y xorg dunst picom feh qjackctl zathura zathura-pdf-poppler zathura-ps syncthing frescobaldi network-manager neofetch alsa-utils youtube-dl pulsemixer mumble

# install audio
apt install -y pulseaudio

# install suckless utils
# dependencies first
apt install -y make gcc libx11-dev libxinerama-dev libxft-dev
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

cd /root/git
git clone https://git.suckless.org/st
cd st/
make clean install

# install extra apps as non-flatpaks
# spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
apt update -y && apt install -y spotify-client

# signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  tee -a /etc/apt/sources.list.d/signal-xenial.list
apt update -y && apt install -y signal-desktop

# sadly there is no static bitwig link so i need to manually install
# add to /etc/apt/sources.list -> contrib non-free

# reaper
cd /root/
wget http://reaper.fm/files/6.x/reaper643_linux_x86_64.tar.xz
tar -xvf reaper643_linux_x86_64.tar.xz
cd reaper_linux_x86_64/
./install-reaper.sh
cd ..
rm reaper643_linux_x86_64.tar.xz
rm -rf reaper_linux_x86_64/

# github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update -y && sudo apt install -y gh
# brave
apt install -y apt-transport-https curl
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list
apt update -y && apt install -y brave-browser

################################## USER
############################

# configure git username and mail globally for the user (should push for root configs with doas)
git config --global user.name "Niklas Bühler"
git config --global user.email "niklas@klangstellwerk.de"

# blender 3.0
cd ~/Downloads/
tar xvf blender-3.0.0-linux-x64.tar.xz
mv blender-3.0.0-linux-x64 blender/
doas mv blender/ /opt/
doas ln -sf /opt/blender/blender /usr/local/bin/

# bitwig
dpkg --add-architecture i386
apt update -y; apt upgrade -y;
# dpkg -i bitwig.deb
apt -f install;

chsh -s /bin/zsh
gh auth login

# dotfiles
cd ~/
git clone https://github.com/niklasbuhler/.dotfiles.git
cd .dotfiles/
stow zsh/
mkdir ~/.emacs.d
stow emacs/
stow xorg/

# passwords
cd ~/
git clone https://github.com/niklasbuhler/.password-store.git

# scripts
mkdir ~/.local
mkdir ~/.local/bin
