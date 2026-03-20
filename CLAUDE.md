# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal zsh configuration dotfiles repo. The main shell config (`dot.zshrc`) is installed by symlinking:

```sh
ln -s ~/.zshrc.d/dot.zshrc ~/.zshrc
ln -s ~/.zshrc.d/.zshenv ~/.zshenv
```

## Architecture: Literate Config via Org-mode

**`README.org` is the source of truth.** `dot.zshrc` is generated from `README.org` using Emacs Org-mode's babel tangle feature (`#+auto_tangle: t` header). When editing in Emacs, saving `README.org` auto-tangles to regenerate `dot.zshrc`.

When making changes:
- **Editing in Emacs**: Edit `README.org` code blocks; the file auto-tangles on save.
- **Editing outside Emacs**: Edit `dot.zshrc` directly, then manually update the corresponding `README.org` block to keep them in sync.

## Key Files

| File | Purpose |
|------|---------|
| `README.org` | Literate source — all sections map to `dot.zshrc` blocks |
| `dot.zshrc` | Generated zsh config, symlinked to `~/.zshrc` |
| `.zshenv` | Env vars loaded before zshrc (PATH, SNIPPETS_PATH, etc.) |
| `EDITOR` | Shell script wrapping `emacsclient -F -c` used as `$VISUAL`/`$EDITOR` |
| `.p10k.zsh` | Active Powerlevel10k config |
| `p10k_classic.zsh` / `p10k_rainbow.zsh` / `p10k_lean.zsh` | Alternate p10k themes |
| `misc/custom.zsh` | Optional local overrides (gitignored) |

## Configuration Structure in `dot.zshrc`

1. **Dumb terminal guard** — wraps most config in `if [ "$TERM" != dumb ]`
2. **Plugin auto-install** — clones Oh-My-Zsh custom plugins if missing
3. **Oh-My-Zsh setup** — theme, plugins list, history settings
4. **fzf-tab** — tab completion via fzf popups (requires tmux for `ftb-tmux-popup`)
5. **zsh-histdb** — SQLite history backend with custom `_zsh_autosuggest_strategy_histdb_*` functions
6. **Emacs integration** — `e()` function, `magit`, `emacsk`, `rgf()` (rg+fzf that opens results in emacsclient)
7. **fzf helpers** — `fif`/`fif2` (search file contents), `fzf_g*` widgets bound to `^g^<key>` for git operations
8. **Snippet system** — `_tru_fzf-snippet` widget (bound to `^[x`, `^[^[`) reads files from `$SNIPPETS_PATH`
9. **PATH / env** — Go, tgenv, Homebrew, local bins
10. **p10k prompt** — time-based theme switch (classic after 17:00, rainbow before)

## Update

```sh
cd ~/.zshrc.d
git pull origin master
```

Custom Oh-My-Zsh plugins can be updated with the `tru/upgrade_custom_plugins` function.
