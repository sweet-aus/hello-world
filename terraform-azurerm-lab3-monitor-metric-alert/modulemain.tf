resource "azurerm_monitor_metric_alert" "mma" {

  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = [var.scope_resource_id]
  description         = var.description 

  criteria {
    metric_namespace = var.criteria_metric_namespace
    metric_name      = var.criteria_metric_name 
    aggregation      = var.criteria_aggregation
    operator         = var.criteria_operator
    threshold        = var.criteria_threshold

    dimension {
      name     = var.dimension_name
      operator = var.dimension_operator
      values   = var.dimension_values 
    }
  }

  action {
    action_group_id = var.action_group_id
  }
  tags = var.tags
}

   /*condition {
    alert_context {
      operator =
      values =
    }
    alert_rule_id {
      operator =
      values =
    }
    description{
      operator =
      values =
    }
    monitor{
      operator =
      values =
    }
    monitor_service{
      operator =
      values =
    }
    severity{
      operator =
      values =
    }
    target_resource_type{
      operator =
      values =
    }
  }*/



 