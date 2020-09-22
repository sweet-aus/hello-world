resource "azurerm_monitor_action_rule_action_group" "marag" {
  name                = var.name
  #resource_group_name = azurerm_resource_group.rg.name
  resource_group_name = var.resource_group_name
  action_group_id     = var.action_group_id

  scope {
    type         = var.scope_type
    resource_ids = [var.scope_resource_id_list]
  }
  tags = var.tags
}
 
