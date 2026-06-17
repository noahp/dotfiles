#!/usr/bin/env bash
# GlobalProtect VPN indicator for the tmux statusline.
#
# `globalprotect show` takes ~1.3s, so we never call it inline: print the cached
# value instantly (non-blocking) and refresh in the background only when stale.
#
# Two anti-flicker measures:
#   1. A flock so concurrent tmux redraws don't spawn racing `globalprotect`
#      calls — the CLI talks to PanGPA over a single socket and returns garbage
#      when invoked concurrently.
#   2. The cache is only rewritten on a *valid* status response (one containing
#      "GlobalProtect status:"). Error/garbage output leaves the known-good
#      cache in place, so a transient bad read never blanks the segment.

cache="${TMPDIR:-/tmp}/gp-vpn-status.$(id -u)"
lock="$cache.lock"
max_age=20  # seconds

refresh() {
  # Serialize refreshes; bail if another one already holds the lock.
  exec 9>"$lock" || return
  flock -n 9 || return

  local status seg gw
  status=$(globalprotect show --status 2>/dev/null) || return

  if grep -qw 'Connected' <<<"$status"; then
    gw=$(globalprotect show --details 2>/dev/null \
           | sed -n 's/.*Gateway Name: *//p' | head -1 | tr -d '[:space:]')
    seg=$(printf '#[fg=colour231,bg=colour97] \xe2\x9b\x93 %s \xe2\x9b\x93 #[fg=colour244,bg=colour235] \xe2\x80\xa2 #[default]' "${gw:-vpn}")
  elif grep -q 'GlobalProtect status:' <<<"$status"; then
    seg=""   # valid response, just not connected
  else
    return   # garbage/error → keep the previous cache, no flicker
  fi

  printf '%s' "$seg" > "$cache.tmp" && mv "$cache.tmp" "$cache"
}

# Print whatever is cached right now (instant, never blocks).
[ -f "$cache" ] && cat "$cache"

# Refresh in the background if the cache is missing or stale.
if [ ! -f "$cache" ] || \
   [ "$(( $(date +%s) - $(stat -c %Y "$cache" 2>/dev/null || echo 0) ))" -ge "$max_age" ]; then
  refresh >/dev/null 2>&1 &
fi
