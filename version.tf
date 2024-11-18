terraform {

  # backend "s3" {
  #   bucket  = "terraform-k8s"
  #   key     = "dev2/terraform.tfstate"
  #   region  = "us-east-1"
  #   encrypt = true
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
