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

ZSA="# Rules for Oryx web flashing and live training
KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

# Legacy rules for live training over webusb (Not needed for firmware v21+)
  # Rule for all ZSA keyboards
  SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
  # Rule for the Moonlander
  SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
  # Rule for the Ergodox EZ
  SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
  # Rule for the Planck EZ
  SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

# Wally Flashing rules for the Ergodox EZ
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

# Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
# Keymapp Flashing rules for the Voyager
SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu""

# Change default shell to zsh
prmpt "change default shell to zsh" "chsh -s $(which zsh)"

# Set up Git
prmpt "set up git?" 'git config --global user.email "isshi0417@gmail.com"'
prmpt "authorize GitHub HTTP" "gh auth login"

# Symlink dotfiles
prmpt "symlink dotfiles" "stow */"

# Configure spicetify
prmpt "set up spicetify" "spicetify backup apply"

# Set up onedrive
prmpt "set up OneDrive autostart" "brew services start onedrive"
prmpt "log into OneDrive" "onedrive"
prmpt "synchronize OneDrive now" "onedrive --synchronize" 

# Enable SDDM customization
prmpt "enable SDDM customization" "sudo cp -r /usr/share/sddm /var"
read -r -p "This will make changes to fstab. Are you sure? " response
case "$response" in
  [Yy]* ) echo "/var/sddm /usr/share/sddm none rbind 0 0" | sudo tee -a /etc/fstab;;
  * ) echo "Skipping...";;
esac

# Set up ZSA Keyboard
prmpt "set up Moonlander connectivity" "sudo touch /etc/udev/rules.d/50-zsa.rules"
read -r -p "This will make changes to /etc/udev/rules.d/50-zsa.rules. Are you sure? " response
case "$response" in
  [Yy]* ) echo "$ZSA" | sudo tee -a /etc/udev/rules.d/50-zsa.rules; sudo groupadd plugdev; sudo usermod -aG plugdev $USER;;
  * ) echo "Skipping...";;
esac

# Restart
prmpt "restart now" "systemctl restart"
