# Repository Guidelines

## Project Structure & Module Organization
This repository is a personal zsh dotfiles repo. `README.org` is the primary source and documents the shell setup in literate Org-mode form. `dot.zshrc` is the generated runtime config that gets symlinked to `~/.zshrc`, and `.zshenv` loads early environment settings. `EDITOR` is a small helper script for launching `emacsclient`. Powerlevel10k variants live in `p10k_*.zsh`, with `.p10k.zsh` as the active prompt config. Local machine-specific overrides belong under `misc/`; that path is gitignored.

## Build, Test, and Development Commands
There is no build step, but there are a few standard maintenance commands:

- `ln -s ~/.zshrc.d/dot.zshrc ~/.zshrc && ln -s ~/.zshrc.d/.zshenv ~/.zshenv` installs the config.
- `git pull origin master` updates the checked-out repo.
- `zsh -n dot.zshrc` performs a syntax check before committing shell changes.
- `zsh -i -c exit` is a quick smoke test for startup regressions in an interactive shell.

When editing in Emacs, save `README.org` to auto-tangle `dot.zshrc`. If you edit `dot.zshrc` directly, update the matching Org block in `README.org` in the same change.

## Coding Style & Naming Conventions
Match the existing shell style: four-space indentation in shell blocks, lowercase variable and function names unless environment variables must be uppercase, and concise comments only where behavior is non-obvious. Prefer small helper functions over long inline command chains. Keep plugin names and external paths explicit, for example `${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/...`.

## Testing Guidelines
There is no formal test suite or coverage target in this repo. Validate changes with `zsh -n dot.zshrc`, then open a fresh shell and exercise the affected alias, function, completion, or prompt behavior. For prompt or theme changes, verify both interactive startup and fallback behavior for `TERM=dumb`.

## Commit & Pull Request Guidelines
Recent history uses short, lowercase commit subjects such as `update EDITOR` and `add shellfirm plugin`. Keep commits focused and descriptive. Pull requests should explain the user-facing shell behavior changed, mention any plugin or dependency added, and note whether both `README.org` and `dot.zshrc` were updated together. Include screenshots only for prompt/theme changes.
