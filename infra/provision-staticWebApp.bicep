param name string
param location string = resourceGroup().location

module wrkspc './logAnalyticsWorkspace.bicep' = {
  name: 'LogAnalyticsWorkspace_StaticWebApp'
  params: {
    name: '${name}-web'
    location: location
  }
}

module appins 'applicationInsights.bicep' = {
  name: 'ApplicationInsights_StaticWebApp'
  params: {
    name: '${name}-web'
    location: location
    workspaceId: wrkspc.outputs.id
  }
}

module sttapp './staticWebApp.bicep' = {
  name: 'StaticWebApp_StaticWebApp'
  params: {
    name: '${name}-web'
    location: 'eastasia'
    appInsightsId: appins.outputs.id
    appInsightsInstrumentationKey: appins.outputs.instrumentationKey
    appInsightsConnectionString: appins.outputs.connectionString
  }
}
