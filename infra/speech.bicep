param name string
param location string = resourceGroup().location

var speech = {
  name: 'speech-${name}'
  location: location
  skuName: 'F0'
}

resource spchsvc 'Microsoft.CognitiveServices/accounts@2022-12-01' = {
  name: speech.name
  location: speech.location
  kind: 'SpeechServices'
  sku: {
    name: speech.skuName
  }
  properties: {
    customSubDomainName: speech.name
    publicNetworkAccess: 'Enabled'
  }
}

output id string = spchsvc.id
output name string = spchsvc.name
output region string = spchsvc.location
output apiKey string = listKeys(spchsvc.id, '2022-12-01').key1
