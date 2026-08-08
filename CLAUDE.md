# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal dotfiles repo for zsh + tmux + Doom Emacs on macOS. Installed by symlinking generated files into `$HOME` (see `README.org` → `* dot.zsh` → `** Install` for the full fresh-machine bootstrap).

## Architecture: Literate Config via Org-mode

**`README.org` is the source of truth.** It carries `#+auto_tangle: t`, so saving it in Emacs regenerates *every* tracked config file via Org babel tangle. This is the single most important fact about the repo: almost nothing here is meant to be hand-edited as its own file.

Each Org heading declares its tangle target in a `:PROPERTIES:` drawer:

| `README.org` heading | Tangled output | Installed as |
|---|---|---|
| `** Dot zshenv` | `.zshenv` | `~/.zshenv` (symlink) |
| `** Dot zshrc` | `dot.zshrc` | `~/.zshrc` (symlink) |
| `** EDITOR` | `EDITOR` | referenced via `$EDITOR_PATH` |
| `*** doom init.el` | `doom.d/init.el` | `~/.doom.d/init.el` (symlink) |
| `*** doom config.el` | `doom.d/config.el` | `~/.doom.d/config.el` (symlink) |
| `*** doom packages.el` | `doom.d/packages.el` | `~/.doom.d/packages.el` (symlink) |

To find a block's target, search upward from it for the nearest `:header-args: :tangle` line.

### Editing workflow

- **In Emacs**: edit the `README.org` source block. It auto-tangles on save.
- **Outside Emacs**: edit the generated file directly, then apply the identical change to the matching `README.org` block *in the same commit*. A tangle from a stale Org file silently reverts un-synced edits to the generated files.

The `p10k_*.zsh` files and `.tmux.conf.local` are **not** tangled — they are vendored upstream configs, edited directly.

## Validation

No build or test suite. Validate shell changes with:

```sh
zsh -n dot.zshrc          # syntax check (zsh, not sh — uses zsh-only globbing/widgets)
zsh -n .zshenv
sh -n EDITOR              # POSIX sh, deliberately not zsh
zsh -i -c exit            # startup smoke test for interactive-shell regressions
```

For prompt or completion changes also exercise the affected widget in a fresh shell, and check the `TERM=dumb` path (`TERM=dumb zsh -i -c exit`).

## `dot.zshrc` structure

Nearly the entire file lives inside an `if [ "$TERM" = dumb ]; then ... else` guard opened at the top and closed by a bare `fi` near the bottom (marked `# end if dumb`). **New interactive config must land inside the `else` branch**; only PATH-style additions belong after the closing `fi`.

Ordering inside the `else` branch:

1. **p10k instant prompt** — must stay at the top; anything requiring console input goes above it
2. **Plugin auto-install** — clones missing Oh-My-Zsh custom plugins into `${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/`. Several clone blocks are intentionally commented out for plugins that are cloned but not enabled.
3. **Oh-My-Zsh setup** — theme, `plugins=(...)`, history options
4. **zsh-histdb** — SQLite history backend (sourced manually, not via `plugins`), plus the `_zsh_autosuggest_strategy_histdb_*` strategies that back autosuggestions
5. **Emacs integration** — `user_emacs_*` helpers, `e()`, `magit`, `emacsk`, `rgf()` (rg+fzf piping results into emacsclient)
6. **fzf / fzf-tab** — `fif`, `j`, `user_fzf_popup` (tmux popup, requires tmux), `fzf_g*` git widgets bound under `^g^<key>` via `bind-git-helper`
7. **Snippet system** — `_tru_fzf-snippet` widget, bound to `^[^[` (Esc Esc), `^[x` (Alt-x), and `^X'`
8. **PATH / env** — Go, tgenv, Homebrew, local bins
9. **p10k prompt** — sources `$DOTDIR/p10k_classic.zsh` after 21:00 or before 05:30, else `$DOTDIR/p10k_rainbow.zsh`
10. **Local overrides** — sources `$DOTDIR/misc/custom.zsh` last if present

## Snippets

`snippets/` holds ~80 standalone executable scripts, surfaced by the `_tru_fzf-snippet` picker and also on `PATH` (`.zshenv` prepends `$SNIPPETS_PATH`). Format is fixed — the picker shows line 2 as the description:

```sh
#!/bin/zsh
# short description shown in fzf
actual command body...
```

`dot.zshrc` `chmod +x`es everything in `$SNIPPETS_PATH` on interactive startup, so a new snippet needs no manual mode change. `.zshenv` prefers `$DOTDIR/snippets` when it exists and falls back to `${XDG_CONFIG_HOME:-$HOME/.config}/snippets`; override `SNIPPETS_PATH` before `.zshenv` loads to relocate it per-machine.

## Conventions

- Shell functions use a `user_` prefix (`user_emacs_open`, `user_proxy`, `user_upgrade_custom_plugins`); ZLE widgets use a leading underscore (`_tru_fzf-snippet`).
- Four-space indentation in shell blocks; lowercase names except exported env vars.
- Reference plugin paths explicitly as `${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/...`.
- Prefer `$HOME` / `$DOTDIR` over hardcoded absolute user paths.
- Commit subjects are short and lowercase (`update EDITOR`, `add shellfirm plugin`). Note in the PR body whether `README.org` and the tangled files were updated together.

## Deliberately not vendored

- `~/.tmux` — upstream `gpakosz/.tmux` clone; only `.tmux.conf.local` is tracked here. Never commit `~/.tmux/plugins` or `~/.tmux/resurrect`.
- `~/.emacs.d` — upstream Doom clone; only `doom.d/` is tracked.
- `misc/*` — gitignored, for machine-local overrides.

## Update

```sh
cd ~/.zshrc.d && git pull origin main
```

Custom Oh-My-Zsh plugins are refreshed with the `user_upgrade_custom_plugins` function.

Note: `AGENTS.md` covers the same repo for other agents; keep the two consistent when changing workflow guidance.
