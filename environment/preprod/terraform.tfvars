rgs = {
    rg1= {
        name= "nimbus_rg"
        location= "eastus"
    }
}

vnets = {
    vnet1= {
        name= "nimbus_vnet"
        location= "eastus"
        address_space= ["10.0.0.0/16"]
        resource_group_name= "nimbus_rg"
    }
}

subnets = {
    subnet1= {
        name= "frontend_nimbus"
        resource_group_name= "nimbus_rg"
        virtual_network_name= "nimbus_vnet"
        address_prefixes= ["10.0.1.0/24"]
    }
    subnet2= {
        name= "backend_nimbus"
        resource_group_name= "nimbus_rg"
        virtual_network_name= "nimbus_vnet"
        address_prefixes= ["10.0.2.0/24"]
    }
    subnet3= {
        name= "database_nimbus"
        resource_group_name= "nimbus_rg"
        virtual_network_name= "nimbus_vnet"
        address_prefixes= ["10.0.3.0/24"]
    }
}

public_ips = {
    ip1= {
        name= "frontend_ip"
        resource_group_name= "nimbus_rg"
        location= "eastus"
        allocation_method= "Static"
    }
    ip2= {
        name= "backend_ip"
        resource_group_name= "nimbus_rg"
        location= "eastus"
        allocation_method= "Static"
    }
    ip3= {
        name= "database_ip"
        resource_group_name= "nimbus_rg"
        location= "eastus"
        allocation_method= "Static"
    }
}

virtual_machines = {
    vm1= {
        vm_name= "frontend-vm"
        vm_size= "Standard_F1als_v7"
        admin_username= "adminuser"
        admin_password= "adminuser@123"
        nsg_name= "frontend_nsg"
        nic_name= "frontend_nic"
        location= "eastus"
        resource_group_name= "nimbus_rg"
        subnet_name= "frontend_nimbus"
        virtual_network_name= "nimbus_vnet"
        public_ip_name= "frontend_ip"
        disk_controller_type= "NVMe"
    }
    vm2= {
        vm_name= "backend-vm"
        vm_size= "Standard_F1als_v7"
        admin_username= "adminuser"
        admin_password= "adminuser@123"
        nsg_name= "backend_nsg"
        nic_name= "backend_nic"
        location= "eastus"
        resource_group_name= "nimbus_rg"
        subnet_name= "backend_nimbus"
        virtual_network_name= "nimbus_vnet"
        public_ip_name= "backend_ip"
        disk_controller_type= "NVMe"
    }
    vm3= {
        vm_name= "database-vm"
        vm_size= "Standard_F1als_v7"
        admin_username= "adminuser"
        admin_password= "adminuser@123"
        nsg_name= "database_nsg"
        nic_name= "database_nic"
        location= "eastus"
        resource_group_name= "nimbus_rg"
        subnet_name= "database_nimbus"
        virtual_network_name= "nimbus_vnet"
        public_ip_name= "database_ip"
        disk_controller_type= "NVMe"
    }
}