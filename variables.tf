variable "resource_group_name" {
  description = "The name of the existing resource group. Must be unique on your Azure subscription."
}

variable "virtual_network_name" {
  description = "The name of the existing virtual network. Changing this forces a new resource to be created."
}

variable "subnet_name" {
  description = "The name of the existing subnet. Changing this forces a new resource to be created."
}

variable "name" {
  description = "The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
  default     = "myaks"
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number."
  default     = "globalunique"
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)."
  default     = "1.14.8"
}

variable "vm_size" {
  description = "The size of each VM in the Agent Pool (e.g. Standard_F1). Changing this forces a new resource to be created."
  default     = "Standard_DS1_v2"
}

variable "os_disk_size_gb" {
  description = "The Agent Operating System disk size in GB. Changing this forces a new resource to be created."
  default     = 30
}

variable "min_count" {
  description = "Minimum number of nodes for auto-scaling"
  default     = 1
}

variable "max_count" {
  description = "Maximum number of nodes for auto-scaling"
  default     = 3
}

variable "max_pods" {
  description = "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  default     = 110
}

variable "admin_username" {
  description = "The Admin Username for the Cluster. Changing this forces a new resource to be created."
  default     = "aksadmin"
}

variable "client_id" {
  description = "The Client ID for the Service Principal."
}

variable "client_secret" {
  description = "The Client Secret for the Service Principal."
}

variable "tag_environment" {
  description = "Environment name for tagging"
  default     = "development"
}

variable "rbac" {
  description = "enable or disable RBAC for kubernetes cluster"
  default     = "disabled"
}