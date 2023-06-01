# Standard AWS Provider Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.0"
    }

  }
}

provider "aws" {
    region = local.PROFILES["AWS_REG1"].CODE
    profile = local.PROFILES["AWS_REG1"].NAME
    alias = "Seoul"
}

provider "aws" {
    region = local.PROFILES["AWS_REG2"].CODE
    profile = local.PROFILES["AWS_REG2"].NAME
    alias = "Singapore"
}