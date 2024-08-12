################
### SETTINGS ###
################

terraform {
  required_version = ">= 1.2.0"

  required_providers {

    kind = {
      source  = "tehcyx/kind"
      version = "0.5.1"
    }
  }
}

############
### DATA ###
############

data "aws_caller_identity" "current" {}
