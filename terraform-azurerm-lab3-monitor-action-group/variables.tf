variable "name" {
  description = "(Required) Specifies the name of the monitor action group ." 
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which the function app is created. Changing this forces a new resource to be created."
  type        = string
}

variable "short_name" {
  description = "(Required) Specifies the short name for monitor_action_group." 
  type        = string
}

# variable "azure_app_push_receiver_name" {
#   description = "(Required) Specifies the short name for monitor_action_group." 
#   type        = string
#   default     = "pushtoadmin"

# }

# variable "azure_app_push_receiver_email_address" {
#   description = "(Required) Specifies the short name for monitor_action_group." 
#   type        = string
#   default     ="jannette.wang@lab3.com.au"

# }

variable "logic_app_receiver_name" {
  description = "(Required) Specifies the name of the logic app receiver." 
  type        = string
  default     = "/subscriptions/0b555e31-038f-4c91-9a71-137cad2e6b23/resourceGroups/Jannette-Test-RG/providers/Microsoft.Logic/workflows/logicapp"
}

variable "logic_app_receiver_resouce_id" {
  description = "(Required) Specifies the resouce id of the logic app receiver." 
  type        = string
}
variable "logic_app_receiver_callback_url" {
  description = "(Required) Specifies the receiver callback url of the logic app receiver." 
  type        = string
  default     = "https://prod-20.australiaeast.logic.azure.com:443/workflows/fb7f5e64acd8451c8e0eedd1f98b893a/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=1OaONWYNHU2d1skMskSTLNoH07_fNZlMRkl2LV7ErIk"
}
variable "logic_app_receiver_use_common_alert_schema" {
  description = "(Required) Specifies the common alert schema of the logic app receiver." 
  type        = bool
  default     = true
}

variable "function_receiver_name" {
  description = "(Required) Specifies the nam of the azure function receiver." 
  type        = string
  
}

variable "function_receiver_id" {
  description = "(Required) Specifies the action group function receiver id" 
  type        = string
}

variable "function_receiver_function_name" {
  description = "(Required) Specifies the action group function receiver function name" 
  type        = string
}

variable "function_receiver_function_trigger_url" {
  description = "(Required) Specifies the action group function receiver function trigger url" 
  type        = string
}

variable "function_receiver_use_common_alert_schema" {
  description = "(Required) Specifies the use common alert schema of the logic app receiver." 
  type        = string
  default     = false
}

variable "arm_role_receiver_name" {
  description = "(Required) Specifies the name of arm role receiver" 
  type        = string
  default     = "Monitoring Reader"
}

variable "arm_role_receiver_id" {
  description = "(Required) Specifies the id of arm role receiver" 
  type        = string
  default     = "43d0d8ad-25c7-4714-9337-8ba259a9fe05"
}

variable "arm_role_receiver_use_common_alert_schema" {
  description = "(Required) Specifies the common alert schema of the arm role receiver." 
  type        = string
  default     = false
}

variable "sms_receiver_name" {
  description = "(Required) Specifies the name of sms receiver" 
  type        = string
  default     = "oncallmsg"
}

variable "sms_receiver_country_code" {
  description = "(Required) Specifies the country code of sms receiver" 
  type        = string
  default     = "61"
}

variable "sms_receiver_phone_number" {
  description = "(Required) Specifies the phone number of sms receiver." 
  type        = string
  default     = "410000000"
}

variable "email_list" {
  type = list(object({
      name = string
      email_address = string
  })) 
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


