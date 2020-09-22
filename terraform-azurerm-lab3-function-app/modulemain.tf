resource "azurerm_function_app" "fa" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_accesskey
  tags = var.tags
}
