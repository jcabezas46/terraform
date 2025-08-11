terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}

provider "aws" {
  secret_key =  var.secret_key
  access_key = var.acces_key

} 

resource "aws_vpc" "vpc_virginia" {
  cidr_block       = var.virginia_cidr
  instance_tenancy = "default"
    tags = {
    "Name" = "prueba"
    }

}

resource "aws_subnet" "public_subnet" {
 vpc_id =aws_vpc.vpc_virginia.id
 cidr_block = var.subnets[0]
 map_public_ip_on_launch = true
  }

resource "aws_subnet" "private_subnet" {
 vpc_id =aws_vpc.vpc_virginia.id
 cidr_block = var.subnets[1]
  }


