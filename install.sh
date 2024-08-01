#!/usr/bin/sh

# Layered Packages
wget https://raw.githubusercontent.com/trytomakeyouprivate/COPR-OSTree/main/copr -P ~/.local/bin/ &&\
chmod +x ~/.local/bin/copr

echo "Adding repos..."
copr enable varlad/helix
copr enable wezfurlong/wezterm-nightly
sudo ostree remote add mullvad

echo "Installing layered packages..."
rpm-ostree install helix
rpm-ostree install wezterm
rpm-ostree install mullvad-vpn
rpm-ostree install zsh

# Linuxbrew Packages
echo "Installing gh..."
brew install gh

echo "Installing lazygit..."
brew install laygit

echo "Installing onedrive..."
brew install onedrive

echo "Installing pandoc..."
brew install pandoc

echo "Installing starship..."
brew install starship

echo "Installing stow..."
brew install stow

echo "Installing thefuck..."
brew install thefuck

echo "Installing zoxide..."
brew install zoxide

echo "Installing spicetify..."
brew install spicetify

# Flatpaks
echo "Installing ferdium..."
flatpak install ferdium

echo "Installing obsidian..."
flatpak install obsidian

echo "Installing spotify..."
flatpak install spotify

# Change default shell to zsh
echo "Changing shell to zsh..."
chsh -s $(which zsh)

# Set up Git
echo "Setting up git and GitHub..."
git config --global user.email "isshi0417@gmail.com"
gh auth login

# Symlink dotfiles
echo "Symlinking dotfiles..."
cd dotfiles
stow */
