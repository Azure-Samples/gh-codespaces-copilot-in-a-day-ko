param name string
param location string = 'global'

var translator = {
  name: 'trnsltr-${name}'
  location: location
  skuName: 'F0'
}

resource trnsltr 'Microsoft.CognitiveServices/accounts@2022-12-01' = {
  name: translator.name
  location: translator.location
  kind: 'TextTranslation'
  sku: {
    name: translator.skuName
  }
  properties: {
    customSubDomainName: translator.name
    publicNetworkAccess: 'Enabled'
  }
}

output id string = trnsltr.id
output name string = trnsltr.name
output endpoint string = trnsltr.properties.endpoint
output apiKey string = listKeys(trnsltr.id, '2022-12-01').key1
