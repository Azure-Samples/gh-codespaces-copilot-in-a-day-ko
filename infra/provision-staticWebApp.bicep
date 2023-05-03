param name string
param location string = resourceGroup().location

@secure()
param apiManagementId string

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
    apiManagementId: apiManagementId
  }
}

output id string = sttapp.outputs.id
output name string = sttapp.outputs.name
output hostname string = sttapp.outputs.hostname
