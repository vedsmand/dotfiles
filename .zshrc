# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U colors && colors

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


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_USE_ASYNC=1
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

#eval "$(starship init zsh)"

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
alias config='/usr/bin/git --git-dir=/home/dv/.cfg/ --work-tree=/home/dv'

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

export PATH="$HOME/tools/tfenv/bin:$PATH"

source "$HOME/repos/cli-helpers/.azure"
source "$HOME/repos/cli-helpers/.vpn"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
