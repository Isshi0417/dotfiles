#!/usr/bin/sh

dwnld() {
  while true; do
    read -p "Do you wish to install $1? " yn
    case $yn in
      [Yy]* ) $2; break;;
      [Nn]* ) break;;
      * ) echo "Please answer yes or no.";;
    esac
  done
}

rpm() {
  rpm-ostree install $1 
}

brw() {
  brew install $1
}

flt() {
  flatpak install flathub $1
}

# Layered Packages
wget https://raw.githubusercontent.com/trytomakeyouprivate/COPR-OSTree/main/copr -P ~/.local/bin/ &&\
chmod +x ~/.local/bin/copr

echo "Adding repos..."
copr enable varlad/helix
copr enable wezfurlong/wezterm-nightly
sudo ostree remote add mullvad

echo "Installing layered packages..."
dwnld "helix" "rpm helix"
dwnld "wezterm" "rpm wezterm"
dwnld "mullvad" "rpm mullvad-vpn"
dwnld "zsh" "rpm zsh"

# Linuxbrew Packages
dwnld "gh" "brw gh"
dwnld "lazygit" "brw lazygit"
dwnld "onedrive" "brw onedrive"
dwnld "pandoc" "brw pandoc"
dwnld "starship" "brw starship"
dwnld "stow" "brw stow"
dwnld "thefuck" "brw thefuck"
dwnld "zoxide" "brw zoxide"
dwnld "spicetify" "brw spicetify"
dwnld "eza" "brw eza"

# Flatpaks
dwnld "ferdium" "flt org.ferdium.Ferdium"
dwnld "obsidian" "flt md.obsidian.Obsidian"
dwnld "spotify" "flt com.spotify.Client"

# Restart
echo "Restarting..."
systemctl restart
