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
alias ls='exa -lah'

alias config='/usr/bin/git --git-dir=/home/dv/.cfg/ --work-tree=/home/dv'

alias vim=nvim.appimage
#functions
#

alias start-bsd='virsh start netbsd9.0 && sleep 60 && ssh bsd'

export PATH="$HOME/tools/tfenv/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PRE_COMMIT_COLOR=never

source "$HOME/repos/cli-helpers/.azure"
source "$HOME/repos/cli-helpers/.vpn"
source "$HOME/repos/cli-helpers/.vault"
source "$HOME/repos/cli-helpers/.jwt"
source <(kubectl completion zsh)

eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

