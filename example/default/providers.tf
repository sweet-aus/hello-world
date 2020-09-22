provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~>2.0"

  subscription_id             = "64ee0347-397f-444d-88df-f9e61c47361a"
  client_id                   = "636db7b0-fedf-4311-a5b7-93648da8842e"
  client_secret               = "tqj69Q5MSja17y.4K7-J~R09su~mkeNM0N"
  tenant_id                   = "991ccec7-0a12-474f-894a-d5982829ecf0"
  features {}
}