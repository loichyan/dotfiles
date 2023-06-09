#
# Zsh configs
#

# Use gpg-agent
if [[ -d ~/.gnupg ]] && (( ${+commands[gpg]} )) && (( ${+commands[gpg-agent]} )); then
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  echo UPDATESTARTUPTTY | gpg-connect-agent 1> /dev/null
fi

# Fix terminfo
if [ -z "$terminfo" ]; then
  export TERM=xterm-256color
fi

# Set Vi keymap.
bindkey -v
# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}
# Load additional zsh functions path.
for profile in ${(z)NIX_PROFILES}; do
  fpath+=( "${profile}/share/zsh/site-functions" )
done
unset profile

# Better history
HISTSIZE=100000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
# Ignore some entries
zstyle ':hist:*' auto-format no
export HISTORY_IGNORE="(;*)"

#
# Module configs
#

# Disable automatic widget re-binding on each precmd.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# Set what highlighters will be used.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
# Set escpace binding.
ZVM_VI_INSERT_ESCAPE_BINDKEY=JK
ZVM_INIT_MODE=sourcing

#
# zimfw
#

ZIM_HOME=~/.zim
if [[ ! -e "${ZIM_HOME}/zimfw.zsh" ]]; then
  echo "Initialize zimfw plugin manager"
  if (( ! ${+commands[git]} || ! ${+commands[curl]} )); then
    echo "git and curl is required for zimfw"
    return 1
  fi
  curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" "https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh"
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! "${ZIM_HOME}/init.zsh" -nt "${ZDOTDIR:-${HOME}}/.zimrc" ]]; then
  source "${ZIM_HOME}/zimfw.zsh" init
fi
# Initialize modules.
source "${ZIM_HOME}/init.zsh"
# Refresh dumpfile.
zimfw check-dumpfile -q

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P') bindkey ${key} history-substring-search-up
for key ('^[[B' '^N') bindkey ${key} history-substring-search-down
for key ('^[[A' '^P' 'k') bindkey -M vicmd ${key} history-substring-search-up
for key ('^[[B' '^N' 'j') bindkey -M vicmd ${key} history-substring-search-down
unset key

# Use Ctrl-E to autocomplete one word
bindkey '^E' forward-word

# Hsmw
zstyle ":history-search-multi-word" highlight-color "bg=yellow,fg=black,bold"
bindkey "^R" history-search-multi-word
bindkey -M emacs '\t' history-search-multi-word
bindkey -M emacs "$terminfo[kcbt]" history-search-multi-word-backwards

#
# Misc
#

# Load functions.
source "${MY_ZSH}/functions.zsh"

# Load aliases.
source "${MY_ZSH}/aliases.zsh"

# Setup zoxide.
if (( ${+commands[zoxide]} )); then
  eval "$(zoxide init zsh)"
fi

# Setup direnv.
if (( ${+commands[direnv]} )); then
  eval "$(direnv hook zsh)"
fi

# Load tabtab completions (pnpm).
if [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]]; then
  source ~/.config/tabtab/zsh/__tabtab.zsh
fi

# Setup starship.
if (( ${+commands[starship]} )); then
  eval "$(starship init zsh)"
fi

# Load pip completions.
if (( ${+commands[pip]} )); then
  eval "$(pip completion --zsh)"
fi

# Load pip completions.
if (( ${+commands[cue]} )); then
  eval "$(cue completion zsh)"
fi
