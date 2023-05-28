alias Gck="git checkout"
alias Gsw="git switch"

# Replace ls with lsd
if (( ${+commands[lsd]} )); then
  alias ls="lsd"
fi

if (( ${+commands[lsd]} )); then
  alias lg="lazygit"
fi

if [[ $TERM_PROGRAM == "WezTerm" ]]; then
  alias nvim="env TERM=wezterm nvim"
fi
