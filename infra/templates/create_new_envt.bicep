
param location string = resourceGroup().location
param app_name string = 'techsckoolvijay'
param storageNamePrefix  string = 'techsckool'
param acr_name string = 'techsckoolacr'
param asb_name string = 'techsckoolasb'

var stgacc_name = 'stg${storageNamePrefix}${uniqueString(resourceGroup().id)}' 
var asp_name  = 'ASP-${app_name}'

resource storageAccounts 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: stgacc_name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'BlobStorage'
  properties: {
    accessTier: 'Cool'
  }
}


resource container_registery 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
  name: acr_name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}


resource asp 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: asp_name
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  kind: 'linux'
}

resource webapp 'Microsoft.Web/sites@2018-11-01' = {
  name: app_name
  location: location
  tags: null
  properties: {         
    serverFarmId: asp.id
    clientAffinityEnabled: false
    httpsOnly: true
  }
  dependsOn: []
}

resource asb 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: asb_name
  location: location
}
