# naming convention
resource "azurecaf_name" "er_gateway" {
  count = var.virtual_hub_config.deploy_er ? 1 : 0

  name          = try(var.virtual_hub_config.er_config.name, null)
  resource_type = "azurerm_express_route_gateway"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


## create the ER Gateway
resource "azurerm_express_route_gateway" "er_gateway" {
  depends_on = [azurerm_virtual_hub.vwan_hub]
  count      = var.virtual_hub_config.deploy_er ? 1 : 0

  name                = azurecaf_name.er_gateway.0.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
  virtual_hub_id      = azurerm_virtual_hub.vwan_hub.id

  scale_units = var.virtual_hub_config.er_config.scale_units
  timeouts {
    create = "60m"
    delete = "120m"
  }
}