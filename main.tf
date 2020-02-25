provider "azurerm" {
  version = ">= 1.32.0"
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_subnet" "main" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = data.azurerm_virtual_network.main.name
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "tls_private_key" "pair" {
  algorithm = "RSA"
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  dns_prefix          = var.dns_prefix

  kubernetes_version = var.kubernetes_version

  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = var.vm_size
    vnet_subnet_id  = data.azurerm_subnet.main.id
    os_type         = "Linux"
    os_disk_size_gb = var.os_disk_size_gb

    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true

    min_count = var.min_count
    max_count = var.max_count
    max_pods  = var.max_pods
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = tls_private_key.pair.public_key_openssh
    }
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  network_profile {
    network_plugin = "azure"
  }

  addon_profile {
    kube_dashboard {
      enabled = var.dashboard
    }
  }

  role_based_access_control {
    enabled = var.rbac
  }

  tags = {
    environment = var.tag_environment
  }
}
