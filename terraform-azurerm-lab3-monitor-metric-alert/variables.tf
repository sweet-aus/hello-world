variable "name" {
  description = "(Required) Specifies the alert name of the monitor metric." 
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which the monitor metric alert is created. Changing this forces a new resource to be created."
  type        = string
}

variable "scope_resource_id" {
  description = "(Required) Specifies the resource id of monitor metric alert scope." 
  type        = string
}

variable "description" {
  description = "(Required) Specifies the monitor metric alert scope resouce description." 
  type        = string
  default     = "Action will be triggered when Transactions count is greater than 50."
}

variable "criteria_metric_namespace" {
  description = "(Required) Specifies the criteria metric namespace for monitor metric alert." 
  type        = string
  default     = "Microsoft.Storage/storageAccounts"
}
variable "criteria_metric_name" {
  description = "(Required) Specifies the criteria metric name for monitor metric alert." 
  type        = string
  default     = "Transactions"
}
variable "criteria_aggregation" {
  description = "(Required) Specifies the criteria aggregation for monitor metric alert." 
  type        = string
  default     = "Total"
}
variable "criteria_operator" {
  description = "(Required) Specifies the criteria operator for monitor metric alert." 
  type        = string
  default     = "GreaterThan"
}
variable "criteria_threshold" {
  description = "(Required) Specifies the criteria threshold for monitor metric alert." 
  type        = string
  default     = 50
}

variable "dimension_name" {
  description = "(Required) Specifies the dimension name for monitor metric alert." 
  type        = string
  default     = "ApiName"
}
variable "dimension_operator" {
  description = "(Required) Specifies the dimension operator for monitor metric alert." 
  type        = string
  default     = "Include"
}

variable "dimension_values" {
  description = "(Required) Specifies the dimension values for monitor metric alert." 
  type        = list
  default     = []
}


variable "action_group_id" {
  description = "(Required) Specifies the action group id for monitor metric alert." 
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}
