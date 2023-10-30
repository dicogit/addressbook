terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.21.0"
        }
    }
    backend "s3" {
        bucket = "tfbkp"
        key = "terraform-sf"
        region = "ap-south-1"
        dynamodb_table = "tfbkp-tbl"
    }
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "tfvpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env}-tfvpc"
  }
}

module "myown-subnet" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.tfvpc.id
  subnet_cidr_block = var.subnet_cidr_block
  az = var.az
  env = var.env
}

module "myown-instance" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.tfvpc.id
  subnet_id = module.myown-subnet.subnet.id
  instance_type = var.instance_type
  env = var.env
}
