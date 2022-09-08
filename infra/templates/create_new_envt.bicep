
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
    //serverFarmId: '/subscriptions/${subscriptionId}/resourcegroups/${serverFarmResourceGroup}/providers/Microsoft.Web/serverfarms/${hostingPlanName}'
    // serverFarmId: '/subscriptions/db8fcd00-4f68-42c3-8b19-947bf4d7b2c5/resourceGroups/lab/providers/Microsoft.Web/serverFarms/ASP-lab-94dc-vijaytest'
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: '${container_registery.name}.azurecr.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: container_registery.name
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: ''
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
      linuxFxVersion: 'DOCKER|${container_registery.name}.azurecr.io:myimage:latest'
      alwaysOn: true
      ftpsState: 'FtpsOnly'
    }
    serverFarmId: serverfarms_ASP_lab_94dc_name_resource.id
    clientAffinityEnabled: false
    httpsOnly: true
  }
  dependsOn: []
}
