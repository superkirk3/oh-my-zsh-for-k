## -*- mode: sh -*-

if [[ "$TERM" == dumb ]]; then
    unsetopt zle prompt_cr prompt_subst
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='$'
    return
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_TITLE="true"

if [[ ! -d "$ZSH" ]]; then
  print -u2 "oh-my-zsh is not installed at $ZSH. Run windows/install-wsl.sh first."
  return 1
fi

plugin_dir="$ZSH_CUSTOM/plugins"
theme_dir="$ZSH_CUSTOM/themes"

clone_if_missing() {
  local target=$1
  local repo=$2

  if [[ ! -d "$target" ]]; then
    git clone --depth 1 "$repo" "$target"
  fi
}

if (( $+commands[git] )); then
  clone_if_missing "$plugin_dir/zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
  clone_if_missing "$plugin_dir/zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
  clone_if_missing "$plugin_dir/zsh-completions" "https://github.com/zsh-users/zsh-completions"
  clone_if_missing "$plugin_dir/fzf-tab" "https://github.com/Aloxaf/fzf-tab"
  clone_if_missing "$plugin_dir/alias-tips" "https://github.com/djui/alias-tips.git"
  clone_if_missing "$plugin_dir/git-open" "https://github.com/paulirish/git-open.git"
  clone_if_missing "$theme_dir/powerlevel10k" "https://github.com/romkatv/powerlevel10k.git"
fi

