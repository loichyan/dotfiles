#
# Zsh configs
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS
# Set Vi keymap.
bindkey -v
# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}
# Load additional zsh functions path.
for profile in ${(z)NIX_PROFILES}; do
  fpath+=( "${profile}/share/zsh/site-functions" )
done
unset profile

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
# Wakatime
ZSH_WAKATIME_BIN=wakatime-cli

#
# zimfw
#

ZIM_HOME=~/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e "${ZIM_HOME}/zimfw.zsh" ]]; then
  echo "Download zimfw plugin manager"
  curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
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

# Use Ctrl-Space to autocomplete one word
bindkey '^E' forward-word

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
