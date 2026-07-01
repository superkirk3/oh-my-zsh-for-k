export DOTDIR="${DOTDIR:-$HOME/.zshrc.d/windows}"
export EDITOR_PATH="$DOTDIR"

if [[ -z "${SNIPPETS_PATH:-}" ]]; then
  if [[ -d "$DOTDIR/../snippets" ]]; then
    export SNIPPETS_PATH="$DOTDIR/../snippets"
  elif [[ -d "$HOME/.zshrc.d/snippets" ]]; then
    export SNIPPETS_PATH="$HOME/.zshrc.d/snippets"
  else
    export SNIPPETS_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/snippets"
  fi
fi

if [[ -d "$SNIPPETS_PATH" && ":$PATH:" != *":$SNIPPETS_PATH:"* ]]; then
  export PATH="$SNIPPETS_PATH:$PATH"
fi

export FZF_SNIPPETS_BINDKEYS='^[x ^[^['
export ZSH_TMUX_CONFIG="${ZSH_TMUX_CONFIG:-$HOME/.tmux.conf}"
export DOOMDIR="${DOOMDIR:-$HOME/.doom.d}"
export TRU_HISTFILE="${TRU_HISTFILE:-$HOME/.zsh_history}"
export HISTDB_FILE="${HISTDB_FILE:-$HOME/.histdb/zsh-history.db}"

for user_path in "$HOME/.local/bin" "$HOME/.emacs.d/bin" "$HOME/go/bin"; do
  if [[ -d "$user_path" && ":$PATH:" != *":$user_path:"* ]]; then
    export PATH="$user_path:$PATH"
  fi
done
