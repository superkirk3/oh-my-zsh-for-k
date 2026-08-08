local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.default_prog = { "wsl.exe", "--distribution", "Ubuntu", "--cd", "~" }
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "CaskaydiaCove Nerd Font",
  "Consolas",
})
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
  { label = "WSL + tmux", args = { "wsl.exe", "--distribution", "Ubuntu", "--cd", "~",
                                   "--", "tmux", "new", "-A", "-s", "main" } },
  { label = "Mac (ssh)",  args = { "ssh.exe", "mac" } },
  { label = "Mac + tmux", args = { "ssh.exe", "-t", "mac", "tmux new -A -s main" } },
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
  { key = "d", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "D", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
  { key = "LeftArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "DownArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
  { key = "UpArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act.PasteFrom("Clipboard"),
  },
}

return config
