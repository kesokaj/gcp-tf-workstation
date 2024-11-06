module "base" {
  source = "./modules/bootstrap/base"
  billing_id = var.billing_id
  org_id = var.org_id
  org_policy_list = var.org_policy_list
  service_list = var.service_list
}

module "network" {
  depends_on = [ module.base ]  
  source = "./modules/bootstrap/network"
  alias = module.base.alias
  project_id = module.base.project_id
  vpc_config = var.vpc_config
  firewall_config = var.firewall_config
  peer_allocation = var.peer_allocation
  logs_config = var.logs_config
}

module "cicd" {
  depends_on = [ module.network ]
  source = "./modules/bootstrap/cicd"
  alias = module.base.alias
  project_id = module.base.project_id
  project_number = module.base.project_number
  region = element(module.network.subnet, 0)
  git_repo = var.git_repo
}

module "workstation" {
  depends_on = [ module.cicd ]
  source = "./modules/bootstrap/workstation"
  alias = module.base.alias
  project_id = module.base.project_id
  region = element(module.network.subnet, 0)
  network = module.network.vpc_id
  subnet_id = element(module.network.subnet_id, 0)
}

module "post" {
  depends_on = [ module.workstation ]
  source = "./modules/bootstrap/post"
  project_id = module.base.project_id
  alias = module.base.alias
}