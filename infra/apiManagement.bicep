param name string
param location string = resourceGroup().location

param appInsightsId string
@secure()
param appInsightsInstrumentationKey string

param apiManagementPublisherName string
param apiManagementPublisherEmail string

@allowed([
  'rawxml'
  'rawxml-link'
  'xml'
  'xml-link'
])
param apiManagementPolicyFormat string = 'xml'
param apiManagementPolicyValue string = '<!--\r\n  IMPORTANT:\r\n  - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n  - Only the <forward-request> policy element can appear within the <backend> section element.\r\n  - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n  - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n  - To add a policy position the cursor at the desired insertion point and click on the round button associated with the policy.\r\n  - To remove a policy, delete the corresponding policy statement from the policy document.\r\n  - Policies are applied in the order of their appearance, from the top down.\r\n-->\r\n<policies>\r\n  <inbound>\r\n    <cors allow-credentials="true">\r\n      <allowed-origins>\r\n        <origin>https://apim-{{AZURE_ENV_NAME}}.azure-api.net</origin>\r\n        <origin>https://{{STTAPP_URL}}</origin>\r\n        <origin>https://make.powerapps.com</origin>\r\n        <origin>https://make.powerautomate.com</origin>\r\n      </allowed-origins>\r\n      <allowed-methods>\r\n        <method>*</method>\r\n      </allowed-methods>\r\n      <allowed-headers>\r\n        <header>*</header>\r\n      </allowed-headers>\r\n      <expose-headers>\r\n        <header>*</header>\r\n      </expose-headers>\r\n    </cors>\r\n  </inbound>\r\n  <backend>\r\n    <forward-request />\r\n  </backend>\r\n  <outbound />\r\n  <on-error />\r\n</policies>'

var appInsights = {
  id: appInsightsId
  name: 'appins-${name}'
  instrumentationKey: appInsightsInstrumentationKey
}

var apiManagement = {
  name: 'apim-${name}'
  location: location
  skuName: 'Consumption'
  skuCapacity: 0
  publisherName: apiManagementPublisherName
  publisherEmail: apiManagementPublisherEmail
  policyFormat: apiManagementPolicyFormat
  policyValue: apiManagementPolicyValue
}

var namedValues = [
  {
    name: 'AZURE_ENV_NAME'
    value: name
  }
  {
    name: 'APIM_NAME'
    value: apiManagement.name
  }
  {
    name: 'STTAPP_URL'
    value: 'to_be_updated'
  }
]

var products = [
  {
    name: 'default'
    displayName: 'Default Product'
    description: 'This is the default product created by the template, which includes all APIs.'
    state: 'published'
    subscriptionRequired: false
  }
]

resource apim 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: apiManagement.name
  location: apiManagement.location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: apiManagement.skuName
    capacity: apiManagement.skuCapacity
  }
  properties: {
    publisherName: apiManagement.publisherName
    publisherEmail: apiManagement.publisherEmail
  }
}

resource apimNamedValue 'Microsoft.ApiManagement/service/namedValues@2022-08-01' = [for (nv, index) in namedValues: {
  name: '${apim.name}/${nv.name}'
  properties: {
    displayName: nv.name
    secret: true
    value: nv.value
  }
}]

resource apimlogger 'Microsoft.ApiManagement/service/loggers@2022-08-01' = {
  name: '${apim.name}/${appInsights.name}'
  properties: {
    loggerType: 'applicationInsights'
    resourceId: appInsights.id
    credentials: {
      instrumentationKey: appInsights.instrumentationKey
    }
  }
}

resource apimpolicy 'Microsoft.ApiManagement/service/policies@2022-08-01' = {
  name: '${apim.name}/policy'
  dependsOn: [
    apimNamedValue
  ]
  properties: {
    format: apiManagement.policyFormat
    value: apiManagement.policyValue
  }
}

resource apimproducts 'Microsoft.ApiManagement/service/products@2022-08-01' = [for (product, index) in products: {
  name: '${apim.name}/${product.name}'
  properties: {
    displayName: product.displayName
    description: product.description
    state: product.state
    subscriptionRequired: product.subscriptionRequired
  }
}]

output id string = apim.id
output name string = apim.name
