// parameters for staging
using '../main.bicep'

param env = 'staging'
param namePrefix = 'facility-register'
// param tags = {
//   owner: 'platform'
//   costCenter: 'R&D'
// }

@description('Deployment location (overridden at runtime)')
param location = 'dummy'
