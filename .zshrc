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
eval "$(zoxide init zsh)"

alias cd-dropboxlatex="cd /Users/calvinkhor/Library/Mobile\ Documents/com\~apple\~CloudDocs/Dropbox\ LaTeX"
alias cd-Github="~/Documents/Github/"

eval "$(starship init zsh)"
eval "$(rtx activate zsh)"

# yadm into gitui
function yc() {
    cd ~
    yadm enter gitui
    cd -
}

alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'

export EDITOR=nvim
export VISUAL="$EDITOR"

export NEOVIDE_MULTIGRID="true"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-20.jdk/Contents/Home"
export CC=gcc-12
    # INFO: this gcc is more recent than the system one. Needed for compiling treesitter for neorg

alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-astro="NVIM_APPNAME=KickstartNvim nvim"


function nvims() {
    items=("default" "AstroNvim" "KickstartNvim")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt="Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then 
        echo "Nothing selected" 
        return 0
    elif [[ $config = "default" ]]; then
        config="" 
    fi
    NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a "nvims\n"
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh # it looks like oh-my-zsh just kinda sucks? why cant it find this. Oh, the instructions are to clone the repo myself. Probably should switch to idk, antidote
