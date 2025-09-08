resource "random_string" "root_random_string" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

module "module_resource_group" {
  source                    = "../modules/01-azurerm_resource_group"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
  tags = local.common_tags
}

module "module_virtual_network" {
  depends_on                = [module.module_resource_group]
  source                    = "../modules/02-azurerm_vnet"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
  child_vnet_name           = "${local.formatted_user_prefix}-${var.root_vnet_name}"
  child_vnet_address_space  = var.root_vnet_address_space
  tags = local.common_tags
}

module "module_subnet" {
  depends_on                    = [module.module_virtual_network]
  source                        = "../modules/03-azurerm_subnet"
  child_resource_group_name     = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_vnet_name               = "${local.formatted_user_prefix}-${var.root_vnet_name}"
  child_subnet_name             = "${local.formatted_user_prefix}-${var.root_subnet_name}"
  child_subnet_address_prefixes = var.root_subnet_address_prefixes
  tags = local.common_tags
}

module "module_nsg" {
  depends_on                = [module.module_subnet]
  source                    = "../modules/04-azurerm_nsg"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_nsg_name            = "${local.formatted_user_prefix}-${var.root_nsg_name}"
  child_resource_location   = var.root_resource_location
  tags = local.common_tags
}

module "module_public_ip" {
  depends_on                = [module.module_nsg]
  source                    = "../modules/05-azurerm_public_ip"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_public_Ip_name      = "${local.formatted_user_prefix}-${var.root_public_Ip_name}"
  child_resource_location   = var.root_resource_location
  tags = local.common_tags
}

module "module_nic" {
  depends_on                = [module.module_public_ip]
  source                    = "../modules/06-azurerm_nic"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
  child_nic_name            = "${local.formatted_user_prefix}-${var.root_nic_name}"
  child_ip_config_name      = "${local.formatted_user_prefix}-${var.root_ip_config_name}"
  child_public_Ip_name      = "${local.formatted_user_prefix}-${var.root_public_Ip_name}"
  child_subnet_name         = "${local.formatted_user_prefix}-${var.root_subnet_name}"
  child_vnet_name           = "${local.formatted_user_prefix}-${var.root_vnet_name}"
}

module "module_nic_nsg_association" {
  depends_on                = [module.module_nic]
  source                    = "../modules/07-azurerm_nic_nsg_association"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_nic_name            = "${local.formatted_user_prefix}-${var.root_nic_name}"
  child_nsg_name            = "${local.formatted_user_prefix}-${var.root_nsg_name}"
}

module "module_virtual_machine" {
  depends_on                     = [module.module_nic_nsg_association]
  source                         = "../modules/08-azurerm_virtual_machine"
  child_resource_group_name      = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location        = var.root_resource_location
  child_virtual_machine_name     = "${local.formatted_user_prefix}-${var.root_virtual_machine_name}"
  child_virtual_machine_username = "${local.formatted_user_prefix}-${var.root_virtual_machine_username}"
  child_virtual_machine_password = "${local.formatted_user_prefix}-${var.root_virtual_machine_password}"
  child_nic_name                 = "${local.formatted_user_prefix}-${var.root_nic_name}"
  tags = local.common_tags
}