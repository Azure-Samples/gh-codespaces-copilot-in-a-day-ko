param name string
param location string = resourceGroup().location

@secure()
param aoaiApiKey string
param aoaiApiEndpoint string
param aoaiApiVersion string = '2022-12-01'
param aoaiApiDeploymentId string

module wrkspc './logAnalyticsWorkspace.bicep' = {
  name: 'LogAnalyticsWorkspace_AppService'
  params: {
    name: '${name}-api'
    location: location
  }
}

module appins './applicationInsights.bicep' = {
  name: 'ApplicationInsights_AppService'
  params: {
    name: '${name}-api'
    location: location
    workspaceId: wrkspc.outputs.id
  }
}

// ⬇️ copilot demo ⬇️

// ⬆️ copilot demo ⬆️

module appsvc './appService.bicep' = {
  name: 'AppService_AppService'
  params: {
    name: '${name}-api'
    location: location
    appInsightsInstrumentationKey: appins.outputs.instrumentationKey
    appInsightsConnectionString: appins.outputs.connectionString
    appServicePlanId: asplan.outputs.id
    aoaiApiKey: aoaiApiKey
    aoaiApiEndpoint: aoaiApiEndpoint
    aoaiApiVersion: aoaiApiVersion
    aoaiApiDeploymentId: aoaiApiDeploymentId
  }
}

output id string = appsvc.outputs.id
output name string = appsvc.outputs.name
