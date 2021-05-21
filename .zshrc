autoload -U colors && colors
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{255}%1~%f%b %# '

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history 

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
setopt complete_aliases
autoload -U +X bashcompinit && bashcompinit

#auto-suggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

source ~/src/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

eval "$(starship init zsh)"

#completions
#
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ”

#alias
#
alias ls='exa -l -h -a --git'
alias less=/usr/share/vim/vim81/macros/less.sh

alias akadev="docker run --rm -it --name akamai -v $HOME/.edgerc:/root/.edgerc -v $(pwd):/work -w /work akamai/shell "
alias jupydev="docker run --rm -p 8888:8888 --name jupyter -e JUPYTER_ENABLE_LAB=yes -v $(pwd):/home/jovyan docker.io/jupyter/scipy-notebook:latest"

#functions
#
function tf(){
  docker run --rm -ti --name terraform -v $(pwd):/workspace \
  -v ${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK} \
  -e SSH_AUTH_SOCK="${SSH_AUTH_SOCK}" \
  -w /workspace \
  -e AWS_REGION \
  -e AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY \
  -e AWS_SESSION_TOKEN \
  -e AWS_SECURITY_TOKEN \
  -e AWS_SESSION_EXPIRATION \
   hashicorp/terraform:$1 "$@[3, -1]";
}
