param name string
param location string = resourceGroup().location

// ⬇️ copilot demo ⬇️
// 1. Define hosting plan variable
// 2. Define resource with hosting plan variable(name, location, sku(name, tier), properties)
// 3. Output id and name of the hosting plan

// Define var hosting plan with name & location parameter defined.
var hostingPlan = {
  name: name
  location: location
}

// Define serverfarms resource named 'asplan'
// with hosting plan variables, sku, and properties defined.
// For sku, I need name, tier parameters
// For properties, I need reserved option
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

// Output id and name from the asplan resource
output id string = asplan.id
output name string = asplan.name

// ⬆️ copilot demo ⬆️
