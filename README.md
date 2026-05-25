# bashtidy

A lightweight bash configuration for development containers — git prompt, aliases, color, and more.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/bashtidy/bashtidy/master/install.sh | bash
```

Reload your shell or run `source ~/.bashrc` to apply.

## What's included

**Prompt**

Shows current directory and git branch with status indicators:

| Prompt | Meaning |
|--------|---------|
| `(master)` in green | clean working tree |
| `(master !)` in yellow | unstaged changes |
| `(master +)` in yellow | staged changes |
| `(master ?)` in yellow | untracked files |
| `(master ↑2)` in yellow | 2 commits ahead of upstream |
| `(master)` in red | merge conflict |

**Git aliases**

| Alias | Command |
|-------|---------|
| `gst` | `git status` |
| `gss` | `git status -s` |
| `gl` | `git log --oneline --graph --decorate --all` |
| `gd` | `git diff` |
| `gds` | `git diff --staged` |
| `ga` | `git add` |
| `gaa` | `git add -A` |
| `gcm` | `git commit -m` |
| `gco` | `git checkout` |
| `gcob` | `git checkout -b` |
| `gsw` | `git switch` |
| `gpl` | `git pull` |
| `gps` | `git push` |
| `gpsu` | `git push -u origin HEAD` |
| `gpsf` | `git push --force-with-lease` |
| `gsh` | `git stash` |
| `gshp` | `git stash pop` |
| `gwip` | stage all and commit as "WIP" |
| `gunwip` | undo last commit |

**Other**

- `ls`, `ll`, `la` with color
- `grep`, `diff` with color
- `..`, `...`, `-` navigation shortcuts
- Timestamped history, no duplicates

## License

[MIT](/LICENSE)