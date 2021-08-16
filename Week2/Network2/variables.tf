variable "rg-name" {
  type        = string
  description = "name for resource group"
  default     = "PhantomCloud"
}

variable "subnets" {
  description = "object for subnets of the virtual network"
 type = map(object({
    name          = string
    address_space = list(string)
  }))
}

