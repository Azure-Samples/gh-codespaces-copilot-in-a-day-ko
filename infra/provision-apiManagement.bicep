param name string
param location string = resourceGroup().location

param apiManagementPublisherName string
param apiManagementPublisherEmail string

@allowed([
  'rawxml'
  'rawxml-link'
  'xml'
  'xml-link'
])
param apiManagementPolicyFormat string = 'xml'
param apiManagementPolicyValue string = '<!--\r\n  IMPORTANT:\r\n  - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n  - Only the <forward-request> policy element can appear within the <backend> section element.\r\n  - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n  - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n  - To add a policy position the cursor at the desired insertion point and click on the round button associated with the policy.\r\n  - To remove a policy, delete the corresponding policy statement from the policy document.\r\n  - Policies are applied in the order of their appearance, from the top down.\r\n-->\r\n<policies>\r\n  <inbound></inbound>\r\n  <backend>\r\n  <forward-request />\r\n  </backend>\r\n  <outbound></outbound>\r\n</policies>'

module wrkspc './logAnalyticsWorkspace.bicep' = {
  name: 'LogAnalyticsWorkspace_APIM'
  params: {
    name: name
    location: location
  }
}

module appins './applicationInsights.bicep' = {
  name: 'ApplicationInsights_APIM'
  params: {
    name: name
    location: location
    workspaceId: wrkspc.outputs.id
  }
}

module apim './apiManagement.bicep' = {
  name: 'ApiManagement_APIM'
  params: {
    name: name
    location: location
    appInsightsId: appins.outputs.id
    appInsightsInstrumentationKey: appins.outputs.instrumentationKey
    apiManagementPublisherName: apiManagementPublisherName
    apiManagementPublisherEmail: apiManagementPublisherEmail
    apiManagementPolicyFormat: apiManagementPolicyFormat
    apiManagementPolicyValue: apiManagementPolicyValue
  }
}
