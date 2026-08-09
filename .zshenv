# locale 必须设在 .zshenv,不能只写在 .zshrc。
# `ssh host "tmux ..."` 是非交互执行,只加载 .zshenv;而 Windows 的 ssh.exe 默认
# 不转发 LANG/LC_*(Mac 的 sshd 也没配 AcceptEnv)。两下一叠加,tmux 启动时看不到
# 任何 UTF-8 环境,就会降级成非 UTF-8 模式,把中文和 powerline 图标全渲染成 `_`。
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-en_US.UTF-8}"

# Claude Code 的登录凭据存在 macOS 登录钥匙串里,而钥匙串只对 GUI 安全会话解锁。
# 从别的机器 ssh 进来(包括 Cursor/VSCode 的 Remote-SSH 服务端)读不到它,会反复要求认证。
#
# 折中:**只在远程会话里**注入长期 token,本机 GUI 会话继续走钥匙串。
# 钥匙串有按二进制的 ACL、且随会话锁定,比环境变量安全;能用就别降级。
# SSH_CONNECTION 只有 ssh 进来的会话才有 —— Remote-SSH 的服务端是经 ssh 拉起的,
# 所以它和它派生的插件进程都会有;本地开的终端则没有。
#
# token 来自 `umask 077; claude setup-token > ~/.claude/oauth-token`(600 权限)。
# 放仓库外 —— 这个 dotfiles 仓库是公开的,绝不能进去。
#
# /!\ 注意这只能限制"哪些会话",没法限制"哪个程序":同一个 ssh 会话里任何进程
#     都能读到这个变量。真出问题就去账号设置里吊销 token 重发一个。
if [[ -n "${SSH_CONNECTION:-}" && -r "$HOME/.claude/oauth-token" ]]; then
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
