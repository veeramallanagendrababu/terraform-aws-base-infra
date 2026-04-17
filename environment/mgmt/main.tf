module "networking" {
  source = "../../modules/networking"

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  region             = var.region
}

module "security" {
  source = "../../modules/security"

  vpc_id = module.networking.vpc_id
}

module "compute" {
  source = "../../modules/compute"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id         = module.networking.public_subnet_id
  vpc_id            = module.networking.vpc_id 
  security_group_id = module.security.sg_id
}
