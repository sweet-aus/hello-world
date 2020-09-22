variable "name" {
  description = "(Required) Specifies the name of monitor action rule action group." 
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which the function app is created. Changing this forces a new resource to be created."
  type        = string
}

variable "action_group_id" {
  description = "(Required) Specifies the action group id of monitor action rule action group" 
  type        = string
}

variable "scope_type" {
  description = "(Required) Specifies the scope type of monitor action rule action group." 
  type        = string
  default     = "ResourceGroup"
}


variable "scope_resource_id_list" {
  description = "(Required) Specifies the scope resource id list of the resouce inside the scope." 
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}

 