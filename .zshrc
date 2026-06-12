# shellcheck shell=zsh
source ~/.profile

# History
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Configure Starship prompt
eval "$(starship init zsh)"
