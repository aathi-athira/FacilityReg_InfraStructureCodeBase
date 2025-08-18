// parameters for prod
using '../main.bicep'

param env = 'prod'
param namePrefix = 'facility-register'
// param tags = {
//   owner: 'platform'
//   costCenter: 'Prod'
// }

@description('Deployment location (overridden at runtime)')
param location = 'dummy'
