#!/bin/bash
# Status line approximating the user's Powerlevel10k lean prompt: dir, git (vcs), then model/context.
input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
[ -z "$cwd" ] && cwd=$(pwd)

# dir: blue (p10k color 31), ~ abbreviation
dir="$cwd"
case "$dir" in "$HOME") dir="~";; "$HOME"/*) dir="~${dir#"$HOME"}";; esac
out=$(printf '\033[38;5;31m%s\033[0m' "$dir")

# vcs: green clean (76), yellow modified (178), blue untracked (39), red conflicted (196)
if branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null); then
  st=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
  color=76; marks=""
  if echo "$st" | grep -qE '^(UU|AA|DD|AU|UA|DU|UD)'; then color=196; marks="$marks ~"; fi
  if echo "$st" | grep -qE '^[MADRC]'; then color=178; marks="$marks +"; fi
  if echo "$st" | grep -qE '^.[MD]'; then color=178; marks="$marks !"; fi
  if echo "$st" | grep -qE '^\?\?'; then marks="$marks ?"; [ "$color" = 76 ] && color=39; fi
  out="$out $(printf '\033[38;5;%sm%s%s\033[0m' "$color" "$branch" "$marks")"
fi

# extras
[ -n "$model" ] && out="$out $(printf '\033[2m%s\033[0m' "$model")"
[ -n "$used" ] && out="$out $(printf '\033[2mctx %.0f%%\033[0m' "$used")"
# subscription left: remaining % of the 5-hour and 7-day limits (green, yellow <=25, red <=10)
for w in five_hour:5h seven_day:7d; do
  u=$(echo "$input" | jq -r ".rate_limits.${w%%:*}.used_percentage // empty")
  [ -z "$u" ] && continue
  left=$(printf '%.0f' "$(echo "100 - $u" | bc -l 2>/dev/null || echo $((100 - ${u%.*})))")
  color=76; [ "$left" -le 25 ] && color=178; [ "$left" -le 10 ] && color=196
  out="$out $(printf '\033[2m%s\033[0m \033[38;5;%sm%s%%\033[0m' "${w##*:}" "$color" "$left")"
  # time until the limit resets, e.g. 2h10m or 3d4h
  r=$(echo "$input" | jq -r ".rate_limits.${w%%:*}.resets_at // empty")
  if [ -n "$r" ] && s=$(( ${r%.*} - $(date +%s) )) && [ "$s" -gt 0 ]; then
    if [ "$s" -ge 86400 ]; then t="$((s / 86400))d$((s % 86400 / 3600))h"
    elif [ "$s" -ge 3600 ]; then t="$((s / 3600))h$((s % 3600 / 60))m"
    else t="$((s / 60 + 1))m"; fi
    out="$out $(printf '\033[2m(%s)\033[0m' "$t")"
  fi
done
printf '%s' "$out"
