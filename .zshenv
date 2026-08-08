# locale 必须设在 .zshenv,不能只写在 .zshrc。
# `ssh host "tmux ..."` 是非交互执行,只加载 .zshenv;而 Windows 的 ssh.exe 默认
# 不转发 LANG/LC_*(Mac 的 sshd 也没配 AcceptEnv)。两下一叠加,tmux 启动时看不到
# 任何 UTF-8 环境,就会降级成非 UTF-8 模式,把中文和 powerline 图标全渲染成 `_`。
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-en_US.UTF-8}"

# Claude Code 的登录凭据存在 macOS 登录钥匙串里,而钥匙串只对 GUI 安全会话解锁。
# 从别的机器 ssh 进来(包括 Cursor 的 Remote-SSH 服务端)拿不到它,会反复要求重新认证。
# 解法:在 Mac 本地跑一次 `claude setup-token`,把输出的长期 token 存进下面这个文件:
#   umask 077; claude setup-token > ~/.claude/oauth-token
# 之后所有会话(终端 + Cursor 的 Claude 插件)都直接用它,不再碰钥匙串。
# token 放在仓库外,别写进 dotfiles —— 这个仓库是公开的。
if [[ -r "$HOME/.claude/oauth-token" ]]; then
  export CLAUDE_CODE_OAUTH_TOKEN="$(<"$HOME/.claude/oauth-token")"
fi

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
