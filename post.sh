#!/usr/bin/sh

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

# Configure spicetify
spicetify backup apply

# Set up onedrive
brew services start onedrive
onedrive
onedrive --synchronize

