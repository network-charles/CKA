terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.5"
    }
  }

  required_version = "v1.7.1"
}

# Configure the AWS Provider per region
provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Provisioned = "Terraform"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
  alias = "eu-west-2"

  default_tags {
    tags = {
      Provisioned = "Terraform"
    }
  }
}
