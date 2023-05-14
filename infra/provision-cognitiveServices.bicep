param name string
param location string = resourceGroup().location

param aoaiModels array = [
  {
    name: 'gpt-35-turbo'
    deploymentName: 'model-gpt35turbo'
    version: '0301'
    apiVersion: '2023-03-15-preview'
  }
//   {
//     name: 'gpt-4-32k'
//     deploymentName: 'model-gpt432k'
//     version: '0314'
//     apiVersion: '2023-03-15-preview'
//   }
]

// ⬇️ copilot demo ⬇️

// ⬆️ copilot demo ⬆️

// module speech './speech.bicep' = {
//   name: 'Speech'
//   params: {
//     name: name
//     location: location
//   }
// }

// module trnsltr './translator.bicep' = {
//   name: 'Translator'
//   params: {
//     name: name
//     location: location
//   }
// }

// output speechApiKey string = speech.outputs.apiKey
// output speechApiRegion string = speech.outputs.region
// output translatorApiKey string = trnsltr.outputs.apiKey
// output translatorApiEndpoint string = trnsltr.outputs.endpoint

// ⬇️ copilot demo ⬇️
//output for aoai API key, endpoint, version, deploymentID
