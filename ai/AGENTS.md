# Agent Instructions

## General

- ALWAYS ask before pushing git changes to remotes

## Tools

- Always use `rg` (ripgrep) instead of `grep` for searching file contents.
- Always use `fd` instead of `find` for searching files and directories. Key differences from `find`:
  - Pattern comes first, path second (opposite of `find`): `fd PATTERN [PATH]`
  - Patterns are regex by default; use `--glob` for glob patterns: `fd --glob '*.c'`
  - No `-name`, `-type`, `-path` flags needed — just: `fd foo`, `fd --type f`, `fd --type d`
  - Includes hidden files with `-H`; follows symlinks with `-L`
  - Use `--exec` instead of `-exec`: `fd --glob '*.log' --exec rm {}`
- Always use the `gh` CLI when accessing or operating on GitHub resources (PRs, issues, releases, etc.).
- When accessing serial ports, ALWAYS use named ports via `/dev/serial/by-id` (Linux — not macOS-style `/dev/tty.usbserial-*` paths).
