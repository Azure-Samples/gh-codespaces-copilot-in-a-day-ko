targetScope = 'subscription'

param name string
param location string = 'Korea Central'

param apiManagementPublisherName string = 'Ask Me Anything Bot'
param apiManagementPublisherEmail string = 'apim@contoso.com'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${name}'
  location: location
}

module cogsvc './provision-cognitiveServices.bicep' = {
  name: 'CognitiveServices'
  scope: rg
  params: {
    name: name
    location: location
  }
}

module appsvc './provision-appService.bicep' = {
  name: 'AppService'
  scope: rg
  params: {
    name: name
    location: location
    aoaiApiKey: cogsvc.outputs.aoaiApiKey
    aoaiApiEndpoint: cogsvc.outputs.aoaiApiEndpoint
  }
}
    
module apim './provision-apiManagement.bicep' = {
  name: 'ApiManagement'
  scope: rg
  params: {
    name: name
    location: location
    apiManagementPublisherName: apiManagementPublisherName
    apiManagementPublisherEmail: apiManagementPublisherEmail
  }
}

module apis './provision-apiManagementApi.bicep' = {
  name: 'ApiManagementApi'
  scope: rg
  dependsOn: [
    apim
  ]
  params: {
    name: name
    location: location
    apiManagementApiName: appsvc.outputs.name
    apiManagementApiDisplayName: appsvc.outputs.name
    apiManagementApiDescription: appsvc.outputs.name
    apiManagementApiServiceUrl: 'https://${appsvc.outputs.name}.azurewebsites.net/api'
    apiManagementApiPath: 'api'
    apiManagementApiFormat: 'openapi'
    apiManagementApiValue: 'openapi: 3.0.1\r\ninfo:\r\n  title: Ask Me Anything\r\n  description: You can ask me anything!\r\n  version: 1.0.0\r\nservers:\r\n  - url: http://localhost:8080/api\r\npaths: {}'
  }
}

module sttapp './provision-staticWebApp.bicep' = {
    name: 'StaticWebApp'
    scope: rg
    params: {
      name: name
      location: location
      apiManagementId: apim.outputs.id
    }
  }
  