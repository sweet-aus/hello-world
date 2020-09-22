
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which the function app is created. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "service_plan_id" {
  description = "(Required) Specifies the id of the app service plan." 
  type        = string
}


variable "name" {
  description = "(Required) Specifies the name of the function app." 
  type        = string
}


variable "storage_account_name" {
  description = "(Required) Specifies the name of the function storage account." 
  type        = string
}


variable "storage_account_accesskey" {
  description = "(Required) Specifies the accesskey of the storage account." 
  type        = string
}

variable "support_group" {
  description = "(Required) Specifies the phone number of sms receiver." 
  type        = string
  default     = "LAB3"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}