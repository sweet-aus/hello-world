

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which the Log Analytics workspace is created. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "name" {
  description = "(Required) Specifies the name of the app service plan."
  type        = string
}

variable "sku_tier" {
  description = "(Required) Specifies the app service plan's pricing tier."
  type        = string
  default     = "Standard"
}

variable "sku_size" {
  description = "(Required) Specifies the plan's instance size."
  type        = string
  default     = "S1"
}

variable "support_group" {
  description = "(Required) Specifies the department of the support." 
  type        = string
  default     = "LAB3"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}

 