
# This example deploy Action Group including Log Analytics Workspace,Solutions,Storage,Fuction
resource "random_shuffle" "location" {
  input        = ["australiasoutheast"]
  result_count = 1
}


resource "random_shuffle" "environment" {
  input        = ["dev", "uat"]
  result_count = 1
}


resource "random_string" "unique_id" {
  #https://docs.w3cub.com/terraform/providers/random/r/string/
  length  = 16
  special = false
}


resource "random_id" "unique" {
  /*keepers = {
    # Generate a new id each time we switch to a new resource group
    group_name = var.resource_group_name
  }*/

  byte_length = 8
}


resource "random_id" "short" {
  /*keepers = {
    # Generate a new id each time we switch to a new resource group
    group_name = var.resource_group_name
  }*/

  byte_length = 4
}


locals {
  # location       = "australiaeast"
  # environment    = "dev"
  location       = random_shuffle.location.result[0]
  environment    = random_shuffle.environment.result[0]
}


module "naming" {
  source = "github.com/lab3au/terraform-azurerm-lab3-naming"

  unique_id        = random_id.unique.hex
  location         = local.location
  environment      = local.environment

  sequence_start   = 1
  sequence_count   = 2
  sequence_padding = 3
}


module "example_rg" {
  source = "github.com/lab3au/terraform-azurerm-lab3-resource-group"

  name             = module.naming.resource_group_name
  location         = local.location

  tags = {
    support_group  = "LAB3"
    environment    = local.environment
    cost_centre    = "c111"
    application_id = "a222"
    test_module    = dirname(abspath(path.module))
    last_run       = formatdate("YYYY-MM-DD", timestamp())
    terraform      = true
  }
}


module "example_aa" {
  source = "github.com/lab3au/terraform-azurerm-lab3-automation-account"

  name                = module.naming.automation_account_name
 # Specifies the name of the automation account. Workspace name should include 4-63 letters, digits or '-'. 
 # The '-' shouldn't be the first or the last symbol. Changing this forces a new resource to be created.
  resource_group_name = module.naming.resource_group_name
  location            = local.location

  tags = {
    support_group     = "LAB3"
    environment       = local.environment
    cost_centre       = "c111"
    application_id    = "a222"
    test_module       = dirname(abspath(path.module))
    last_run          = formatdate("YYYY-MM-DD", timestamp())
    terraform         = true
  }

  depends_on = [module.example_rg]
}


module "example_law" {

  source = "github.com/lab3au/terraform-azurerm-lab3-log-analytics-workspace"

  name                          = module.naming.sequence.log_analytics_workspace_name[1]
  resource_group_name           = module.naming.resource_group_name
  location                      = local.location

  enable_standard_datasources   = true
  enable_standard_savedsearches = true
  enable_standard_metricalerts  = true

  linked_service_resource = {
    enable = true
    id     = module.example_aa.id
  }

  plan = {
    example_solution_1 = {
      publisher      = "Microsoft"
      product        = "OMSGallery/ServiceDesk"
      promotion_code = null
    }
  }

  tags = {
    support_group  = "LAB3"
    environment    = local.environment
    cost_centre    = "c111"
    application_id = "a222"
    test_module    = dirname(abspath(path.module))
    last_run       = formatdate("YYYY-MM-DD", timestamp())
    terraform      = true
  }

  depends_on = [module.example_aa]
}


module "example_sa" {
  source = "github.com/lab3au/terraform-azurerm-lab3-storage-account"

  name                    = module.naming.sequence.storage_account_name[1]
  resource_group_name     = module.naming.resource_group_name
  location                = local.location
  kind                    = "StorageV2"
  tier                    = "Standard"
  access_tier             = "Cool"
  create_managed_identity = true
  tags = {
    support_group  = "LAB3"
    environment    = local.environment
    cost_centre    = "c111"
    application_id = "a222"
    test_module    = dirname(abspath(path.module))
    last_run       = formatdate("YYYY-MM-DD", timestamp())
    terraform      = true
  }

  depends_on = [module.example_rg]

}


module "example_asp" {
  #source = "github.com/lab3au/terraform-azurerm-lab3-app-service-plan"
  source = "../../terraform-azurerm-lab3-app-service-plan/"

  name                      = module.naming.sequence.app_service_plan_name[1]
  resource_group_name       = module.naming.resource_group_name
  location                  = local.location
  sku_tier                  = "Standard"
  sku_size                  = "S1"
  tags = {
    support_group  = "LAB3"
    environment    = local.environment
    cost_centre    = "c111"
    application_id = "a222"
    test_module    = dirname(abspath(path.module))
    last_run       = formatdate("YYYY-MM-DD", timestamp())
    terraform      = true
  }
}


