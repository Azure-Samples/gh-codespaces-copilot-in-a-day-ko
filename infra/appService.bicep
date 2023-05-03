param name string
param location string = resourceGroup().location

param appServicePlanId string

@secure()
param appInsightsInstrumentationKey string
@secure()
param appInsightsConnectionString string

@secure()
param aoaiApiKey string
param aoaiApiEndpoint string

var asplan = {
  id: appServicePlanId
}
  
var appInsights = {
  instrumentationKey: appInsightsInstrumentationKey
  connectionString: appInsightsConnectionString
}

var aoai = {
  apiKey: aoaiApiKey
  endpoint: aoaiApiEndpoint
}

var apiApp = {
  name: 'appsvc-${name}'
  location: location
}

resource appsvc 'Microsoft.Web/sites@2022-03-01' = {
  name: apiApp.name
  location: apiApp.location
  kind: 'app,linux'
  properties: {
    serverFarmId: asplan.id
    httpsOnly: true
    reserved: true
    siteConfig: {
      linuxFxVersion: 'JAVA|17-java17'
      alwaysOn: true
      appSettings: [
        // Common Settings
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.instrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.connectionString
        }
        // Azure OpenAI Service
        {
          name: 'AOAI__API_Key'
          value: aoai.apiKey
        }
        {
          name: 'AOAI__API_Endpoint'
          value: aoai.endpoint
        }
      ]
    }
  }
}

var policies = [
  {
    name: 'scm'
    allow: false
  }
  {
    name: 'ftp'
    allow: false
  }
]

resource appsvcPolicies 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-03-01' = [for policy in policies: {
  name: '${appsvc.name}/${policy.name}'
  location: apiApp.location
  properties: {
    allow: policy.allow
  }
}]

output id string = appsvc.id
output name string = appsvc.name
