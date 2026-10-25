module "rg" {
  source = "../../modules/azure_resource_group"
  rgs = var.rgs
}

module "vnet" {
  depends_on = [ module.rg ]
  source = "../../modules/azure_virtual_network"
  vnets= var.vnets
}

module "subnets" {
  depends_on = [ module.vnet ]
  source = "../../modules/azure_subnet"
  subnets = var.subnets
}

module "pips" {
  depends_on = [ module.rg ]
  source = "../../modules/azure_public_ip"
  public_ips= var.public_ips
}

module "vms" {
  depends_on = [ module.pips, module.subnets ]
  source = "../../modules/azure_virtual_machine"
  virtual_machines= var.virtual_machines
}