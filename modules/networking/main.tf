module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source = "./modules/subnets"

  vpc_id             = module.vpc.vpc_id
  public_subnet_cidr = var.public_subnet_cidr
  region             = var.region
}

module "igw" {
  source = "./modules/igw"

  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source = "./modules/route_table"

  vpc_id        = module.vpc.vpc_id
  igw_id        = module.igw.igw_id
  subnet_id     = module.subnets.public_subnet_id
}
