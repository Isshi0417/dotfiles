# Set path
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Plugins
plugins=(git)

# Start starship
eval "$(starship init zsh)"

