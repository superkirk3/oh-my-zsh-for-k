export DOTDIR="${DOTDIR:-$HOME/.zshrc.d}"
export EDITOR_PATH="$DOTDIR"

#export EMACS="*term*"
if [[ -z "${SNIPPETS_PATH:-}" || "$SNIPPETS_PATH" = "${XDG_CONFIG_HOME:-$HOME/.config}/snippets" ]]; then
  if [ -d "$DOTDIR/snippets" ]; then
    export SNIPPETS_PATH="$DOTDIR/snippets"
  else
    export SNIPPETS_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/snippets"
  fi
fi
if [ -d "$SNIPPETS_PATH" ] && [[ ":$PATH:" != *":$SNIPPETS_PATH:"* ]]; then
  export PATH="$SNIPPETS_PATH:$PATH"
fi
export FZF_SNIPPETS_BINDKEYS='^[x ^[^['
export ZSH_TMUX_CONFIG="$HOME/.tmux.conf"

export DOOMDIR="${DOOMDIR:-$HOME/.doom.d}"
export TRU_HISTFILE="${TRU_HISTFILE:-$HOME/.zsh_history}"
export HISTDB_FILE="${HISTDB_FILE:-$HOME/.histdb/zsh-history.db}"
export devops_terraform_local_git="${devops_terraform_local_git:-$HOME/work_home/uid.devops.terraform.git}"
export UID_TF_MODULES_BASE_PATH="${UID_TF_MODULES_BASE_PATH:-$HOME/work_home/uid}"
export UID_CN_TF_MODULES_BASE_PATH="${UID_CN_TF_MODULES_BASE_PATH:-$HOME/Dropbox/git/src/github.com/Ubiquiti-CN}"
#export PATH="$HOME/.tgenv/bin:$PATH"
#export PATH=/opt/homebrew/Cellar/emacs-plus@29/bin:$PATH
if [ -d "/Applications/Cursor.app/Contents/Resources/app/bin" ]; then
  export PATH="/Applications/Cursor.app/Contents/Resources/app/bin:$PATH"
fi

# 让 SSH 非交互会话(mosh/Moshi 等)也能找到 Homebrew 的命令(mosh-server 等)
if [ -x /opt/homebrew/bin/brew ] && [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# 让非交互 ssh 会话也能找到 ~/.local/bin (claude 等)
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