plugins=(
    git
    gitignore
    web-search
    encode64
    docker
    docker-compose
    tmux
    history
    extract
    fzf
    fzf-tab
    aws
    alias-tips
    git-open
    globalias
    terraform
    command-not-found
    common-aliases
    gh
    magic-enter
    zsh-navigation-tools
    history-substring-search
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

remove_plugin() {
  plugins=(${plugins:#$1})
}

(( $+commands[docker] )) || remove_plugin docker
(( $+commands[docker-compose] || $+commands[docker] )) || remove_plugin docker-compose
(( $+commands[tmux] )) || remove_plugin tmux
(( $+commands[fzf] )) || remove_plugin fzf
(( $+commands[aws] )) || remove_plugin aws
(( $+commands[terraform] )) || remove_plugin terraform
(( $+commands[gh] )) || remove_plugin gh

[[ -d "$plugin_dir/fzf-tab" ]] || remove_plugin fzf-tab
[[ -d "$plugin_dir/alias-tips" ]] || remove_plugin alias-tips
[[ -d "$plugin_dir/git-open" ]] || remove_plugin git-open
[[ -d "$plugin_dir/zsh-autosuggestions" ]] || remove_plugin zsh-autosuggestions
[[ -d "$plugin_dir/zsh-completions" ]] || remove_plugin zsh-completions
[[ -d "$plugin_dir/zsh-syntax-highlighting" ]] || remove_plugin zsh-syntax-highlighting

export HISTFILE="$TRU_HISTFILE"
export HISTSIZE=500000
export SAVEHIST=500000

autoload -Uz compinit
compinit

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
else
  [[ -r /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
  [[ -r /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

typeset -g FZF_COLOR_OPTS='--color=fg:#e6edf3,bg:-1,hl:#ffd866,fg+:#ffffff,bg+:#334155,hl+:#ffe082,info:#8ab4f8,prompt:#e6edf3,pointer:#8ab4f8,marker:#7ee787,spinner:#8ab4f8,header:#c9d1d9,query:#f8fafc,border:#5c6370'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '%F{111}[%d]%f'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' fzf-flags ${(z)FZF_COLOR_OPTS}
if (( $+commands[tmux] )); then
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
else
  zstyle ':fzf-tab:*' fzf-command fzf
fi
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'if command -v exa >/dev/null 2>&1; then exa -1 --color=always $realpath; else ls -1 --color=always $realpath; fi'

source "$ZSH/oh-my-zsh.sh"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=99,underline"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

GLOBALIAS_FILTER_VALUES=(ls ll mv cp grep rm emacs tmux fzf)
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias tip: "
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="_ emacs ll"

export VISUAL="$EDITOR_PATH/EDITOR"
export EDITOR="$VISUAL"
alias em="${EDITOR}"

user_emacs_command() {
    if (( $+commands[emacs] )); then
        print -r -- "$commands[emacs]"
    else
        return 1
    fi
}

user_emacsclient_command() {
    if (( $+commands[emacsclient] )); then
        print -r -- "$commands[emacsclient]"
    else
        return 1
    fi
}

user_emacs_server_running() {
    local emacsclient_cmd
    emacsclient_cmd=$(user_emacsclient_command 2>/dev/null || true)
    [[ -n "$emacsclient_cmd" ]] || return 1
    "$emacsclient_cmd" --eval t >/dev/null 2>&1
}

user_emacs_eval_async() {
    local emacsclient_cmd emacs_cmd
    emacsclient_cmd=$(user_emacsclient_command 2>/dev/null || true)
    emacs_cmd=$(user_emacs_command 2>/dev/null || true)

    if [[ -n "$emacsclient_cmd" ]] && user_emacs_server_running; then
        "$emacsclient_cmd" --no-wait --eval "${1:-nil}" >/dev/null 2>&1 &!
    elif [[ -n "$emacs_cmd" ]]; then
        "$emacs_cmd" --eval "${1:-nil}" >/dev/null 2>&1 &!
    else
        print -u2 "Emacs is not installed."
        return 1
    fi
}

user_emacs_open() {
    local emacsclient_cmd emacs_cmd
    emacsclient_cmd=$(user_emacsclient_command 2>/dev/null || true)
    emacs_cmd=$(user_emacs_command 2>/dev/null || true)

    if [[ -n "$emacsclient_cmd" ]] && user_emacs_server_running; then
        "$emacsclient_cmd" --no-wait "$@" >/dev/null 2>&1 &!
    elif [[ -n "$emacs_cmd" ]]; then
        "$emacs_cmd" "$@" >/dev/null 2>&1 &!
    else
        print -u2 "Emacs is not installed."
        return 1
    fi
}

e() {
    local tmp_file

    if [[ "$1" == "-" ]]; then
        tmp_file="$(mktemp /tmp/emacsstdinXXX)"
        cat >"$tmp_file"
        user_emacs_open "$tmp_file"
    else
        user_emacs_open "$@"
    fi
}

magit() {
    user_emacs_eval_async "(magit-status)"
}

emacsk() {
    local emacsclient_cmd
    emacsclient_cmd=$(user_emacsclient_command 2>/dev/null || true)
    [[ -n "$emacsclient_cmd" ]] || { print -u2 "emacsclient is not installed."; return 1; }
    "$emacsclient_cmd" --eval "(progn (save-some-buffers) (kill-emacs))"
}

bindkey -e
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_FUZZY=1
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

user_proxy() {
    if [[ "$1" == "on" ]]; then
        export https_proxy="${2:-http://127.0.0.1:7890}"
        export http_proxy="${2:-http://127.0.0.1:7890}"
        export all_proxy="${2:-socks5://127.0.0.1:7890}"
    else
        unset https_proxy http_proxy all_proxy
    fi
}

user_proxy off

if (( $+commands[wslview] )) && ! (( $+commands[xdg-open] )); then
    xdg-open() {
        wslview "$@"
    }
fi

export GOPATH="${GOPATH:-$HOME/go}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-en_US.UTF-8}"
export AWS_PAGER=""

autoload -U +X bashcompinit && bashcompinit
[[ -r ~/.config/broot/launcher/bash/br ]] && source ~/.config/broot/launcher/bash/br

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

zle -N fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept
bindkey '^[g' fzf-cd-widget

export FZF_DEFAULT_OPTS="$FZF_COLOR_OPTS
       --no-height --no-reverse
       --bind alt-a:toggle-all
       --bind ctrl-t:toggle-preview
       --bind=ctrl-alt-j:preview-down
       --bind=ctrl-alt-k:preview-up
"
export FZF_CTRL_T_OPTS="--preview '(batcat --color=always --style=numbers {} 2>/dev/null || bat --color=always --style=numbers {} 2>/dev/null || cat {} || tree -C {}) 2>/dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_G_OPTS="--preview 'tree -C {} | head -200'"
export FZF_TMUX_OPTS='-p 80%'

fif() {
    if [[ ! "$#" -gt 0 ]]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages "$1" |
        fzf --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

_tru_fzf-snippet() {
    emulate -L zsh
    setopt local_options no_shwordsplit null_glob pipefail

    local snippets_dir=${SNIPPETS_PATH%/}
    local -a snippet_files
    local file name tags preview_cmd preview key selected filename body
    local body_lines screen_width gap max_name_width name_width desc_width display_tags

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
'if command -v batcat >/dev/null 2>&1; then\n'\
"  batcat --color=always --language bash --plain -- \"$snippets_dir/\$file\"\n"\
'elif command -v bat >/dev/null 2>&1; then\n'\
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
(( ${KEYTIMEOUT:-40} < ${FZF_SNIPPETS_KEYTIMEOUT:-80} )) && KEYTIMEOUT=${FZF_SNIPPETS_KEYTIMEOUT:-80}
for keymap in emacs viins vicmd; do
    bindkey -M $keymap "^X'" _tru_fzf-snippet
    bindkey -M $keymap "^[^[" _tru_fzf-snippet
    bindkey -M $keymap "^[x" _tru_fzf-snippet
done

_jump_to_tabstop_in_snippet() {
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

is_in_git_repo() {
  git rev-parse HEAD >/dev/null 2>&1
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

awsp() {
    export AWS_PROFILE="$(aws-profiles | fzf --height 30% --inline-info)"
}

aws-profiles() {
    grep '\[' ~/.aws/credentials 2>/dev/null | grep -v '#' | tr -d '[]'
}

addspace_() {
    BUFFER=" $BUFFER"
    CURSOR=$#BUFFER
}

zle -N addspace_
bindkey "^s" addspace_

if [[ -r "$DOTDIR/p10k_wsl.zsh" ]]; then
    source "$DOTDIR/p10k_wsl.zsh"
elif [[ -r "$DOTDIR/../p10k_rainbow.zsh" ]]; then
    source "$DOTDIR/../p10k_rainbow.zsh"
elif [[ -r "$HOME/.zshrc.d/p10k_rainbow.zsh" ]]; then
    source "$HOME/.zshrc.d/p10k_rainbow.zsh"
fi

typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='WSL'
typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=232
typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=39
unset POWERLEVEL9K_AWS_SHOW_ON_COMMAND

[[ ! -f "$DOTDIR/custom.zsh" ]] || source "$DOTDIR/custom.zsh"

for n ({1..5}) alias -g NF$n="*(.om[$n])"
for n ({1..5}) alias -g ND$n="*(/om[$n])"
for n ({1..5}) alias -g NH$n=".*(.om[$n])"

if [[ -d "$SNIPPETS_PATH" ]]; then
    typeset -a snippet_files
    snippet_files=($SNIPPETS_PATH/*(N))
    (( $#snippet_files )) && chmod +x $snippet_files
fi
