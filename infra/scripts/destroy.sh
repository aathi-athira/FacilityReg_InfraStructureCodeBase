#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
source "${HERE}/lib.sh"

require_env DEPLOY_ENV
require_env LOCATION
require_env AZURE_SUBSCRIPTION_ID
require_env NAME_PREFIX
validate_env

az account set --subscription "${AZURE_SUBSCRIPTION_ID}"

RG_NAME="${NAME_PREFIX}-${DEPLOY_ENV}-rg"

echo "==> WARNING: This will delete resource group: ${RG_NAME}"
read -p "Are you sure? (type '${RG_NAME}' to confirm): " confirm

if [[ "$confirm" != "$RG_NAME" ]]; then
  echo "Aborted."
  exit 1
fi

echo "==> Deleting resource group ${RG_NAME} in subscription ${AZURE_SUBSCRIPTION_ID}..."
az group delete --name "${RG_NAME}" --yes --no-wait

echo "==> Destroy triggered. Resources are being deleted asynchronously."
