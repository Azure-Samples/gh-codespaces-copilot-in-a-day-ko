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

// ⬇️ copilot demo ⬇️
// 1. Define aoai resource(accounts)
// 2. Define openaiDeployment resource(deployments)


// ⬆️ copilot demo ⬆️

output id string = aoai.id
output name string = aoai.name
output endpoint string = aoai.properties.endpoint
output apiKey string = listKeys(aoai.id, '2022-12-01').key1


