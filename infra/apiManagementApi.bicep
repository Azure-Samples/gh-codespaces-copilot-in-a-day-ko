param name string
param location string = resourceGroup().location

param apiManagementApiName string
param apiManagementApiDisplayName string
param apiManagementApiDescription string
param apiManagementApiSubscriptionRequired bool = false
param apiManagementApiServiceUrl string
param apiManagementApiPath string
@allowed([
  'swagger-json'
  'swagger-link-json'
  'openapi'
  'openapi+json'
  'openapi+json-link'
  'openapi-link'
  'wadl-link-json'
  'wadl-xml'
  'wsdl'
  'wsdl-link'
  'graphql-link'
])
param apiManagementApiFormat string = 'openapi+json-link'
param apiManagementApiValue string
@allowed([
  'rawxml'
  'rawxml-link'
  'xml'
  'xml-link'
])
param apiManagementApiPolicyFormat string = 'xml'
param apiManagementApiPolicyValue string = '<!--\r\n  IMPORTANT:\r\n  - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n  - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n  - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n  - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.\r\n  - To remove a policy, delete the corresponding policy statement from the policy document.\r\n  - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.\r\n  - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.\r\n  - Policies are applied in the order of their appearance, from the top down.\r\n  - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.\r\n-->\r\n<policies>\r\n  <inbound>\r\n  <base />\r\n  </inbound>\r\n  <backend>\r\n  <base />\r\n  </backend>\r\n  <outbound>\r\n  <base />\r\n  </outbound>\r\n  <on-error>\r\n  <base />\r\n  </on-error>\r\n</policies>'
param apiManagementProductName string = 'default'

var apiManagement = {
  groupName: 'rg-${name}'
  name: 'apim-${name}'
  location: location
  type: 'http'
  api: {
    name: apiManagementApiName
    displayName: apiManagementApiDisplayName
    description: apiManagementApiDescription
    serviceUrl: apiManagementApiServiceUrl
    path: apiManagementApiPath
    subscriptionRequired: apiManagementApiSubscriptionRequired
    format: apiManagementApiFormat
    value: apiManagementApiValue
    policy: {
      format: apiManagementApiPolicyFormat
      value: apiManagementApiPolicyValue
    }
  }
  product: {
    name: apiManagementProductName
  }
}

resource apim 'Microsoft.ApiManagement/service@2022-08-01' existing = {
  name: apiManagement.name
  scope: resourceGroup(apiManagement.groupName)
}

resource apimapi 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: '${apim.name}/${apiManagement.api.name}'
  properties: {
    type: apiManagement.type
    displayName: apiManagement.api.displayName
    description: apiManagement.api.description
    serviceUrl: apiManagement.api.serviceUrl
    path: apiManagement.api.path
    subscriptionRequired: apiManagement.api.subscriptionRequired
    format: apiManagement.api.format
    value: apiManagement.api.value
  }
}

resource apimapipolicy 'Microsoft.ApiManagement/service/apis/policies@2022-08-01' = {
  name: '${apimapi.name}/policy'
  properties: {
    format: apiManagement.api.policy.format
    value: apiManagement.api.policy.value
  }
}

resource apimproduct 'Microsoft.ApiManagement/service/products@2022-08-01' existing = {
  name: '${apim.name}/${apiManagement.product.name}'
  scope: resourceGroup(apiManagement.groupName)
}

resource apimproductapi 'Microsoft.ApiManagement/service/products/apis@2022-08-01' = {
  name: '${apimproduct.name}/${apiManagement.api.name}'
  dependsOn: [
    apimapi
  ]
}

output id string = apimapi.id
output name string = apimapi.name
output path string = reference(apimapi.id).path
