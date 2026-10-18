# Sanguine Host organisation policy

The canonical contribution, licensing, and merge-rights policy is
[CONTRIBUTING.md](CONTRIBUTING.md). GitHub uses it as the default contribution guide for repositories
in this organisation that do not have their own.

Only [@paperboygold](https://github.com/paperboygold) merges. Contributions are signed off under the
Developer Certificate of Origin and licensed under the repository's existing licence.

## Enforcement

`scripts/enforce.sh` audits access, adds `.github/CODEOWNERS` to each maintained, non-fork
repository, and applies default-branch rules where the GitHub plan supports them.

```sh
scripts/enforce.sh          # dry run
scripts/enforce.sh --apply  # apply
```

The runner needs `gh` authenticated as an organisation owner. The script excludes archived
repositories and forks.
