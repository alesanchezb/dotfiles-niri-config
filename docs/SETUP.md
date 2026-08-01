# Setup scripts

Three scripts live at the repo root, plus shared logic in `lib/setup-common.sh`.

## `install.sh`

Fresh install. Full list of options: `./install.sh --help`.

Highlights:

- **git pull** before installing (`--no-pull` to skip).
- **yay**: built from AUR if missing.
- **Packages**: base via `pacman`, AUR via `yay`/`paru`. Skips already-installed packages.
- **Optional extras** (`cava`, `ytmdesktop`): prompted unless `--full` or `-y`.
- **Stow**: conflicts are handled safely first —
  - symlinks already pointing into the repo are replaced,
  - anything else (real files/dirs) is **backed up** to `~/.dotfiles-backup/<timestamp>/`.
- **noctalia seed**: writes `~/.config/noctalia/settings.json` (from the shell's
  `settings-default.json` if missing) setting the color scheme (`NOCTALIA_SCHEME`,
  default `Nord`) and wallpaper dir (`WALLPAPER_DIR`, default `~/Pictures/wallpapers`).
- **emacs-config**: prompts to clone + run `alesanchezb/emacs-config` into `~/.repos/` (`--emacs` / `--no-emacs` to force).

## `uninstall.sh`

- Unlinks everything with `stow -D`.
- Optionally removes the installed packages (careful — that includes niri and quickshell).
- Optionally deletes `~/.repos/emacs-config`.
- Backups from previous installs are left in `~/.dotfiles-backup/`.

## `update.sh`

- `git pull --ff-only`.
- Re-links configs (new files added upstream get linked; conflicts are backed up as in install).
- Hot-reloads niri if it's running (`niri msg action load-config-file`).
- `--packages` also runs `yay -Sua` for AUR upgrades.

## Shared behavior (`lib/setup-common.sh`)

| Var | Default | Meaning |
|-----|---------|---------|
| `NOCTALIA_SCHEME` | `Nord` | Color preset seeded into noctalia |
| `WALLPAPER_DIR` | `~/Pictures/wallpapers` | Wallpaper folder seeded into noctalia |

The stow packages are `niri`, `quickshell`, `rofi`, `scripts`. The quickshell
package ships a `.stow-local-ignore` so screenshots and the shell's own
`.gitignore` are not linked into `~/.config`.
