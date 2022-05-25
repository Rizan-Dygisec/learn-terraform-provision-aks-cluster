
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "triton-azure-rg"
  location = "East Asia"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "triton-azure-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "triton-azure-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "d16s_v4"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }
}
