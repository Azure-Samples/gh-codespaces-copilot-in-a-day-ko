param name string
param location string = resourceGroup().location

var hostingPlan = {
    name: name
    location: location
}

// ⬇️ copilot demo ⬇️
// 1. Define serverfarm resource with hosting plan variable(name, location, sku(name, tier), properties)
// 2. Output id and name of the hosting plan

// ⬆️ copilot demo ⬆️
