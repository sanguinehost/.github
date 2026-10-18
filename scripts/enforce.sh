#!/usr/bin/env bash
set -euo pipefail

OWNER="${OWNER:-sanguinehost}"
MAINTAINER="${MAINTAINER:-paperboygold}"
APPLY=0
[ "${1:-}" = "--apply" ] && APPLY=1

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
ruleset="$root/rulesets/default-branch.json"

say() { printf '%s\n' "$*"; }

repos=$(gh api "orgs/$OWNER/repos?per_page=100" --paginate \
  --jq '.[] | select(.archived == false and .fork == false) | [.name, .default_branch, (if .private then "private" else "public" end)] | @tsv')

printf '%-28s %-8s %-8s %s\n' repository branch access codeowners
while IFS=$'\t' read -r repo branch visibility; do
  [ -n "$repo" ] || continue
  path=".github/CODEOWNERS"
  content=$(printf '%s\n' \
    "# https://github.com/$OWNER/.github/blob/main/CONTRIBUTING.md" \
    "* @${MAINTAINER}")
  b64=$(printf '%s' "$content" | base64 -w0)
  raw_sha=$(gh api "repos/$OWNER/$repo/contents/$path?ref=$branch" --jq '.sha // empty' 2>/dev/null || true)
  sha=""
  [[ "$raw_sha" =~ ^[0-9a-f]{40}$ ]] && sha="$raw_sha"

  if [ -z "$sha" ]; then
    printf '%-28s %-8s %-8s %s\n' "$repo" "$branch" "$visibility" "add"
    if [ "$APPLY" -eq 1 ]; then
      gh api -X PUT "repos/$OWNER/$repo/contents/$path" \
        -f message="Add CODEOWNERS: only @paperboygold merges" \
        -f content="$b64" -f branch="$branch" >/dev/null
    fi
  else
    current=$(gh api "repos/$OWNER/$repo/contents/$path?ref=$branch" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null || true)
    if [ "$current" = "$content" ]; then
      printf '%-28s %-8s %-8s %s\n' "$repo" "$branch" "$visibility" "ok"
    else
      printf '%-28s %-8s %-8s %s\n' "$repo" "$branch" "$visibility" "update"
      if [ "$APPLY" -eq 1 ]; then
        gh api -X PUT "repos/$OWNER/$repo/contents/$path" \
          -f message="Update CODEOWNERS: only @paperboygold merges" \
          -f content="$b64" -f sha="$sha" -f branch="$branch" >/dev/null
      fi
    fi
  fi

  if gh api "repos/$OWNER/$repo/rulesets" >/dev/null 2>&1; then
    raw_id=$(gh api "repos/$OWNER/$repo/rulesets" --jq '.[] | select(.name == "default-branch-protection") | .id' 2>/dev/null || true)
    id=""
    [[ "$raw_id" =~ ^[0-9]+$ ]] && id="$raw_id"
    if [ -n "$id" ]; then
      say "  ruleset: update #$id"
      if [ "$APPLY" -eq 1 ]; then
        gh api -X PUT "repos/$OWNER/$repo/rulesets/$id" --input "$ruleset" >/dev/null
      fi
    else
      say "  ruleset: create"
      if [ "$APPLY" -eq 1 ]; then
        gh api -X POST "repos/$OWNER/$repo/rulesets" --input "$ruleset" >/dev/null
      fi
    fi
  else
    say "  ruleset: unavailable on this GitHub plan; repository permission is the control"
  fi
done <<< "$repos"

say ""
say "Access audit"
say "  organisation admins: $(gh api "orgs/$OWNER/members?role=admin" --jq '[.[].login] | join(", ")')"

outside=0
teams=$(gh api "orgs/$OWNER/teams" --jq 'length' 2>/dev/null || echo 0)
keys=0
while IFS=$'\t' read -r repo _ _; do
  [ -n "$repo" ] || continue
  n=$(gh api "repos/$OWNER/$repo/collaborators?affiliation=outside&per_page=100" --jq 'length' 2>/dev/null || echo 0)
  outside=$((outside + n))
  n=$(gh api "repos/$OWNER/$repo/keys?per_page=100" --jq 'length' 2>/dev/null || echo 0)
  keys=$((keys + n))
done <<< "$repos"

say "  outside collaborators: $outside"
say "  teams: $teams"
say "  deploy keys: $keys"
say "  app installations:"
gh api "orgs/$OWNER/installations" 2>/dev/null \
  | jq -r '.installations[] | "    " + .app_slug + " (contents=" + (.permissions.contents // "none") + ", pull_requests=" + (.permissions.pull_requests // "none") + ")"' \
  || say "    unavailable"
