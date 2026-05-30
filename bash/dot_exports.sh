# Load secrets from 1Password ("Bash Secrets" item in "Dev" vault)
# Caches locally so only the first terminal needs fingerprint auth.
#   load_secrets           — loads from cache, or fetches if no cache
#   load_secrets refresh   — re-fetches from 1Password and updates cache
_OP_CACHE="$HOME/.cache/op_secrets"

load_secrets() {
  local cache="$_OP_CACHE"

  if [[ "$1" != "refresh" ]] && [[ -f "$cache" ]]; then
    source "$cache"
    return 0
  fi

  if ! command -v op &>/dev/null; then
    echo "[warn] 1Password CLI not installed — secrets not loaded"
    return 1
  fi

  mkdir -p "$(dirname "$cache")"
  op item get 'Bash Secrets' --vault=Dev --format=json \
    | jq -r '.fields[] | select(.value != null and .value != "") | "export \(.label)=\(.value | @sh)"' \
    > "$cache"
  chmod 600 "$cache"
  source "$cache"
}

load_secrets

. "$HOME/.cargo/env"

# bun
export BUN_INSTALL="$HOME/.bun"
PATH="$BUN_INSTALL/bin:$PATH"

# Additional paths
path_extras=(
  "/home/erick/.local/bin"
  "/usr/local/go/bin"
  "/opt/nvim-linux-x86_64/bin"
  "$HOME/.pulumi/bin"
  "$HOME/dev/tools/jira-cli"
  "$HOME/dev/projects/zatlas/zatlas-claude-toolkit/scripts/cdp"
  "$HOME/dev/projects/zatlas/zatlas-claude-toolkit/scripts/jira"
)

for p in "${path_extras[@]}"; do
  [[ -d "$p" ]] && PATH="$PATH:$p"
done
export PATH
