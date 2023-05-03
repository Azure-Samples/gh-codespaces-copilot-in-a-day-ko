param name string
param location string = 'eastasia'

@secure()
param appInsightsId string
@secure()
param appInsightsInstrumentationKey string
@secure()
param appInsightsConnectionString string
@secure()
param apiManagementId string

var staticApp = {
  name: 'sttapp-${name}'
  location: location
  appInsights: {
    id: appInsightsId
    instrumentationKey: appInsightsInstrumentationKey
    connectionString: appInsightsConnectionString
  }
  apiManagement: {
    id: apiManagementId
  }
}

resource sttapp 'Microsoft.Web/staticSites@2022-03-01' = {
  name: staticApp.name
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    allowConfigFileUpdates: true
    stagingEnvironmentPolicy: 'Enabled'
  }
}

resource sttappSettings 'Microsoft.Web/staticSites/config@2022-03-01' = {
  name: 'appsettings'
  parent: sttapp
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: staticApp.appInsights.instrumentationKey
    APPLICATIONINSIGHTS_CONNECTION_STRING: staticApp.appInsights.connectionString
  }
}

resource sttappLinkedBackend 'Microsoft.Web/staticSites/linkedBackends@2022-03-01' = {
  name: 'backend'
  parent: sttapp
  properties: {
    backendResourceId: staticApp.apiManagement.id
  }
}
  
output id string = sttapp.id
output name string = sttapp.name
output hostname string = sttapp.properties.defaultHostname
