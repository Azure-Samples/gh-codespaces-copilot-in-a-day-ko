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


// ⬆️ copilot demo ⬆️

output id string = aoai.id
output name string = aoai.name
output endpoint string = aoai.properties.endpoint
output apiKey string = listKeys(aoai.id, '2022-12-01').key1


