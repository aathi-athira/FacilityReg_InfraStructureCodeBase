#!/usr/bin/env bash
set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
source "${HERE}/lib.sh"

require_env DEPLOY_ENV
require_env AZURE_SUBSCRIPTION_ID
validate_env

az account set --subscription "${AZURE_SUBSCRIPTION_ID}"

PARAM_FILE="$(param_file_for_env)"

# Extract namePrefix from the param file (simple grep; assumes single-line assign)
NAME_PREFIX="$(grep -E '^\s*param\s+namePrefix\s*=\s*' "${PARAM_FILE}" | sed -E "s/.*=\s*'([^']+)'.*/\1/")"
if [[ -z "${NAME_PREFIX}" ]]; then
  echo "ERROR: Could not read namePrefix from ${PARAM_FILE}" >&2
  exit 4
fi

RG_NAME="${NAME_PREFIX}-${DEPLOY_ENV}-rg"

echo "==> WARNING: This will delete resource group: ${RG_NAME}"
read -p "Type '${RG_NAME}' to confirm: " confirm
[[ "$confirm" == "$RG_NAME" ]] || { echo "Aborted."; exit 1; }

echo "==> Deleting resource group ${RG_NAME}..."
az group delete --name "${RG_NAME}" --yes --no-wait

echo "==> Destroy triggered."
