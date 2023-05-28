param name string
param location string = 'eastus'

param aoaiModels array = [
  {
    name: ''
    deploymentName: ''
    version: ''
  }
]

var openai = {
    name: 'aoai-${name}'
    location: location
    skuName: 'S0'
    models: aoaiModels
}

resource aoai 'Microsoft.CognitiveServices/accounts@2022-12-01' = {
    name: openai.name
    location: openai.location
    kind: 'OpenAI'
    sku: {
        name: openai.skuName
    }
    properties: {
        customSubDomainName: openai.name
        publicNetworkAccess: 'Enabled'
    }
}

// ⬇️ copilot demo ⬇️


// ⬆️ copilot demo ⬆️

output id string = aoai.id
output name string = aoai.name
output endpoint string = aoai.properties.endpoint
output apiKey string = listKeys(aoai.id, '2022-12-01').key1


