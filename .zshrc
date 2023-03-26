autoload -Uz compinit
compinit

# source antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# autoload -Uz promptinit && promptinit && prompt pure # this is if prompts are managed by antidote.

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias nv="neovide --multigrid"
alias ls="exa"

alias wifiname="/Sy*/L*/Priv*/Apple8*/V*/C*/R*/airport -I | sed -n 's/^.*SSID: \(.*\)$/\1/p'"
alias wifipass="security find-generic-password -wa"
alias z="zoxide"

alias cd-dropboxlatex="cd /Users/calvinkhor/Library/Mobile\ Documents/com\~apple\~CloudDocs/Dropbox\ LaTeX"
alias cd-Github="~/Documents/Github/"

eval "$(starship init zsh)"
eval "$(rtx activate zsh)"
export NEOVIDE_MULTIGRID="true"
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh # it looks like oh-my-zsh just kinda sucks? why cant it find this. Oh, the instructions are to clone the repo myself. Probably should switch to idk, antidote
