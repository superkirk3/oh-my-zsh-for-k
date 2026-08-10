## -*- mode: sh -*-

if [ "$TERM" = dumb ]; then
    unsetopt zle prompt_cr prompt_subst
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='$'
else

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zmodload zsh/zprof    # debug

# homebrew bin path
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME="dstufft"
# ZSH_THEME="random"
# ZSH_THEME="Gentoo"
# ZSH_THEME="murilasso"
# ZSH_THEME="spaceship"
# ZSH_THEME="pure"
# ZSH_THEME="refined"
# ZSH_THEME="bira"
# ZSH_THEME="spaceship"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Point the oh-my-zsh tmux plugin at the full gpakosz entrypoint so it
# sources ~/.tmux.conf.local as an override instead of treating it as the
# entire config.
export ZSH_TMUX_CONFIG="$HOME/.tmux.conf"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions ]]; then
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
fi

# if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search ]]; then
#     git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
# fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-histdb ]]; then
    git clone https://github.com/larkery/zsh-histdb ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-histdb
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/history-sync ]]; then
    git clone https://github.com/wulfgarpro/history-sync.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/history-sync
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z.lua ]]; then
   git clone https://github.com/skywind3000/z.lua ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z.lua
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoupdate ]]; then
   git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoupdate
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/history-search-multi-word ]]; then
   git clone https://github.com/zdharma/history-search-multi-word.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/history-search-multi-word
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips ]]; then
   git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open ]]; then
   git clone https://github.com/paulirish/git-open.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab ]]; then
   git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
fi

# if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt ]]; then
#    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
#    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
   git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/h ]]; then
    git clone https://github.com/paoloantinori/hhighlighter.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/h
    [[ -f ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/h/h.sh ]] && mv ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/h/h.sh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/h/h.plugin.zsh
fi

# https://github.com/kaplanelad/shellfirm
#if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/shellfirm ]]; then
#    git clone https://github.com/kaplanelad/shellfirm/ ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/shellfirm
#    ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/shellfirm/shell-plugins/shellfirm.plugin.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/shellfirm/shellfirm.plugin.zsh
#fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    h
    git
    # git-extras
    gitignore
    macos
    autojump
    web-search
    encode64
    #npm
    #node
    brew
    docker
    docker-compose
    #docker-machine
    #laravel5
    #vagrant
    tmux
    emoji
    #colorize
    history
    #per-directory-history
    extract
    #ansible
    history-sync
    fzf
    #z.lua
    #autoupdate
    #history-search-multi-word
    fzf-tab
    iterm2
    aws
    alias-tips
    # emacs
    git-open
    globalias
    # ripgrep
    terraform
    thefuck
    command-not-found
    common-aliases
    gh
    magic-enter
    # shellfirm
    # zsh_reload
    zsh-navigation-tools
    history-substring-search
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

