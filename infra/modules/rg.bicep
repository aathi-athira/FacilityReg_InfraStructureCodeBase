// (sub-scope) creates the resource group
targetScope = 'subscription'

param name string
param location string
param tags object = {}

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: name
  location: location
  tags: tags
}

output resourceGroupName string = rg.name
