#!/usr/bin/env bash
set -eu

# Accept only these environments
ALLOWED_ENVS=("staging" "prod")

require_env() {
  local var="$1"
  if [[ -z "${!var:-}" ]]; then
    echo "ERROR: $var is not set" >&2
    exit 2
  fi
}

validate_env() {
  local e="${DEPLOY_ENV:-}"
  for a in "${ALLOWED_ENVS[@]}"; do
    [[ "$e" == "$a" ]] && return 0
  done
  echo "ERROR: DEPLOY_ENV must be one of: ${ALLOWED_ENVS[*]} (got \"$e\")" >&2
  exit 3
}

param_file_for_env() {
  echo "infra/env/${DEPLOY_ENV}.bicepparam"
}
