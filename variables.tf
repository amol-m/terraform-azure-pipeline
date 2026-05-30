variable "resource_group_name" {
  default = "jenkins-tf-rg"
}

variable "location" {
  default = "eastus"
}

variable "tags" {
  default = {
    env        = "dev"
    owner      = "kanchan"
    managed_by = "terraform"
    pipeline   = "jenkins"
  }
}