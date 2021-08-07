provider "aws" {
  region     = "eu-west-1"
  access_key = "AKIAYD7ZKUXPMBHRQUGV"
  secret_key = "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"
}

data "aws_region" "current" {
}

data "aws_availability_zones" "available" {
}

provider "http" {
}
