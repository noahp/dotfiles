# Agent Instructions

## General

- ALWAYS ask before pushing git changes to remotes

## Tools

- Always use `rg` (ripgrep) instead of `grep` for searching file contents.
- Always use `fd` instead of `find` for searching files and directories.
- Always use the `gh` CLI when accessing or operating on GitHub resources (PRs, issues, releases, etc.).
- When accessing serial ports, ALWAYS use named ports via `/dev/serial/by-id` (Linux — not macOS-style `/dev/tty.usbserial-*` paths).
