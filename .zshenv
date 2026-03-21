export DOTDIR="${DOTDIR:-$HOME/.zshrc.d}"
export EDITOR_PATH="$DOTDIR"

#export EMACS="*term*"
export SNIPPETS_PATH="${SNIPPETS_PATH:-${XDG_CONFIG_HOME:-$HOME/.config}/snippets}"
if [ -d "$SNIPPETS_PATH" ] && [[ ":$PATH:" != *":$SNIPPETS_PATH:"* ]]; then
  export PATH="$SNIPPETS_PATH:$PATH"
fi
export FZF_SNIPPETS_BINDKEYS='^[x ^[^['

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
