terraform {
  required_version = "~> 0.12"

  required_providers {
    aws = "~> 2.56"
  }
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "selected" {
  default = true
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id
}

locals {
  tags = merge(
    var.tags,
    map(
      "environment", var.environment
    )
  )
  vpc             = data.aws_vpc.selected.id
  private_subnets = data.aws_subnet_ids.private.ids
}
