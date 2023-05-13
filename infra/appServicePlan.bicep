param name string
param location string = resourceGroup().location

// ⬇️ copilot demo ⬇️
// 1. Define hosting plan variable
// 2. Define resource with hosting plan variable(name, location, sku(name, tier), properties)
// 3. Output id and name of the hosting plan

var hostingPlan = {
    name: 'asplan-${name}'
    location: location
}
  
resource asplan 'Microsoft.Web/serverfarms@2022-03-01' = {
    name: hostingPlan.name
    location: hostingPlan.location
    sku: {
        name: 'S1'
        tier: 'Standard'
    }
    properties: {
        reserved: true
    }
}

output id string = asplan.id
output name string = asplan.name
// ⬆️ copilot demo ⬆️
