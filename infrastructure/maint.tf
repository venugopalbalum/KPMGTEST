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
#Public IP
resource   "azurerm_public_ip"   "myvm1publicip"   { 
   name   =   "pip1" 
   location   =   "eastus" 
   resource_group_name   =   azurerm_resource_group.rg.name 
   allocation_method   =   "Dynamic" 
   sku   =   "Basic" 
 }
# NIC config
resource   "azurerm_network_interface"   "myvm1nic"   { 
   name   =   "myvm1-nic" 
   location   =   "eastus" 
   resource_group_name   =   azurerm_resource_group.rg.name 

   ip_configuration   { 
     name   =   "ipconfig1" 
     subnet_id   =   azurerm_subnet.frontendsubnet.id 
     private_ip_address_allocation   =   "Dynamic" 
     public_ip_address_id   =   azurerm_public_ip.myvm1publicip.id 
   } 
 }
# VM provision
resource   "azurerm_windows_virtual_machine"   "example"   { 
   name                    =   "testvm"   
   location                =   "eastus" 
   resource_group_name     =   azurerm_resource_group.rg.name 
   network_interface_ids   =   [ azurerm_network_interface.myvm 1 nic.id ] 
   size                    =   "Standard_B1s" 
   admin_username          =   "XXXX" 
   admin_password          =   "XXXXX" 

   source_image_reference   { 
     publisher   =   "MicrosoftWindowsServer" 
     offer       =   "WindowsServer" 
     sku         =   "2019-Datacenter" 
     version     =   "latest" 
   } 

   os_disk   { 
     caching             =   "ReadWrite" 
     storage_account_type   =   "Standard_LRS" 
   } 
   tags = {
        environment = "Terraform Test"
    }
 }
