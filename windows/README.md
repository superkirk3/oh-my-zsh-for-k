# Windows 11 WSL 配置教程

这个目录是专门给 Windows 11 + WSL 准备的配置。它和仓库根目录的 macOS 配置分开维护，不会改动原来的 `dot.zshrc`。

保留的核心功能：

- oh-my-zsh
- powerlevel10k
- fzf 和常用 git/fzf helper
- tmux
- zsh autosuggestions
- zsh syntax highlighting
- snippets picker
- GitLab SSH 工作流
- WezTerm 终端配置

不迁移的 macOS 专属内容：

- Homebrew 路径
- iTerm2 shell integration
- `/Applications`
- AppleScript
- `DYLD_*`
- oh-my-zsh 的 `macos` 插件

## 1. 安装 WSL Ubuntu

用管理员权限打开 PowerShell：

```powershell
wsl --install -d Ubuntu
wsl --set-default-version 2
```

如果安装过程要求重启 Windows，先重启。然后从开始菜单打开 Ubuntu，创建 Linux 用户名和密码。

进入 Ubuntu 后先更新系统：

```bash
sudo apt update
sudo apt upgrade -y
```

## 2. 安装 WezTerm

在 PowerShell 里安装：

```powershell
winget install wez.wezterm
```

推荐在 Windows 里安装一个 Nerd Font，比如：

- `JetBrainsMono Nerd Font`
- `CaskaydiaCove Nerd Font`

这样 powerlevel10k 的图标不会乱码。

## 3. 配置 GitLab SSH

在 WSL 里执行：

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

把输出的 public key 加到 GitLab：

`GitLab -> Preferences -> SSH Keys -> Add new key`

测试 SSH：

```bash
ssh -T git@gitlab.com
```

如果你用的是公司自建 GitLab，把 `gitlab.com` 换成公司的 GitLab 域名。

设置 Git 用户信息：

```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
git config --global init.defaultBranch main
```

## 4. Clone 这个仓库

在 WSL 里执行：

```bash
git clone git@gitlab.com:<namespace>/oh-my-zsh-for-k.git ~/.zshrc.d
cd ~/.zshrc.d
```

把 `<namespace>` 换成你 GitLab 上真实的 group/user 路径。

如果这个仓库暂时还在 GitHub，也可以用 GitHub SSH 地址 clone。shell 配置本身不绑定 GitLab 或 GitHub。

## 5. 一键安装 zsh 配置

在 WSL 里执行：

```bash
cd ~/.zshrc.d
sh windows/install-wsl.sh
```

脚本会做这些事：

- 安装基础 apt 包
- 安装 oh-my-zsh
- 安装 powerlevel10k
- 安装核心 zsh 插件
- 备份已有的 `~/.zshrc` 和 `~/.zshenv`
- 链接 `~/.zshrc` 到 `windows/dot.zshrc`
- 链接 `~/.zshenv` 到 `windows/.zshenv`
- 尝试把 `windows/wezterm.lua` 自动复制到 Windows 的 `%USERPROFILE%\.wezterm.lua`
- 把默认 shell 设置成 zsh

安装完成后，在 PowerShell 里重启 WSL：

```powershell
wsl --shutdown
```

然后打开 WezTerm。

## 6. 如果 WezTerm 配置没有自动复制

一般情况下安装脚本会自动复制。如果失败，用 PowerShell 手动执行：

```powershell
copy \\wsl$\Ubuntu\home\<your-linux-user>\.zshrc.d\windows\wezterm.lua $env:USERPROFILE\.wezterm.lua
```

把 `<your-linux-user>` 换成你的 WSL 用户名。

如果你的 WSL 发行版不叫 `Ubuntu`，编辑 `%USERPROFILE%\.wezterm.lua` 里的这一行：

```lua
config.default_prog = { "wsl.exe", "--distribution", "Ubuntu", "--cd", "~" }
```

查看 WSL 发行版名字：

```powershell
wsl -l -v
```

## 7. 验证

在 WezTerm / WSL 里执行：

```bash
zsh -i -c exit
git status
tmux new -s test
```

常用快捷键：

- `Ctrl-Shift-t`：新建 WezTerm tab
- `Ctrl-Shift-d`：左右分屏
- `Ctrl-Shift-D`：上下分屏
- `Ctrl-Shift-h/j/k/l`：切换 pane
- `Esc Esc`、`Alt-x`、`Ctrl-x '`：打开 snippet picker
- `Ctrl-g Ctrl-b`：把 git branch 选到命令行
- `Ctrl-g Ctrl-h`：把 git commit hash 选到命令行

## 8. 可选工具

需要 Docker 时：

```bash
sudo apt install -y docker.io docker-compose-plugin
```

需要 AWS CLI 时：

```bash
sudo apt install -y awscli
```

Terraform 建议按 HashiCorp 官方 Linux apt 源安装，不建议直接依赖 Ubuntu 仓库里的旧版本。
