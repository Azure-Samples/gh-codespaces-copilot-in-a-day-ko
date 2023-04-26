param name string
param location string = 'eastasia'

@secure()
param appInsightsId string
@secure()
param appInsightsInstrumentationKey string
@secure()
param appInsightsConnectionString string

var staticApp = {
  name: 'sttapp-${name}'
  location: location
  appInsights: {
    id: appInsightsId
    instrumentationKey: appInsightsInstrumentationKey
    connectionString: appInsightsConnectionString
  }
}

resource sttapp 'Microsoft.Web/staticSites@2022-03-01' = {
  name: staticApp.name
  location: location
  sku: {
    name: 'Free'
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

output id string = sttapp.id
output name string = sttapp.name
output hostname string = sttapp.properties.defaultHostname
