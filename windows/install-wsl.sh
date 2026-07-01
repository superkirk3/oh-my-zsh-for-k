#!/bin/sh
set -eu

info() {
    printf '\033[1;34m%s\033[0m\n' "$*"
}

warn() {
    printf '\033[1;33m%s\033[0m\n' "$*" >&2
}

die() {
    printf '\033[1;31m%s\033[0m\n' "$*" >&2
    exit 1
}

backup_path() {
    path=$1
    if [ -e "$path" ] && [ ! -L "$path" ]; then
        backup="${path}.bak.$(date +%Y%m%d%H%M%S)"
        mv "$path" "$backup"
        warn "Backed up $path to $backup"
    elif [ -L "$path" ]; then
        rm "$path"
    fi
}

clone_if_missing() {
    target=$1
    repo=$2

    if [ ! -d "$target" ]; then
        git clone --depth 1 "$repo" "$target"
    fi
}

case "$(uname -s)" in
    Linux) ;;
    *) die "This installer is for WSL Ubuntu/Debian. Run it inside WSL, not macOS or Windows." ;;
esac

if ! grep -qi microsoft /proc/version 2>/dev/null && [ -z "${WSL_DISTRO_NAME:-}" ]; then
    warn "This does not look like WSL. Continuing because it is still Linux."
fi

if ! command -v apt-get >/dev/null 2>&1; then
    die "apt-get not found. This first version supports Ubuntu/Debian WSL only."
fi

script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd)
repo_dir=$(CDPATH= cd "$script_dir/.." && pwd)

info "Installing base packages"
sudo apt-get update
sudo apt-get install -y \
    zsh git curl ca-certificates unzip \
    openssh-client \
    fzf tmux ripgrep bat tree jq sqlite3 \
    build-essential locales

sudo apt-get install -y wslu || warn "wslu is not available. git-open may need manual browser setup."

if ! locale -a 2>/dev/null | grep -q '^en_US\.utf8$'; then
    info "Generating en_US.UTF-8 locale"
    sudo locale-gen en_US.UTF-8 || true
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing oh-my-zsh"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    info "oh-my-zsh already installed"
fi

zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$zsh_custom/plugins" "$zsh_custom/themes"

info "Installing zsh plugins and powerlevel10k"
clone_if_missing "$zsh_custom/plugins/zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
clone_if_missing "$zsh_custom/plugins/zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
clone_if_missing "$zsh_custom/plugins/zsh-completions" "https://github.com/zsh-users/zsh-completions"
clone_if_missing "$zsh_custom/plugins/fzf-tab" "https://github.com/Aloxaf/fzf-tab"
clone_if_missing "$zsh_custom/plugins/alias-tips" "https://github.com/djui/alias-tips.git"
clone_if_missing "$zsh_custom/plugins/git-open" "https://github.com/paulirish/git-open.git"
clone_if_missing "$zsh_custom/themes/powerlevel10k" "https://github.com/romkatv/powerlevel10k.git"

chmod +x "$script_dir/EDITOR"

if command -v powershell.exe >/dev/null 2>&1 && command -v wslpath >/dev/null 2>&1; then
    info "Copying WezTerm config to Windows profile"
    wezterm_src=$(wslpath -w "$script_dir/wezterm.lua")
    powershell.exe -NoProfile -Command "Copy-Item -LiteralPath '$wezterm_src' -Destination \"\$env:USERPROFILE\\.wezterm.lua\" -Force" \
        || warn "Could not copy WezTerm config automatically. See windows/README.md for the manual copy command."
fi

info "Linking zsh config"
backup_path "$HOME/.zshrc"
backup_path "$HOME/.zshenv"
ln -s "$script_dir/dot.zshrc" "$HOME/.zshrc"
ln -s "$script_dir/.zshenv" "$HOME/.zshenv"

if [ ! -e "$HOME/.zshrc.d" ]; then
    ln -s "$repo_dir" "$HOME/.zshrc.d"
fi

if command -v chsh >/dev/null 2>&1 && [ "${SHELL:-}" != "$(command -v zsh)" ]; then
    info "Setting zsh as default shell"
    chsh -s "$(command -v zsh)" || warn "chsh failed. You can run: chsh -s $(command -v zsh)"
fi

info "Running syntax checks"
zsh -n "$script_dir/dot.zshrc"
sh -n "$script_dir/EDITOR"

cat <<EOF

Done.

Next steps:
1. Restart WSL from PowerShell:
   wsl --shutdown
2. Open WezTerm.
3. Validate startup:
   zsh -i -c exit

EOF
