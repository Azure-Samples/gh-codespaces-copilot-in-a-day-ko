param name string
param location string = resourceGroup().location

param aoaiModels array = [
  {
    name: 'gpt-35-turbo'
    deploymentName: 'model-gpt35turbo'
    version: '0301'
  }
//   {
//     name: 'gpt-4-32k'
//     deploymentName: 'model-gpt432k'
//     version: '0314'
//   }
]
  
module aoai './openAI.bicep' = {
  name: 'OpenAI'
  params: {
    name: name
    location: 'eastus'
    aoaiModels: aoaiModels
  }
}

module speech './speech.bicep' = {
  name: 'Speech'
  params: {
    name: name
    location: location
  }
}

module trnsltr './translator.bicep' = {
  name: 'Translator'
  params: {
    name: name
    location: location
  }
}

output aoaiApiKey string = aoai.outputs.apiKey
output aoaiApiEndpoint string = aoai.outputs.endpoint
output speechApiKey string = speech.outputs.apiKey
output speechApiRegion string = speech.outputs.region
output translatorApiKey string = trnsltr.outputs.apiKey
output translatorApiEndpoint string = trnsltr.outputs.endpoint
