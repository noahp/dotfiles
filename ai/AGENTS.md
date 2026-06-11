# Agent Instructions

## Tools

- Always use `rg` (ripgrep) instead of `grep` for searching file contents.
- Always use `fd` instead of `find` for searching files and directories. Key
  differences from `find`:
  - Pattern comes first, path second (opposite of `find`): `fd PATTERN [PATH]`
  - Patterns are regex by default; use `--glob` for glob patterns:
    `fd --glob '*.c'`
  - No `-name`, `-type`, `-path` flags needed - just: `fd foo`, `fd --type f`,
    `fd --type d`
  - Includes hidden files with `-H`; follows symlinks with `-L`
  - Use `--exec` instead of `-exec`: `fd --glob '*.log' --exec rm {}`
- Always use the `gh` CLI when accessing or operating on GitHub resources (PRs,
  issues, releases, etc.).
- When accessing serial ports, ALWAYS use named ports via `/dev/serial/by-id`
  (Linux - not macOS-style `/dev/tty.usbserial-*` paths).

## Approval required: external writes / pushes

NEVER execute an operation that writes, sends, or publishes anything outside
this machine without explicit approval - regardless of permission mode (this
applies even in auto-accept / bypass-permissions mode). Approval for one
operation does not carry over to subsequent ones. Read-only access (API GETs,
`gh pr view`, `git fetch`/`pull`, search/list/read MCP tools) is always fine
without asking.

Categories (non-exhaustive - when in doubt, ask):

- git: push to any remote, including tags, force-push, and deleting remote
  branches
- GitHub (`gh` or API): PR/issue creation, comments, reviews, merges,
  label/state changes, releases, gists, repo or org settings
- Cloud/infra: any mutating AWS / GCP / Cloudflare / Kubernetes / Terraform
  operation (deploys, applies, DNS changes, bucket/database writes, resource
  create/delete)
- Publishing artifacts: npm / PyPI / cargo / Docker registry pushes, homebrew
  taps, etc.
- Messaging & docs: sending or scheduling Slack messages, email,
  Jira/Confluence/Notion/Salesforce creates, edits, comments, or state
  transitions - any MCP tool call that mutates remote state
- Browser automation: clicking, submitting forms, or filling inputs on live
  sites where the action changes server-side state. Exception when operating
  on local host (eg debugging locally running applications).
- Secrets: never include credentials, tokens, private keys, or env-var values in
  any content that leaves this machine (PR bodies, messages, pastes, external
  API calls)

Read-only operations are fine (eg using `gh` to pull information).

## Approval required: destructive local operations

Also ask before irreversible local actions, even though they're not external:

- deleting or overwriting files outside the current working repo; bulk deletes
  (`rm -rf`) of anything non-trivial
- destroying git state: `reset --hard`, `checkout -- .`/`restore` over
  uncommitted work, `clean -fd`, deleting branches or stashes with unmerged
  work, rewriting history
- system-level changes: `sudo`, installing/removing system packages, editing
  system config, enabling/disabling services
- attached hardware: mass-erase/recover/unlock commands, fuse/OTP writes, or
  writing to block devices (`dd`). Routine dev-board flashing (`west flash`,
  `idf.py flash`, etc.) is fine without asking.