module "example_fa" {
  #source = "github.com/lab3au/terraform-azurerm-lab3-function-app"
  source = "../../terraform-azurerm-lab3-function-app"

  name                          = module.naming.sequence.function_app_name[1]
  resource_group_name           = module.naming.resource_group_name
  location                      = local.location
  service_plan_id               = module.example_asp.id
  storage_account_name          = module.example_sa.name
  storage_account_accesskey     = module.example_sa.primary_access_key
  tags = {
    support_group  = "LAB3"
    environment    = local.environment
    cost_centre    = "c111"
    application_id = "a222"
    test_module    = dirname(abspath(path.module))
    last_run       = formatdate("YYYY-MM-DD", timestamp())
    terraform      = true
  }
}


module "example_mag" {
  #source = "github.com/lab3au/terraform-azurerm-lab3-monitor_action_group"
  source = "../../terraform-azurerm-lab3-monitor-action-group"

  name                                        = "mag-${random_id.unique.hex}"
  resource_group_name                         = module.naming.resource_group_name
  short_name                                  = "mg-${random_id.short.hex}"

  logic_app_receiver_name                     = module.naming.sequence.logic_app_name[1]
  logic_app_receiver_resouce_id               = "/subscriptions/0b555e31-038f-4c91-9a71-137cad2e6b23/resourceGroups/Jannette-Test-RG/providers/Microsoft.Logic/workflows/logicapp"
  logic_app_receiver_callback_url             = "https://prod-20.australiaeast.logic.azure.com:443/workflows/fb7f5e64acd8451c8e0eedd1f98b893a/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=1OaONWYNHU2d1skMskSTLNoH07_fNZlMRkl2LV7ErIk"
  logic_app_receiver_use_common_alert_schema  = true

  function_receiver_name                      = "magfr-${random_id.unique.hex}"
  function_receiver_id                        = module.example_fa.id
  function_receiver_function_name             = module.example_fa.name
  function_receiver_function_trigger_url      = "https://example.com/trigger"
  function_receiver_use_common_alert_schema   = false

  arm_role_receiver_name                      = "magrr-${random_id.unique.hex}"
  arm_role_receiver_id                        = "43d0d8ad-25c7-4714-9337-8ba259a9fe05"
  arm_role_receiver_use_common_alert_schema   = false
  
  email_list = [
        { 
            name = "DevOpsAdmin1"
            email_address = "jannette.wang@lab3.com.au"
        },
        { 
            name = "DevOpsAdmin2"
            email_address = "jannettewang@hotmail.com"
        }
    ]

  sms_receiver_name                           = "magsms-${random_id.unique.hex}"
  sms_receiver_country_code                   = "61"
  sms_receiver_phone_number                   = "450666766"
  tags = {
    support_group  = "LAB3"
    environment    = local.environment
    cost_centre    = "c111"
    application_id = "a222"
    test_module    = dirname(abspath(path.module))
    last_run       = formatdate("YYYY-MM-DD", timestamp())
    terraform      = true
  }
}


module "example_marag" {
  #source = "github.com/lab3au/terraform-azurerm-lab3-monitor_action_rule_action_group"
  source = "../../terraform-azurerm-lab3-monitor-action-rule-action-group"

  name                          = "macrag-${random_id.unique.hex}"
  resource_group_name           = module.naming.resource_group_name
  action_group_id               = module.example_mag.id

  scope_type                    = "ResourceGroup"
  scope_resource_id_list        = module.example_rg.id


  tags = {
    support_group  = "LAB3"
    environment    = local.environment
    cost_centre    = "c111"
    application_id = "a222"
    test_module    = dirname(abspath(path.module))
    last_run       = formatdate("YYYY-MM-DD", timestamp())
    terraform      = true
  }
}

module "example_mma" {
  #source = "github.com/lab3au/terraform-azurerm-lab3-monitor-metric-alert"
  source = "../../terraform-azurerm-lab3-monitor-metric-alert"
  
  name                      = "mma-${random_id.unique.hex}"
  resource_group_name       = module.naming.resource_group_name
  scope_resource_id         = module.example_sa.id
  description               = "Action will be triggered when Transactions count is greater than 50."


  criteria_metric_namespace = "Microsoft.Storage/storageAccounts"
  criteria_metric_name      = "Transactions"
  criteria_aggregation      = "Total"
  criteria_operator         = "GreaterThan"
  criteria_threshold        = 50
  
  dimension_name            = "ApiName"
  dimension_operator        = "Include"
  dimension_values          = ["*"]

  action_group_id           = module.example_mag.id

  tags = {
      support_group  = "LAB3"
      environment    = local.environment
      cost_centre    = "c111"
      application_id = "a222"
      test_module    = dirname(abspath(path.module))
      last_run       = formatdate("YYYY-MM-DD", timestamp())
      terraform      = true
    }
}
