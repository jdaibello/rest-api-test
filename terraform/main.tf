################
### SETTINGS ###
################

terraform {
  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "test-joao-daibello-backend-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "test-joao-daibello-terraform-state-locking-table"
  }

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }

    kind = {
      source  = "tehcyx/kind"
      version = "0.5.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.31.0"
    }
  }
}

########################
### PROVIDER CONFIGS ###
########################

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  config_path = module.cluster.kubeconfig_path
}

############
### DATA ###
############

data "aws_caller_identity" "current" {}

###############
### MODULES ###
###############

module "cluster" {
  source = "./cluster"
}

module "resources" {
  source          = "./resources"
  kubeconfig_path = module.cluster.kubeconfig_path
  dockerhub_email = var.dockerhub_email
  dockerhub_username = var.dockerhub_username
  dockerhub_password = var.dockerhub_password
}
