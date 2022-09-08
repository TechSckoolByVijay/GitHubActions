
param location string = resourceGroup().location
param name string = 'techsckoolvijay'
param asp_name string = 'ASP-lab-94dc-techsckool'
param acr_name string = 'vijaytechsckoolacr'

// resource storageAccounts 'Microsoft.Storage/storageAccounts@2021-09-01' = {
//   name: 'vijaytechsckool321'
//   location: location
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'BlobStorage'
//   properties: {
//     accessTier: 'Cool'
//   }
//   tags: {
//     key: 'value'
//   }
// }




// resource virtualMachines 'Microsoft.Compute/virtualMachines@2022-03-01' = {
//   name: 'labvm'
//   location: location
//   properties: {
//     storageProfile: {
//       dataDisks: 
//     }
//   }
// }





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

resource serverfarms_ASP_lab_94dc_name_resource 'Microsoft.Web/serverfarms@2022-03-01' = {
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





resource name_resource 'Microsoft.Web/sites@2018-11-01' = {
  name: name
  location: location
  tags: null
  properties: {         
    serverFarmId: serverfarms_ASP_lab_94dc_name_resource.id
    clientAffinityEnabled: false
    httpsOnly: true
  }
  dependsOn: []
}
