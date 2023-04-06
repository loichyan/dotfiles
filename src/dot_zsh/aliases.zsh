alias Gck="git checkout"
alias Gsw="git switch"

# Replace ls with lsd
if (( ${+commands[lsd]} )); then
  alias ls="lsd"
fi
