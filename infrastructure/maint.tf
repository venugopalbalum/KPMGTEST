#Provider section
provider   "azurerm"   { 
   version   =   "= 2.0.0" 
   features   {} 
 }
# Creater resource group
resource   "azurerm_resource_group"   "rg"   { 
   name   =   "test-terraform-rg" 
   location   =   "eastus" 
   account_tier = "Standard"
   
   tags = {
        environment = "Terraform Test"
    }
 }
# Define Virtual Network and Subnet 
resource   "azurerm_virtual_network"   "myvnet"   { 
   name   =   "test-vnet" 
   address_space   =   [ "10.0.0.0/16" ] 
   location   =   "eastus" 
   resource_group_name   =   azurerm_resource_group.rg.name 
 } 
#Subnet 
 resource   "azurerm_subnet"   "frontendsubnet"   { 
   name   =   "frontendSubnet" 
   resource_group_name   =    azurerm_resource_group.rg.name 
   virtual_network_name   =   azurerm_virtual_network.myvnet.name 
   address_prefix   =   "10.0.1.0/24" 
 }
