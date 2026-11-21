# dotfiles

Personal configuration files, managed with [GNU Stow].
Each top-level directory is a "group" of configs. A group is installed by
symlinking its files into `$HOME`:

```console
$ stow -Sv <group>
```

Use `-n` to only show what would be installed. The `.stowrc` at the root of
the repository passes `--no-folding`, so stow links files individually and
never replaces a whole directory such as `~/.ssh` by a symlink into this
repository. Run `stow` from the root of the repository.

## Groups

| Group     | Content                                                                           |
| --------- | --------------------------------------------------------------------------------- |
| `desktop` | sway, Hyprland, hyprpaper, waybar, i3status-rust                                  |
| `dev`     | `.gdbinit` (vendored [gdb-dashboard])                                             |
| `editor`  | `.vimrc`                                                   |
| `fonts`   | DejaVu Sans Mono Nerd Font                                                        |
| `git`     | Git configuration, global ignore file, identity template                          |
| `shell`   | bash, fish, starship; shared aliases/functions/environment in `~/.local/lib/shell` |
| `ssh`     | Shared SSH client options (`~/.ssh/common`)                                       |
| `term`    | alacritty, zellij, tmux, `.inputrc`, terminfo                                     |
| `utils`   | Small scripts installed in `~/.local/bin`                                         |

## Setup notes

- **Git identity**: copy `git/.config/git/credentials.template` to
  `~/.config/git/credentials` and fill in name and e-mail. The file is
  included by the Git configuration and is not tracked.
- **SSH**: add `Include ~/.ssh/common` at the top of `~/.ssh/config`.
- **Fonts**: run `fc-cache -f` after stowing `fonts`.
- **Local shell overrides**: a `~/.local/lib/shell/local` file, if present, is
  sourced last by `~/.bashrc`; it is not tracked.
- **Optional tools**: `fish` (the login shell when installed), `starship`,
  `zoxide`, `eza`, `bat`, `fd`, `rg`, `vim`, `alacritty`.

## Checks

The repository is linted with [prek]: `shellcheck`, `shfmt` and a few generic hooks.

```console
$ prek install
$ prek run --all-files
```

[GNU Stow]: https://www.gnu.org/software/stow/
[gdb-dashboard]: https://github.com/cyrus-and/gdb-dashboard
[prek]: https://github.com/j178/prek
