
param location string = resourceGroup().location

param app_name string = 'techsckoolvijay'
param asp_name string = 'ASP-${app_name}'
param acr_name string = 'vijaytechsckoolacr'
param asb_name string = 'vijaytechsckoolasb'

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
  name: app_name
  location: location
  tags: null
  properties: {         
    //serverFarmId: '/subscriptions/${subscriptionId}/resourcegroups/${serverFarmResourceGroup}/providers/Microsoft.Web/serverfarms/${hostingPlanName}'
    // serverFarmId: '/subscriptions/db8fcd00-4f68-42c3-8b19-947bf4d7b2c5/resourceGroups/lab/providers/Microsoft.Web/serverFarms/ASP-lab-94dc-vijaytest'
    serverFarmId: serverfarms_ASP_lab_94dc_name_resource.id
    clientAffinityEnabled: false
    httpsOnly: true
  }
  dependsOn: []
}



resource asb 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: asb_name
  location: location
}
