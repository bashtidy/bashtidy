# bashtidy

A lightweight bash configuration for development containers — git prompt, aliases, and color, nothing more.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/bashtidy/bashtidy/master/install.sh | bash
```

Reload your shell or run `source ~/.bashrc` to apply.

## What's included

**Prompt**

Format: `[~/path :: branch] ➜` inside a git repo, `[~/path] ➜` outside.

Branch color varies by name:

| Branch | Color |
|--------|-------|
| `main` / `master` | green |
| `dev` | yellow |
| `feature-*` | blue |
| anything else | orange |

Status indicators (shown in yellow) appended to the branch name:

| Indicator | Meaning |
|-----------|---------|
| `*` | modified, added, or deleted files |
| `+` | untracked files |
| `!` | merge conflict |

Examples:

```
[~/projects/app :: master] ➜         # clean, green
[~/projects/app :: dev*] ➜           # dev branch with changes, branch yellow, * yellow
[~/projects/app :: feature-auth+] ➜  # untracked files, branch blue, + yellow
[~/projects/app] ➜                   # not a git repo
```

**Git aliases**

| Alias | Command |
|-------|---------|
| `g` | `git` |
| `gi` | `git init` |
| `gcl` | `git clone` |
| `gst` | `git status` |
| `gss` | `git status -s` |
| `gl` | `git log --oneline --graph --decorate --all` |
| `glo` | `git log --oneline -20` |
| `gd` | `git diff` |
| `gds` | `git diff --staged` |
| `gb` | `git branch` |
| `gba` | `git branch -a` |
| `gbd` | `git branch -d` |
| `gbD` | `git branch -D` |
| `gco` | `git checkout` |
| `gcob` | `git checkout -b` |
| `gsw` | `git switch` |
| `gswc` | `git switch -c` |
| `ga` | `git add` |
| `gaa` | `git add -A` |
| `gap` | `git add -p` |
| `gc` | `git commit` |
| `gcm` | `git commit -m` |
| `gca` | `git commit --amend` |
| `gcane` | `git commit --amend --no-edit` |
| `gsh` | `git stash` |
| `gshl` | `git stash list` |
| `gshp` | `git stash pop` |
| `gshd` | `git stash drop` |
| `gf` | `git fetch` |
| `gfa` | `git fetch --all` |
| `gpl` | `git pull` |
| `gplr` | `git pull --rebase` |
| `gps` | `git push` |
| `gpsu` | `git push -u origin HEAD` |
| `gpsf` | `git push --force-with-lease` |
| `gm` | `git merge` |
| `grb` | `git rebase` |
| `grbi` | `git rebase -i` |
| `grbc` | `git rebase --continue` |
| `grba` | `git rebase --abort` |
| `grh` | `git reset HEAD` |
| `grhh` | `git reset --hard HEAD` |
| `gclean` | `git clean -fd` |
| `gt` | `git tag` |
| `gtl` | `git tag -l` |
| `gwip` | stage all and commit as "WIP" |
| `gunwip` | undo last commit |

**Other**

- `ls`, `ll`, `la`, `l` with color
- `grep`, `fgrep`, `egrep`, `diff` with color
- `..`, `...`, `....`, `-` navigation shortcuts
- Timestamped history, no duplicates

## Acknowledgements

Prompt style inspired by [larn.zsh-theme](https://github.com/tourcoder/larn.zsh-theme).

## License

[MIT](/LICENSE)