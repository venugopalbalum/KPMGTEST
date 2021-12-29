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
