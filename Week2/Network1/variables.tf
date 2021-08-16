variable "rg-name" {
  type        = string
  description = "name for resource group"
  default     = "PhantomCloud"
}

variable "network_name" {
  type        = string
  description = "name for virtual network"
}

variable "address_space" {
  type        = list(string)
  description = "range for IPs"
}

variable "subnets" {
  description = "object for subnets of the virtual network"
  type = map(object({
    name          = string
    address_space = list(string)
  }))
}

