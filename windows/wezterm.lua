local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.default_prog = { "wsl.exe", "--distribution", "Ubuntu", "--cd", "~" }
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "CaskaydiaCove Nerd Font",
  -- 显式指定中文回退字体。不写的话 WezTerm 会自己挑一个系统字体,
  -- 挑中什么取决于环境,不同机器上宽度可能对不上。
  "Microsoft YaHei",
  "DengXian",
  "Consolas",
})

-- `·` `…` `─` 这类字符属于 Unicode 的"东亚歧义宽度":在 CJK 语境下算 2 格,
-- 否则算 1 格。终端和 TUI 程序对它的判断一旦不一致,画出来的框就会错位
-- (典型表现:某一行撑破边框,把中间的竖线顶掉)。
-- 显式钉成窄,与绝大多数 TUI(含 Claude Code)的假设一致。
config.treat_east_asian_ambiguous_width_as_wide = false

-- 明确告诉远端我们是 xterm-256color。WezTerm 默认就是这个,
-- 但显式写出来可以避免哪天默认值变了导致远端 terminfo 找不到。
config.term = "xterm-256color"
config.font_size = 12.5
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.98
config.scrollback_lines = 10000
config.initial_cols = 138
config.initial_rows = 42
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.window_padding = {
  left = 4,
  right = 4,
  top = 2,
  bottom = 2,
}

-- ── 启动菜单:一键开 tab 进 WSL / Mac ──────────────────────────────────────
-- 用系统的 ssh.exe 而不是 wezterm 内置的 ssh_domains:后者用 libssh 自己解析
-- ~/.ssh/config,对 IdentitiesOnly、ProxyCommand 这些支持不全;而且 Mac 上没装
-- wezterm-mux-server,多路复用 domain 也用不上。会话持久化交给 tmux。
--
-- 依赖 Windows 原生 %USERPROFILE%\.ssh\config 里的 Host mac
-- (注意不是 WSL 里那份,两者互相看不见)。
config.launch_menu = {
  { label = "WSL Ubuntu", args = { "wsl.exe", "--distribution", "Ubuntu", "--cd", "~" } },
  -- tmux 一律加 -u 强制 UTF-8。ssh.exe 不转发 LANG/LC_*,tmux 看不到 UTF-8 环境
  -- 就会把中文和 powerline 图标全渲染成 `_`。locale 已在 .zshenv 里兜底,
  -- 这里再钉一道,免得哪天 .zshenv 没被加载又踩回去。
  { label = "WSL + tmux", args = { "wsl.exe", "--distribution", "Ubuntu", "--cd", "~",
                                   "--", "tmux", "-u", "new", "-A", "-s", "main" } },
  { label = "Mac (ssh)",  args = { "ssh.exe", "mac" } },
  { label = "Mac + tmux", args = { "ssh.exe", "-t", "mac", "tmux -u new -A -s main" } },
  { label = "PowerShell", args = { "powershell.exe", "-NoLogo" } },
}

config.keys = {
  -- Ctrl+Shift+M 打开上面的菜单(M = machines)。
  -- Ctrl+Shift+P 被 WezTerm 自己的命令面板占着,别去抢。
  { key = "m", mods = "CTRL|SHIFT", action = act.ShowLauncherArgs({
      flags = "FUZZY|LAUNCH_MENU_ITEMS|DOMAINS|TABS",
  }) },
  { key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
  { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
  { key = "Insert", mods = "SHIFT", action = act.PasteFrom("Clipboard") },
  { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },

  -- 分屏/pane 导航全部交给 tmux,WezTerm 只管 tab 和窗口。
  -- 两层分屏叠在一起时,Ctrl+Shift+H 到底切的是哪一层会彻底分不清。
  -- (原来的 Ctrl+Shift+D 上下分屏其实也是失效的:mods 已含 SHIFT 时
  --  再写大写 "D" 匹配不上,那条绑定从来没生效过。)
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act.PasteFrom("Clipboard"),
  },
}

return config
