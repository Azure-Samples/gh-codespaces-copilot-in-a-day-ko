param name string
param location string = 'eastus'

param aoaiModels array = [
  {
    name: ''
    deploymentName: ''
    version: ''
  }
]

// ⬇️ copilot demo ⬇️
// 1. Define openai variable
// 2. Define aoai resource(accounts)
// 3. Define openaiDeployment resource(deployments)

// Define var openai with name, location, skuName, models
var openai = {
  name:'aoai-${name}'
  location: location
  skuName: 'S0'
  models: aoaiModels
}

// Define accounts resource named aoai
// with name, location, kind, sku, properties
resource aoai 'Microsoft.CognitiveServices/accounts@2022-12-01' = {
  name: openai.name
  location: openai.location
  kind: 'OpenAI'
  sku: {
    name: openai.skuName
  }
  properties: {
    // custom sub domain name for the account
    customSubDomainName: openai.name
    // network access
    publicNetworkAccess: 'Enabled'
  }
}

// Define deployments resource named openaiDeployment
// with name, properties
resource openaiDeployment 'Microsoft.CognitiveServices/accounts/deployments@2022-12-01' = [for model in openai.models: {
    name: '${aoai.name}/${model.deploymentName}'
    properties: {
        //model with format, name, version
        model: {
            format: 'OpenAI'
            name: model.name
            version: model.version
        }
        //scaleSetting with Standard scaletype
        scaleSettings: {
            scaleType: 'Standard'
        }   
    }
}]

// ⬆️ copilot demo ⬆️

output id string = aoai.id
output name string = aoai.name
output endpoint string = aoai.properties.endpoint
output apiKey string = listKeys(aoai.id, '2022-12-01').key1


