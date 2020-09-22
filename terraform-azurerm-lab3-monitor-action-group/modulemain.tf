
resource "azurerm_monitor_action_group" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  short_name          = var.short_name


  logic_app_receiver {
    name                    = var.logic_app_receiver_name
    resource_id             = var.logic_app_receiver_resouce_id
    callback_url            = var.logic_app_receiver_callback_url
    use_common_alert_schema = var.logic_app_receiver_use_common_alert_schema
  }

  azure_function_receiver {
    name = var.function_receiver_name
    function_app_resource_id = var.function_receiver_id
    function_name = var.function_receiver_function_name
    http_trigger_url = var.function_receiver_function_trigger_url
    use_common_alert_schema = false
  }

  arm_role_receiver {
    name = var.arm_role_receiver_name
    role_id = var.arm_role_receiver_id
    use_common_alert_schema = var.arm_role_receiver_use_common_alert_schema
  }


  dynamic "email_receiver" {
    for_each = {for i in var.email_list: i.name => i.email_address}
    content {
      name          = email_receiver.key
      email_address = email_receiver.value
    }
  }

  sms_receiver {
    name         = var.sms_receiver_name
    country_code = var.sms_receiver_country_code
    phone_number = var.sms_receiver_phone_number
  }
  tags = var.tags

}