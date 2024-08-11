#!/usr/bin/sh

prmpt() {
  while true; do
    read -p "Do you wish to $1? " yn
    case $yn in
      [Yy]* ) $2; break;;
      [Nn]* ) break;;
      * ) echo "Please answer yes or no";;
    esac
  done
}

# Change default shell to zsh
prmpt "change default shell to zsh" "chsh -s $(which zsh)"

# Set up Git
prmpt "set up git?" 'git config --global user.email "isshi0417@gmail.com"'
echo "Git configuration complete!"

prmpt "authorize GitHub HTTP" "gh auth login"

# Symlink dotfiles
prmpt "symlink dotfiles" "stow */"

# Configure spicetify
prmpt "set up spicetify" "spicetify backup apply"

# Set up onedrive
prmpt "set up OneDrive autostart" "brew services start onedrive"
prmpt "log into OneDrive" "onedrive"
prmpt "synchronize OneDrive now" "onedrive --synchronize" 

# Restart
prmpt "restart now" "systemctl restart"
