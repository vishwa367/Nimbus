resource "azurerm_network_interface" "nics" {
  for_each = var.virtual_machines

  name = each.value.nic_name
  location = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name = "internal"
    subnet_id = data.azurerm_subnet.subnets[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pips[each.key].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment= "preprod"
  }
}

resource "azurerm_network_security_group" "nsgs" {
  for_each = var.virtual_machines

  name = each.value.nsg_name
  location = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name= "test123"
    priority= 100
    direction= "Inbound"
    access= "Allow"
    protocol= "Tcp"
    source_port_range= "*"
    destination_port_range= "22"
    source_address_prefix= "*"
    destination_address_prefix= "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_nic_association" {
  for_each = var.virtual_machines

  network_interface_id = azurerm_network_interface.nics[each.key].id
  network_security_group_id = azurerm_network_security_group.nsgs[each.key].id
}

resource "azurerm_linux_virtual_machine" "vms" {
  for_each = var.virtual_machines

  depends_on = [
    azurerm_network_interface_security_group_association.nsg_nic_association
  ]

  name = each.value.vm_name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
  size = each.value.vm_size
  disk_controller_type = each.value.disk_controller_type
  
  disable_password_authentication = false
  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  network_interface_ids = [ azurerm_network_interface.nics[each.key].id ]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "minimal"
    version   = "latest"
  }
}