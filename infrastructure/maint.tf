#Provider section
provider   "azurerm"   { 
   version   =   "= 2.0.0" 
   features   {} 
 }
# Creater resource group
resource   "azurerm_resource_group"   "rg"   { 
   name   =   "my-first-terraform-rg" 
   location   =   "eastus" 
 }
