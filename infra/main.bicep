// Orchestrates env-aware deploy (subscription scope)
targetScope = 'subscription'

@allowed(['staging','prod'])
param env string

param location string
param namePrefix string
param tags object = {
  env: env
}
var baseName = '${namePrefix}-${env}'

var rgName = '${baseName}-rg'
/* 1) Resource Group (sub-scope) */
module rg './modules/rg.bicep' = {
  name: 'rg-${rgName}'
  scope: subscription()
  params: {
    name: rgName
    location: location
    tags: tags
  }
}

output resourceGroupName string = rg.outputs.resourceGroupName
