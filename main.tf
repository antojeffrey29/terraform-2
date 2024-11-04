terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "network" {
  source = "./network"
}

module "compute" {
  source             = "./compute"
  vpc_id            = module.network.vpc_id
  public_subnet_id  = module.network.public_subnet_id
  private_subnet_id  = module.network.private_subnet_id
  private_cidr_blocks = [module.network.private_subnet_cidr]
}

module "security" {
  source = "./security"
}

module "others" {
  source       = "./others"
  /*sns_topic_arn = module.others.sns_topic_arn
  sqs_queue_url = module.others.sqs_queue_url*/
}