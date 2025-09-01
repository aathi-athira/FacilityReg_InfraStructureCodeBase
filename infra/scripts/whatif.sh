#!/usr/bin/env bash
set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
source "${HERE}/lib.sh"

require_env DEPLOY_ENV
require_env LOCATION
require_env AZURE_SUBSCRIPTION_ID
validate_env

# Ensure the right subscription is selected
az account set --subscription "${AZURE_SUBSCRIPTION_ID}"

PARAM_FILE="$(param_file_for_env)"

echo "==> what-if for env=${DEPLOY_ENV} location=${LOCATION}"
az deployment sub what-if \
  --location "${LOCATION}" \
  --template-file infra/main.bicep \
  --parameters "${PARAM_FILE}" \
               location="${LOCATION}" \
               env="${DEPLOY_ENV}"