if ! (( $+commands[autojump] )); then
    plugins=(${plugins:#autojump})
fi

if ! (( $+commands[tmux] )); then
    plugins=(${plugins:#tmux})
fi

if ! (( $+commands[fzf] )); then
    plugins=(${plugins:#fzf})
fi

if ! (( $+commands[thefuck] )); then
    plugins=(${plugins:#thefuck})
fi

export HISTFILE=$TRU_HISTFILE
export HISTSIZE=500000
export SAVEHIST=500000

# https://github.com/Aloxaf/fzf-tab/issues/167#issuecomment-737235400
autoload -Uz compinit; compinit
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
else
  [[ -r /opt/homebrew/opt/fzf/shell/completion.zsh ]] && source /opt/homebrew/opt/fzf/shell/completion.zsh
  [[ -r /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

# ── NBA 配色主题 ──────────────────────────────────────────────────────────
# themes/*.theme 是纯 name="value" 赋值,tmux 和 zsh 共用同一份文件。
# 切换:tru-theme(fzf 选择器)/ tru-theme celtics / tru-theme random
typeset -g TRU_THEMES_DIR="${TRU_THEMES_DIR:-$DOTDIR/themes}"

_tru_theme_load() {
    local f=${1:-$TRU_THEMES_DIR/current.theme}
    [[ -r $f ]] || return 1
    source $f
}

# 发一条 OSC。在 tmux 里必须套 passthrough 才能改到外层终端(需 allow-passthrough on)
_tru_theme_osc() {
    if [[ -n ${TMUX:-} ]]; then
        printf '\ePtmux;\e\e]%s\a\e\\' "$1"
    else
        printf '\e]%s\a' "$1"
    fi
}

_tru_theme_apply_term() {
    local i var
    for i in {0..15}; do
        var="tru_term_color$i"
        [[ -n ${(P)var:-} ]] && _tru_theme_osc "4;$i;${(P)var}"
    done
    [[ -n ${tru_term_fg:-}     ]] && _tru_theme_osc "10;$tru_term_fg"
    [[ -n ${tru_term_bg:-}     ]] && _tru_theme_osc "11;$tru_term_bg"
    [[ -n ${tru_term_cursor:-} ]] && _tru_theme_osc "12;$tru_term_cursor"
}

_tru_theme_fzf_opts() {
    [[ -n ${tru_term_fg:-} ]] || return 1
    print -r -- "--color=fg:${tru_term_fg},bg:-1,hl:${tmux_conf_theme_colour_5},fg+:${tru_term_color15},bg+:${tmux_conf_theme_colour_2},hl+:${tmux_conf_theme_colour_5},info:${tru_term_color12},prompt:${tmux_conf_theme_colour_5},pointer:${tmux_conf_theme_colour_5},marker:${tru_term_color10},spinner:${tru_term_color12},header:${tru_term_color8},query:${tru_term_fg},border:${tmux_conf_theme_colour_4}"
}

tru-theme() {
    emulate -L zsh
    local dir=$TRU_THEMES_DIR cur="" pick=${1:-}
    [[ -L $dir/current.theme ]] && cur=${${$(readlink $dir/current.theme):t}:r}
    local -a names; names=(${dir}/*.theme(N:t:r)); names=(${names:#current})
    (( $#names )) || { print -ru2 -- "tru-theme: $dir 下没有主题文件"; return 1 }

    case $pick in
        -h|--help)
            print -r -- "tru-theme            fzf 选择器(带实时预览)"
            print -r -- "tru-theme <team>     直接切换,如 tru-theme celtics"
            print -r -- "tru-theme random     随机来一个"
            print -r -- "tru-theme current    打印当前主题"
            print -r -- "tru-theme list       列出全部"
            print -r -- ""
            print -r -- "可选:${(j:, :)names}"
            return 0 ;;
        current) print -r -- "${cur:-(none)}"; return 0 ;;
        list|-l|--list)
            local n; for n in $names; do
                [[ $n == $cur ]] && print -r -- "* $n" || print -r -- "  $n"
            done; return 0 ;;
        random) pick=${names[RANDOM % $#names + 1]} ;;
        "") pick=$(print -rl -- $names | fzf --height=70% --reverse \
                    --prompt='NBA theme> ' --preview-window=up:16 \
                    --preview "$dir/preview $dir/{}.theme") || return 130 ;;
    esac

    [[ -r $dir/$pick.theme ]] || { print -ru2 -- "tru-theme: 没有这个主题: $pick"; return 1 }
    ln -sfn $pick.theme $dir/current.theme
    _tru_theme_load $dir/$pick.theme || return 1

    # tmux 必须先重载:allow-passthrough 是重载时才打开的,顺序反了的话
    # 下面发的 OSC 会被 tmux 直接吞掉,终端配色一次都刷不上。
    if [[ -n ${TMUX:-} ]]; then
        # split_statusbar 把原始 status-format 缓存进 [6]/[7],把 status-left/right
        # 缓存进 @status-*-default,且只在缓存为空时重建;@hide-statusbar-mode-setto=off
        # 时每次重载都从缓存恢复 status-left,不失效掉左右两段就会停在旧主题配色。
        #
        # /!\ 必须用 set -gu status-format 整体复位,不能只清 [6]。
        #     status-format[0] 平时是"已拆分"状态(窗口列表已被 sed 掉),只清 [6] 的话,
        #     状态栏每 status-interval 渲染一次会重跑 split_statusbar_on,它撞见空缓存就
        #     把当前这个已拆分的 [0] 当成原始值缓存下来 —— 窗口标签从此永久消失。
        #     复位成 tmux 内置默认(必定含窗口列表)就不存在这个竞态。
        tmux set -gu status-format
        tmux set -gu @status-left-default
        tmux set -gu @status-right-default
        if ! tmux source-file ~/.tmux.conf; then
            print -ru2 -- "tru-theme: tmux 配置重载失败,tmux 配色未更新"
        fi
    fi
    _tru_theme_apply_term

    # 首次调用时记下不含配色的基础 opts;fzf 里后出现的 --color 生效,故追加即可
    typeset -g _TRU_FZF_BASE=${_TRU_FZF_BASE-$FZF_DEFAULT_OPTS}
    local o; o=$(_tru_theme_fzf_opts) && {
        typeset -g FZF_COLOR_OPTS=$o
        export FZF_DEFAULT_OPTS="$_TRU_FZF_BASE $o"
    }
    print -r -- "→ ${tru_theme_name} — ${tru_theme_desc}"
}

# 启动时载入并应用当前主题。tmux 里也照发:新开的终端窗口用的是 iTerm2 profile
# 的颜色,不主动刷一次就永远对不上主题。20 条 OSC 而已,重复应用是幂等的。
_tru_theme_load && _tru_theme_apply_term

# fzf-tab
typeset -g FZF_COLOR_OPTS='--color=fg:#e6edf3,bg:-1,hl:#ffd866,fg+:#ffffff,bg+:#334155,hl+:#ffe082,info:#8ab4f8,prompt:#e6edf3,pointer:#8ab4f8,marker:#7ee787,spinner:#8ab4f8,header:#c9d1d9,query:#f8fafc,border:#5c6370'
# 主题存在时用主题配色覆盖上面的默认值
_tru_theme_fzf_opts >/dev/null 2>&1 && typeset -g FZF_COLOR_OPTS="$(_tru_theme_fzf_opts)"
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags ${(z)FZF_COLOR_OPTS} '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:exa' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '%F{111}[%d]%f'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ":fzf-tab:*" fzf-flags ${(z)FZF_COLOR_OPTS}
if (( $+commands[tmux] )); then
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup # tmux 3.2
else
  zstyle ':fzf-tab:*' fzf-command fzf
fi
#zstyle ':fzf-tab:*' fzf-command 'fzf-tmux'
# zstyle ':fzf-tab:*' switch-group ',' '.'

# common-aliases defines a global alias P that expands to pygmentize.
# If it survives from a previous load, re-sourcing ~/.zshrc can break
# oh-my-zsh internals that use a bare P option token.
unalias P 2>/dev/null
source $ZSH/oh-my-zsh.sh
if ! (( $+commands[pygmentize] )); then
  unalias P 2>/dev/null
fi
# Customize to your needs...

unalias h

# https://github.com/zsh-users/zsh-autosuggestions#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=99,underline"
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_COMPLETION_IGNORE='( |man |pikaur -S )*'

# _per-directory-history-set-global-history  # set per directory default to glboal

# This query will find the most frequently issued command
# that is issued in the current directory or any subdirectory.
# You can get other behaviours by changing the query, for example
_zsh_autosuggest_strategy_histdb_top_here() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where places.dir LIKE '$(sql_escape $PWD)%'
and commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv order by count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}

# https://www.dev-diaries.com/blog/terminal-history-auto-suggestions-as-you-type/
# This will find the most frequently issued command issued exactly in this directory,
# or if there are no matches it will find the most frequently issued command in any directory.
# You could use other fields like the hostname to restrict to suggestions on this host, etc.
_zsh_autosuggest_strategy_histdb_top() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv
order by places.dir != '$(sql_escape $PWD)', count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}

# Query to pull in the most recent command if anything was found similar
# in that directory. Otherwise pull in the most recent command used anywhere
# Give back the command that was used most recently
_zsh_autosuggest_strategy_histdb_top_fallback() {
    local query="
    select commands.argv from
    history left join commands on history.command_id = commands.rowid
    left join places on history.place_id = places.rowid
    where places.dir LIKE
        case when exists(select commands.argv from history
        left join commands on history.command_id = commands.rowid
        left join places on history.place_id = places.rowid
        where places.dir LIKE '$(sql_escape $PWD)'
        AND commands.argv LIKE '$(sql_escape $1)%')
            then '$(sql_escape $PWD)'
            else '%'
            end
    and commands.argv LIKE '$(sql_escape $1)%'
    order by places.dir LIKE '$(sql_escape $PWD)' desc,
    history.id desc
    limit 1"
    suggestion=$(_histdb_query "$query")
}

#ZSH_AUTOSUGGEST_STRATEGY=(histdb_top_here histdb_top_fallback)
#ZSH_AUTOSUGGEST_STRATEGY=(histdb_top)
#ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_STRATEGY=(histdb_top_fallback history completion)

# https://github.com/larkery/zsh-histdb/pull/31
HISTDB_TABULATE_CMD=(sed -e $'s/\x1f/\t/g')
alias histdb2='HISTDB_TABULATE_CMD=(sed -e $"s/.*\x1f//") histdb'

user_show_local_history() {
    # limit="${1:-10}"
    # local query="
    #     select history.start_time, commands.argv
    #     from history left join commands on history.command_id = commands.rowid
    #     left join places on history.place_id = places.rowid
    #     where places.dir LIKE '$(sql_escape $PWD)%'
    #     order by history.start_time desc
    #     limit $limit
    # "
    local query="
        select
        replace(commands.argv, '
', ' \\n') as cmd
        from
        history left join commands on history.command_id = commands.rowid
        left join places on history.place_id = places.rowid
        where places.dir LIKE
            case when exists(select commands.argv from history
            left join commands on history.command_id = commands.rowid
            left join places on history.place_id = places.rowid
            where places.dir LIKE '$(sql_escape $PWD)'
            AND commands.argv LIKE '$(sql_escape $1)%')
                then '$(sql_escape $PWD)'
                else '%'
                end
        and commands.argv LIKE '$(sql_escape $1)%'
        group by commands.argv
        order by places.dir LIKE '$(sql_escape $PWD)' desc,
        history.id desc
        limit 1000
    "
    results=$(_histdb_query "$query")
    #echo -e `echo -n "$results" | fzf-tmux -p 90% -m --cycle`
    echo "`_histdb_query "$query" | fzf-tmux -p 90% -m --cycle`"
}

### zsh-histdb
[[ -r $HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh ]] && source $HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh
autoload -Uz add-zsh-hook
# add-zsh-hook precmd histdb-update-outcome
### end zsh-histdb

# globalias
GLOBALIAS_FILTER_VALUES=(ls ll mv cp grep rm emacs tmux fzf)

export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias tip: "
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="_ emacs ll"

# Add em alias for macOS
# PR Merged!
if [[ "$(uname)" == 'Darwin' ]]; then
    alias em="emacs"
    #export EDITOR="emacs"
    # export EDITOR='/opt/homebrew/bin/emacs -nw -Q'
    #export VISUAL="emacs"
    # emacs on mac
    # export EDITOR="emacsclient -t"                  # $EDITOR should open in terminal
    # export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI with non-daemon as alternate
    # https://emacs.stackexchange.com/questions/60339/using-emacsclient-for-visual-raises-end-of-file-during-parsing
    export VISUAL="$EDITOR_PATH/EDITOR"
    export EDITOR=$VISUAL
else
    export EDITOR="emacs"
    # workaround for https://github.com/robbyrussell/oh-my-zsh/pull/5714
    # alias emacs="te"
fi

user_emacs_command() {
    if [[ -x "/Applications/Emacs.app/Contents/MacOS/Emacs" ]]; then
        print -r -- "/Applications/Emacs.app/Contents/MacOS/Emacs"
    elif (( $+commands[emacs] )); then
        print -r -- "$commands[emacs]"
    elif [[ -x /opt/homebrew/bin/emacs ]]; then
        print -r -- /opt/homebrew/bin/emacs
    elif [[ -x /usr/local/bin/emacs ]]; then
        print -r -- /usr/local/bin/emacs
    else
        return 1
    fi
}

user_emacsclient_command() {
    if [[ -x "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient" ]]; then
        print -r -- "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
    elif (( $+commands[emacsclient] )); then
        print -r -- "$commands[emacsclient]"
    elif [[ -x /opt/homebrew/bin/emacsclient ]]; then
        print -r -- /opt/homebrew/bin/emacsclient
    elif [[ -x /usr/local/bin/emacsclient ]]; then
        print -r -- /usr/local/bin/emacsclient
    else
        return 1
    fi
}

user_emacsclient_eval() {
    local emacsclient_cmd emacs_cmd
    emacsclient_cmd=$(user_emacsclient_command) || return 1
    emacs_cmd=$(user_emacs_command 2>/dev/null || true)

    if [[ -n "$emacs_cmd" ]]; then
        "$emacsclient_cmd" --alternate-editor "$emacs_cmd" "$@"
    else
        "$emacsclient_cmd" "$@"
    fi
}

user_emacs_frame_eval() {
    cat <<EOF
(when (display-graphic-p)
  (when (fboundp 'select-frame-set-input-focus)
    (select-frame-set-input-focus (selected-frame)))
  (when (fboundp 'x-focus-frame)
    (ignore-errors (x-focus-frame (selected-frame))))
  (when (fboundp 'ns-do-applescript)
    (ignore-errors
      (ns-do-applescript "tell application \\"Emacs\\" to activate"))))
EOF
}

user_emacs_eval_form() {
    local body=${1:-nil}
    printf '(progn %s %s)\n' "$(user_emacs_frame_eval)" "$body"
}

user_emacs_server_running() {
    local emacsclient_cmd
    emacsclient_cmd=$(user_emacsclient_command 2>/dev/null || true)
    [[ -n "$emacsclient_cmd" ]] || return 1
    "$emacsclient_cmd" --eval t > /dev/null 2>&1
}

user_emacs_eval_async() {
    local emacsclient_cmd emacs_cmd eval_form
    eval_form=$(user_emacs_eval_form "${1:-nil}")
    emacsclient_cmd=$(user_emacsclient_command 2>/dev/null || true)
    emacs_cmd=$(user_emacs_command 2>/dev/null || true)

    if [[ -n "$emacsclient_cmd" ]] && user_emacs_server_running; then
        "$emacsclient_cmd" --no-wait --eval "$eval_form" > /dev/null 2>&1 &!
    elif [[ -n "$emacs_cmd" ]]; then
        "$emacs_cmd" --eval "$eval_form" > /dev/null 2>&1 &!
    else
        print -u2 "Emacs is not installed."
        return 1
    fi
}

user_emacs_open() {
    local emacs_cmd emacsclient_cmd
    emacs_cmd=$(user_emacs_command 2>/dev/null || true)
    emacsclient_cmd=$(user_emacsclient_command 2>/dev/null || true)

    if [[ -n "$emacsclient_cmd" ]] && user_emacs_server_running; then
        "$emacsclient_cmd" --no-wait "$@" > /dev/null 2>&1 &!
        user_emacs_eval_async nil
        return 0
    fi

    if [[ -z "$emacs_cmd" ]]; then
        print -u2 "Emacs is not installed."
        return 1
    fi

    "$emacs_cmd" --eval "$(user_emacs_eval_form nil)" "$@" > /dev/null 2>&1 &!
}

if [[ "$(uname)" == 'Darwin' ]]; then
    emacs() {
        user_emacs_open "$@"
    }
fi

# ── Syncthing 状态速查(仅 Mac,WSL 上没装 Syncthing)────────────────────────
# 在 WorkHome 里跑 git 前先看一眼:Syncthing 正在写 .git/objects 时执行 git,
# 可能读到写了一半的状态。Windows 侧有同名的 PowerShell 函数。
if [[ "$(uname)" == 'Darwin' ]]; then
    gsync() {
        emulate -L zsh
        local cfg="$HOME/Library/Application Support/Syncthing/config.xml"
        [[ -r $cfg ]] || { print -u2 "找不到 Syncthing 配置"; return 1 }
        local key=$(sed -n 's/.*<apikey>\(.*\)<\/apikey>.*/\1/p' "$cfg" | head -1)
        local f
        for f in workhome drop; do
            curl -sS -H "X-API-Key: $key" \
                 "http://127.0.0.1:8384/rest/db/status?folder=$f" 2>/dev/null |
            python3 -c "
import json,sys
try: d=json.load(sys.stdin)
except Exception: print('  $f  查询失败'); raise SystemExit
ok = d.get('state')=='idle' and d.get('needFiles',0)==0
print('  %-10s %-9s 待传 %-6s %s' % ('$f', d.get('state'), d.get('needFiles'), '✓' if ok else '…'))"
        done
    }
fi

# ── WSL: 把 emacs 转交给 Mac 上的 GUI Emacs ────────────────────────────────
# WSL 里的 emacs 体验差,所以不在本机开,而是 ssh 到 Mac 调 emacsclient,
# 让 Mac 的 Emacs 通过 TRAMP 路径 /ssh:win:<绝对路径> 直接编辑 WSL 里的文件。
#
# 依赖两条 ssh 别名,方向相反,缺一不可:
#   WSL  ~/.ssh/config -> Host mac  (这里用来调 emacsclient)
#   Mac  ~/.ssh/config -> Host win  (TRAMP 回连 WSL 用;建议开 ControlMaster,
#                                    否则每次补全/保存都要重新握手)
# Mac 侧 doom config.el 里要有 (server-start),否则 emacsclient 找不到 socket。
# 注意:不能只判断 $WSL_DISTRO_NAME —— 那个变量只有 wsl.exe 启动的 shell 才有,
# 从外面 ssh 进 WSL 的会话里是空的。用 osrelease 里的 microsoft 标记才可靠。
if [[ "$(uname)" == 'Linux' ]] && \
   { [[ -n "${WSL_DISTRO_NAME:-}" ]] || [[ -d /run/WSL ]] || \
     grep -qi microsoft /proc/sys/kernel/osrelease 2>/dev/null }; then
    : ${REMOTE_EMACS_HOST:=mac}      # WSL -> Mac 的 ssh 别名
    : ${REMOTE_EMACS_BACKREF:=win}   # Mac -> WSL 的 ssh 别名(TRAMP 前缀用)

    emacs() {
        emulate -L zsh
        local -a targets
        local f
        for f in "$@"; do
            [[ $f == -* ]] && continue          # 丢掉 -nw 之类的开关,远端用不上
            targets+=( "/ssh:${REMOTE_EMACS_BACKREF}:${f:a}" )
        done
        (( $#targets )) || targets=( "/ssh:${REMOTE_EMACS_BACKREF}:${PWD}" )

        if ! ssh "$REMOTE_EMACS_HOST" 'emacsclient --eval t' >/dev/null 2>&1; then
            print -u2 "emacs: $REMOTE_EMACS_HOST 上的 Emacs server 没起来,正在启动…"
            ssh "$REMOTE_EMACS_HOST" 'open -a Emacs' >/dev/null 2>&1
            local i
            for i in {1..15}; do
                ssh "$REMOTE_EMACS_HOST" 'emacsclient --eval t' >/dev/null 2>&1 && break
                sleep 1
            done
        fi

        # 走 --eval 而不是直接传文件名:ssh 会话没有 TERM/DISPLAY,emacsclient 会
        # 误以为要自己开 frame 然后报 "Please set the environment variable DISPLAY
        # or TERM"。用 find-file 在已运行的 Emacs 里打开,顺便把窗口切到前台。
        local -a forms
        for f in $targets; do forms+=( "(find-file \"$f\")" ); done
        local lisp="(progn ${(j: :)forms} (select-frame-set-input-focus (selected-frame)))"

        ssh "$REMOTE_EMACS_HOST" "emacsclient --no-wait --eval ${(qq)lisp}" >/dev/null 2>&1 \
            || { print -u2 "emacs: 打开失败,检查 Mac 上的 Emacs 是否在运行"; return 1 }
    }
    alias e=emacs

    # ── 在 WSL 里直接 `cursor .` 打开当前目录 ────────────────────────────────
    # Cursor 装在 Windows 侧,它的 bin 目录不在 WSL 的 PATH 里。
    # 用函数而不是把 /mnt/c/... 加进 PATH —— 9p 挂载慢,会拖累每一次命令查找。
    # 打开后 remote-wsl 扩展自动接管:编辑器进程在 Windows,文件系统是 WSL 的。
    cursor() {
        emulate -L zsh
        local bin
        for bin in /mnt/c/Users/*/AppData/Local/Programs/cursor/resources/app/bin/cursor(N); do
            "$bin" "$@"
            return
        done
        print -u2 "cursor: 没找到 Windows 上的 Cursor"
        return 127
    }

    # ── 借用 Windows 上的 Clash 代理 ────────────────────────────────────────
    # NAT 模式的 WSL 够不到 Windows 的 127.0.0.1,所以只能走网关 IP。
    # 网关每次 WSL 重启都会变(172.x 随机分配),必须动态取,写死必然失效。
    #
    # 前提(缺一不可):
    #   1. Clash Verge 里打开"允许局域网连接"(allow-lan),否则它只绑 127.0.0.1
    #   2. Windows 防火墙放行 7897,且规则限定在 172.16.0.0/12 —— 别对办公网敞开
    #
    # 默认不自动开启:Clash 没运行时设了代理反而让所有请求失败。
    # 想每次自动开,在 ~/.zshrc.local 里加一行 `wsl-proxy on >/dev/null 2>&1`。
    : ${WSL_PROXY_PORT:=7897}
    wsl-proxy() {
        emulate -L zsh
        local gw port=$WSL_PROXY_PORT
        gw=$(ip route | awk '/^default/{print $3; exit}')
        case ${1:-on} in
            on)
                if ! timeout 1 bash -c "echo > /dev/tcp/$gw/$port" 2>/dev/null; then
                    print -u2 "wsl-proxy: $gw:$port 不通"
                    print -u2 "  → 检查 Clash Verge 的\"允许局域网连接\",以及 Windows 防火墙"
                    return 1
                fi
                export http_proxy="http://$gw:$port"  https_proxy="http://$gw:$port"
                export HTTP_PROXY=$http_proxy         HTTPS_PROXY=$https_proxy
                export no_proxy="localhost,127.0.0.1,::1,$gw,192.168.0.0/16"
                export NO_PROXY=$no_proxy
                print "proxy on  -> $gw:$port"
                ;;
            off)
                unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY no_proxy NO_PROXY
                print "proxy off"
                ;;
            status)
                print "http_proxy=${http_proxy:-(未设置)}  网关=$gw"
                ;;
        esac
    }
fi

# tramp mode for zsh: https://www.gnu.org/software/tramp/tramp-emacs.html
# https://github.com/zsh-users/zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_FUZZY=1
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

bindkey -e
if [ -n "$INSIDE_EMACS" ]; then
  # chpwd() { print -P "\033AnSiTc %d" }

  # print -P "\033AnSiTu %n"
  # print -P "\033AnSiTc %d"
  # echo $INSIDE_EMACS
  alias clear='printf "\e]51;Evterm-clear-scrollback\e\\";tput clear'
  export ZSH_THEME="rawsyntax"

  # vterm_prompt_end() {
  #   printf "\e]51;A$(whoami)@$(hostname):$(pwd)\e\\";
  # }
  # PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

else
  if [[ "$TERM_PROGRAM" == iTerm.app ]]; then
    [[ -r "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"
    if typeset -f iterm2_profile > /dev/null && [[ -n "${ITERM2_DEFAULT_PROFILE:-}" ]] && [[ "${ITERM_PROFILE:-}" != "$ITERM2_DEFAULT_PROFILE" ]]; then
      iterm2_profile "$ITERM2_DEFAULT_PROFILE"
    fi
  fi

fi

# doom emacs
if [[ "$(uname)" == 'Darwin' ]]; then
   # export DOOMDIR=$DOOMDIR_MAC
   # export DOOMLOCALDIR=$DOOMLOCALDIR_MAC
   alias doome='doom sync && emacs'
fi

# The emacs or emacsclient command to use
e() {
    local TMP

    if [[ "$1" == "-" ]]; then
        TMP="$(mktemp /tmp/emacsstdinXXX)"
        cat >"$TMP"
        if ! user_emacs_eval_async "(let ((b (create-file-buffer \"my_drafts\"))) (tab-bar-new-tab) (switch-to-buffer b) (insert-file-contents \"${TMP}\") (delete-file \"${TMP}\"))"; then
            rm -f "$TMP"
            return 1
        fi
    else
        if ! user_emacs_open "$@"; then
            return 1
        fi
    fi
}

# https://github.com/akermu/emacs-libvterm/blob/7adecaa48c222f2567d503705547cf239e38fc4b/README.md#shell-side-configuration
vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

user_set_cursor_color() {
    local cursor_color
    cursor_color="${1:-${TERMINAL_CURSOR_COLOR:-#e6e6e6}}"
    vterm_printf "12;${cursor_color}"
}

user_set_cursor_color


# notmuch seach
# https://emacs-china.org/t/topic/305/73?u=tru
export XAPIAN_CJK_NGRAM=1
# FIX OSError: dlopen(libnotmuch.5.dylib, 6): image not found
export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib/:/usr/local/lib/

## If you need to have imagemagick@6 first in your PATH, run:
## For compilers to find imagemagick@6 you may need to set:
## For pkg-config to find imagemagick@6 you may need to set:

# export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/imagemagick@6/lib"
# export CPPFLAGS="-I/usr/local/opt/imagemagick@6/include"
# export PKG_CONFIG_PATH="/usr/local/opt/imagemagick@6/lib/pkgconfig"

magit() {
    if ! user_emacs_eval_async "(magit-status)"; then
        return 1
    fi
}

emacsk() {
    local emacsclient_cmd
    emacsclient_cmd=$(user_emacsclient_command 2>/dev/null || true)

    if [[ -z "$emacsclient_cmd" ]]; then
        print -u2 "emacsclient is not installed."
        return 1
    fi

    "$emacsclient_cmd" --eval "(progn (save-some-buffers) (kill-emacs))"
}

export PS1_backup=$PS1

function user_proxy () {
    local prefix
    if [ "$1" = "on" ]; then
        export https_proxy=127.0.0.1:8888
        export http_proxy=127.0.0.1:8888
        # echo Local HTTP Proxy is enabled.
        prefix="ProxyOn"
    else
        unset https_proxy
        unset http_proxy
        # echo Local HTTP Proxy is disabled.
        prefix=""
    fi
    # export PS1="%K{blue} $prefix $PS1_backup"
    export PS1="$prefix $PS1_backup"
}

user_proxy off

export PATH=/usr/local/bin:/usr/local/opt:$PATH:/opt/local/bin:/opt/local/sbin
PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH="$HOME/.tgenv/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"

# Go path for macOS
if [[ "$(uname)" == 'Darwin' ]]; then
   if [[ "$(uname -m)" == 'arm64' ]]; then
     export GOPATH=$HOME/go
     export GOROOT=/opt/homebrew/opt/go/libexec
     export PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin
   else
     export GOPATH=$HOME/go
     export GOROOT=/usr/local/opt/go/libexec
     export PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin
   fi
fi

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

autoload -U +X bashcompinit && bashcompinit
(( $+commands[mc] )) && complete -o nospace -C $(which mc) mc

# broot
[[ -r ~/.config/broot/launcher/bash/br ]] && source ~/.config/broot/launcher/bash/br

user_upgrade_custom_plugins () {
  printf "\e[1;34m%s\e[0m \n" "Upgrading custom plugins"

  find "${ZSH_CUSTOM}" -type d -name .git | while read d
  do
    p=$(dirname "$d")
    echo -e "\e[0;33m${p}\e[0m"
    if git -C "${p}" pull --rebase --stat origin "$(git -C "${p}" remote show origin 2>/dev/null | awk '/HEAD branch/ {print $NF}')"
    then
      printf "\e[0;92m%s\e[0m\n" "Hooray! $d has been updated and/or is at the current version."
    else
      printf "\e[1;31m%s\e[0m\n" 'There was an error updating. Try again later?'
    fi
    print ""
  done
}

# fzf https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
export FZF_TMUX=1
fzf() {
  if [[ -n "$TMUX" ]] && (( $+commands[fzf-tmux] )); then
    command fzf-tmux -p 80% --cycle "$@"
  else
    command fzf --cycle "$@"
  fi
}

user_fzf_popup() {
  local popup_size=${1:-80%}
  shift || true

  if [[ -n "$TMUX" ]] && (( $+commands[fzf-tmux] )); then
    command fzf-tmux -p "$popup_size" --cycle "$@"
  else
    command fzf --cycle "$@"
  fi
}

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept
bindkey '^[g'  fzf-cd-widget

# export FZF_DEFAULT_OPTS='--no-height --no-reverse --bind alt-a:select-all,alt-A:deselect-all,ctrl-t:toggle-all'
export FZF_DEFAULT_OPTS="$FZF_COLOR_OPTS
       --no-height --no-reverse
       --bind alt-a:toggle-all
       --bind ctrl-t:toggle-preview
       --bind=ctrl-alt-j:preview-down
       --bind=ctrl-alt-k:preview-up
"
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# Full command on preview window
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# preview
export FZF_ALT_G_OPTS="--preview 'tree -C {} | head -200'"
# https://github.com/junegunn/fzf/pull/1946
export FZF_TMUX_OPTS='-p 80%'
# https://stnly.com/fzf-and-rg/
# Setting rg as the default source for fzf
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
# To apply the command to CTRL-T as well
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)"
}

# https://github.com/junegunn/fzf/wiki/examples#searching-file-contents
# fif() {
#   ag --nobreak --nonumbers --noheading . | fzf
# }

fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    local file
    # file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$@" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$@"' {}")" && open "$file"
    file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$@" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$@"' {}")" && echo "$file"
}

fif2() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

_tru_fzf-snippet() {
    emulate -L zsh
    setopt local_options no_shwordsplit null_glob pipefail

    local snippets_dir=${SNIPPETS_PATH%/}
    local -a snippet_files
    local file name tags preview_cmd preview key selected filename body
    local body_lines
    local screen_width gap max_name_width name_width desc_width display_tags

    if [[ -z "$snippets_dir" || ! -d "$snippets_dir" ]]; then
        zle -M "SNIPPETS_PATH is not available: ${SNIPPETS_PATH:-unset}"
        return 1
    fi

    snippet_files=($snippets_dir/*(N))
    if (( ! $#snippet_files )); then
        zle -M "No snippets found in $snippets_dir"
        return 1
    fi

    max_name_width=0
    for file in $snippet_files; do
        name=${file:t}
        (( ${#name} > max_name_width )) && max_name_width=${#name}
    done

    screen_width=${COLUMNS:-120}
    gap=${FZF_SNIPPETS_GAP:-8}
    name_width=${FZF_SNIPPETS_NAME_WIDTH:-$max_name_width}
    (( name_width > max_name_width )) && name_width=$max_name_width
    (( name_width < 24 )) && name_width=24
    desc_width=$(( screen_width - name_width - gap - 4 ))
    (( desc_width < 24 )) && desc_width=24

    preview_cmd=$'file=$(printf "%s" {} | awk -F "\\t" \'{print $NF}\')\n'\
'if command -v bat >/dev/null 2>&1; then\n'\
"  bat --color=always --language bash --plain -- \"$snippets_dir/\$file\"\n"\
'else\n'\
"  sed -n '1,200p' \"$snippets_dir/\$file\"\n"\
'fi'

    preview=$(
      for file in $snippet_files; do
          name=${file:t}
          tags=$(sed -n '2p' "$file")
          display_tags=${tags:-$name}
          printf '%-*.*s%*s\t%s\n' \
              "$desc_width" "$desc_width" "$display_tags" \
              $((name_width + gap)) "$name" \
              "$name"
      done | user_fzf_popup 90% -i --ansi --bind ctrl-/:toggle-preview "$@" \
          --delimiter=$'\t' --with-nth=1 \
          --preview-window up:wrap --preview "$preview_cmd" --expect=alt-enter
    )

    [[ -z "$preview" ]] && return 0

    key=${preview%%$'\n'*}
    selected=${preview#*$'\n'}
    [[ "$selected" == "$preview" ]] && return 0
    filename=${selected##*$'\t'}
    [[ -z "$filename" ]] && return 0

    body=$(sed '1,2d' "$snippets_dir/$filename")
    body_lines=$(print -r -- "$body" | wc -l | tr -d ' ')

    case "$key" in
        alt-enter)
            BUFFER=" $body"
            ;;
        *)
            if (( body_lines < 8 )); then
                BUFFER=" $body"
            else
                chmod +x "$snippets_dir/$filename"
                BUFFER=" . ${(q)filename}"
            fi
            ;;
    esac

    zle reset-prompt
}

zle -N _tru_fzf-snippet
# Give Esc Esc enough time for manual double-taps.
(( ${KEYTIMEOUT:-40} < ${FZF_SNIPPETS_KEYTIMEOUT:-80} )) && KEYTIMEOUT=${FZF_SNIPPETS_KEYTIMEOUT:-80}
for keymap in emacs viins vicmd; do
    bindkey -M $keymap "^X'" _tru_fzf-snippet
    bindkey -M $keymap "^[^[" _tru_fzf-snippet
    bindkey -M $keymap "^[x" _tru_fzf-snippet
done

_jump_to_tabstop_in_snippet() {
    # the idea is to match ${\w+}, and replace
    # that with the empty string, and move the cursor to
    # beginning of the match. If no match found, simply return
    # valid place holders: ${}, ${somealphanumericstr}
    local str=$BUFFER
    local searchstr=''
    [[ $str =~ ([$]\\{[[:alnum:]]*\\}) ]] && searchstr=$MATCH
    [[ -z "$searchstr" ]] && return

    local rest=${str#*$searchstr}
    local pos=$(( ${#str} - ${#rest} - ${#searchstr} ))
    BUFFER=$(echo ${str//${MATCH}/})
    CURSOR=$pos
}
zle -N _jump_to_tabstop_in_snippet
bindkey '^J' _jump_to_tabstop_in_snippet

# https://github.com/junegunn/fzf/wiki/Examples#tmux
user_tmux_ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  user_fzf_popup 88% --border --bind ctrl-/:toggle-preview "$@"
}

fzf_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
  cut -c4- | sed 's/.* -> //'
}

fzf_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

fzf_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

fzf_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

fzf_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
  cut -d$'\t' -f1
}

fzf_gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(fzf_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

bind-git-helper f b t r h s
unset -f bind-git-helper

rgf() {

for arg; do
  case "$arg" in
    --noignore ) FLAG='--no-ignore' ;;
  esac
done

RG_PREFIX="rg $FLAG --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY=$(echo "${*:-}" |  sed 's/--noignore//')

# IFS=: read -ra selected < <(
fzf=$(FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
        fzf --ansi \
        -e -m \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --disabled --query "$INITIAL_QUERY" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --bind "alt-enter:unbind(change,alt-enter)+change-prompt(2. fzf> )+enable-search+clear-query" \
        --bind "ctrl-o:execute-silent:(emacsclient --alternate-editor emacs --eval \"(progn (find-file \\\"\$(echo {} | awk -F ':' '{print \$1}')\\\") (goto-line \$(echo {} | awk -F ':' '{print \$2}')) (forward-char \$(echo {} | awk -F ':' '{print \$3}')) (recenter))\")" \
        --prompt '1. ripgrep> ' \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
)

if [[ -n $fzf ]]; then
    local file line column rest
    file=${fzf%%:*}
    rest=${fzf#*:}
    line=${rest%%:*}
    rest=${rest#*:}
    column=${rest%%:*}
    user_emacs_eval_async "(progn (find-file \"$file\") (goto-line $line) (forward-char $column) (recenter))" > /dev/null 2>&1
fi
}

# github_latest_release_download "Canop/broot"
user_github_latest_release_download() {
    curl -s "https://api.github.com/repos/$1/releases/latest"  | jq -r ".assets[] | select(.name | contains(\"zip\"|\"gz\")) | .browser_download_url"
}

#export AWS_PROFILE=
awsp() {
    export AWS_PROFILE="$(aws-profiles | fzf --height 30% --inline-info)"
}

aws-profiles() {
    grep '\[' ~/.aws/credentials | grep -v '#' | tr -d '[]'
}

export AWS_PAGER=""

addspace_ (){
    BUFFER=" $BUFFER"
    CURSOR=$#BUFFER
}
zle -N addspace_
bindkey "^s" addspace_



# zprof    # debug

# p10k
# https://github.com/romkatv/powerlevel10k/issues/114
function prompt_my_fire_dir() {
  emulate -L zsh
  local split_path=(${(s:/:)${(%):-%~}//\%/%%})
  # 原版配色(f29faa9):饱和紫底 + 黄字,末段亮品红 + 白字。
  # 曾一度改成粉彩(175/182/147/183 + 深灰字 236),不要了。
  local dir_fg_word=3      # 中间各段的字:黄
  local dir_fg_edge=255    # 首尾整段的字:白
  local dir_bg_main=92     # #8700af 暗紫
  local dir_bg_alt=97      # #875faf 中紫
  local dir_bg_leaf=129    # #af00ff 亮品红(当前目录)
  (( $#split_path )) || split_path+=/

  if (( $#split_path == 1)); then
    p10k segment -s SOLO -b $dir_bg_main -f $dir_fg_edge -t $split_path
    return
  fi
  p10k segment -s FIRST -b $dir_bg_main -f $dir_fg_word -t $split_path[1]
  shift split_path
  while (( $#split_path > 1 )); do
    p10k segment -s EVEN -b $dir_bg_alt -f $dir_fg_word -t $split_path[1]
    shift split_path
    (( $#split_path > 1 )) || break
    p10k segment -s ODD -b $dir_bg_main -f $dir_fg_word -t $split_path[1]
    shift split_path
  done
  p10k segment -s LAST -b $dir_bg_leaf -f $dir_fg_edge -t $split_path[1]

}

# POWERLEVEL9K_MY_FIRE_DIR_BACKGROUND=202
# POWERLEVEL9K_MY_FIRE_DIR_ODD_BACKGROUND=209
# POWERLEVEL9K_MY_FIRE_DIR_FIRST_BACKGROUND=160
# POWERLEVEL9K_MY_FIRE_DIR_SOLO_BACKGROUND=160

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

# p10k 配色方案。用 TRU_P10K_STYLE 控制:
#   rainbow(默认) 路径带背景色块,配合 tru-theme 的调色板显示为紫色
#   classic       路径无背景,只有前景色 —— 看起来就是一串灰点
#   lean          最简
#   auto          21:00~05:30 用 classic,其余时间 rainbow(以前的默认行为)
#
# 原先硬编码成 auto,导致同一台机器白天紫、晚上灰,两台机器在不同时间截图
# 看起来像"配色没同步"。默认改成 rainbow,两边任何时候都一致。
: ${TRU_P10K_STYLE:=rainbow}

if [[ $TRU_P10K_STYLE == auto ]]; then
    # https://unix.stackexchange.com/questions/395933/how-to-check-if-the-current-time-is-between-2300-and-0630
    _tru_now=$(date +%H:%M)
    if [[ "$_tru_now" > "21:00" || "$_tru_now" < "05:30" ]]; then
        TRU_P10K_STYLE=classic
    else
        TRU_P10K_STYLE=rainbow
    fi
fi

case $TRU_P10K_STYLE in
    classic) [[ ! -f $DOTDIR/p10k_classic.zsh ]] || source $DOTDIR/p10k_classic.zsh ;;
    lean)    [[ ! -f $DOTDIR/p10k_lean.zsh    ]] || source $DOTDIR/p10k_lean.zsh ;;
    *)       [[ ! -f $DOTDIR/p10k_rainbow.zsh ]] || {
                 source $DOTDIR/p10k_rainbow.zsh
                 POWERLEVEL9K_OS_ICON_BACKGROUND='99'
             } ;;
esac

# Use Unicode separators that render reliably without Nerd Font private glyphs.
typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='·'
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='·'
typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='▶'
typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='◀'
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='▶'
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='◀'

typeset -gA my_fire_dir_icons=(
  "${(b)HOME}"      '🦄'
  "${(b)HOME}/*"    '📁'
  "/etc(|/*)"       '⚙️')

typeset POWERLEVEL9K_MY_FIRE_DIR_{FIRST,SOLO}_VISUAL_IDENTIFIER_EXPANSION='${my_fire_dir_icons[(k)$PWD]:-📂}'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_absolute"
typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=232
# 背景不设,继承 p10k_rainbow 加载后设的 99(紫)
POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='🐲'

# git 段配色不覆盖,用 p10k_rainbow 自带的:干净=2(绿) 有改动=3(黄) 冲突=3 加载中=8。
# 曾一度覆盖成粉彩(116/152/181/189 + 深灰字 236),不要了。
typeset -g POWERLEVEL9K_VCS_PREFIX='on '
typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION=''
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='☘️ '
typeset -g POWERLEVEL9K_TIME_FOREGROUND=236
typeset -g POWERLEVEL9K_TIME_BACKGROUND=153
typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION='🕒'
#POWERLEVEL9K_DIR_BACKGROUND=99
unset POWERLEVEL9K_AWS_SHOW_ON_COMMAND
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=177
typeset -g POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=7
typeset -g POWERLEVEL9K_AWS_DEFAULT_BACKGROUND=202
# typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

function my_git_formatter() {
  emulate -L zsh

  if [[ -n $P9K_CONTENT ]]; then
    typeset -g my_git_format=$P9K_CONTENT
    return
  fi

  local meta='%7F'
  local clean='%0F'
  local modified='%0F'
  local untracked='%0F'
  local conflicted='%1F'
  local branch_icon='☘️ '
  local res

  # Use a brush when there are unstaged edits; otherwise keep the shamrock.
  if (( VCS_STATUS_NUM_UNSTAGED || VCS_STATUS_HAS_UNSTAGED == -1 )); then
    branch_icon='🖌️ '
  fi

  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
    (( $#branch > 32 )) && branch[13,-13]="…"
    res+="${clean}${branch_icon}${branch//\%/%%}"
  fi

  if [[ -n $VCS_STATUS_TAG && -z $VCS_STATUS_LOCAL_BRANCH ]]; then
    local tag=${(V)VCS_STATUS_TAG}
    (( $#tag > 32 )) && tag[13,-13]="…"
    res+="${meta}#${clean}${tag//\%/%%}"
  fi

  [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_LOCAL_BRANCH ]] &&
    res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"

  if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
    res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"
  fi

  (( VCS_STATUS_COMMITS_BEHIND      )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
  (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
  (( VCS_STATUS_COMMITS_AHEAD       )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
  (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  (( VCS_STATUS_STASHES             )) && res+=" ${clean}*${VCS_STATUS_STASHES}"
  [[ -n $VCS_STATUS_ACTION          ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
  (( VCS_STATUS_NUM_CONFLICTED      )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
  (( VCS_STATUS_NUM_STAGED          )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
  (( VCS_STATUS_NUM_UNSTAGED        )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
  (( VCS_STATUS_NUM_UNTRACKED       )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
  (( VCS_STATUS_HAS_UNSTAGED == -1  )) && res+=" ${modified}─"

  typeset -g my_git_format=$res
}
functions -M my_git_formatter 2>/dev/null

# https://github.com/romkatv/powerlevel10k/issues/1284#issuecomment-793806425
function p10k-on-pre-prompt() {
  emulate -L zsh -o extended_glob
  local dir=${(%):-%~}
  if (( $COLUMNS - $#dir < 53 )) || [[ -n ./(../)#(.git)(#qN) ]]; then
    p10k display '1/left/my_fire_dir'=hide '1/left/time'=show '1/right/time'=hide '2'=show
  else
    p10k display '1/left/my_fire_dir'=show '1/left/time'=hide '1/right/time'=show '2'=hide
  fi
}

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  os_icon my_fire_dir vcs time newline
  my_fire_dir newline
  prompt_char
)

#PROMPT_EOL_MARK=''

[[ ! -f $DOTDIR/misc/custom.zsh ]] || source $DOTDIR/misc/custom.zsh

# https://twitter.com/dailyzshtip/status/1466384154778472459
for n ({1..5}) alias -g NF$n="*(.om[$n])"
# e.g. this gives you
# vi NF2   # edit 2nd newest file

# https://twitter.com/dailyzshtip/status/1458483872417583118
for n ({1..5}) alias -g ND$n="*(/om[$n])"
# ND1 # newest dir
# ND2 # 2nd newest dir

for n ({1..5}) alias -g NH$n=".*(.om[$n])"
# NH1 # newest hidden file
# NH2 # 2nd newest hidden file

# make snippets executable (interactive shell only)
if [[ -d $SNIPPETS_PATH ]]; then
    typeset -a snippet_files
    snippet_files=($SNIPPETS_PATH/*(N))
    (( $#snippet_files )) && chmod +x $snippet_files
fi

# end if dumb
fi
export PATH="$HOME/.local/bin:$PATH"
# export ANTHROPIC_API_KEY="..."   # 不要把 key 写进仓库，用 keychain 或 ~/.config 里的本地文件
