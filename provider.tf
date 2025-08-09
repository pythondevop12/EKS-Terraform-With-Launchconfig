terraform {
  required_version = ">= 1.8.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.5.0"
    }
  }
  backend "s3" {
    bucket         = "dynos3test"
    key            = "key/terraform.tfstate"
    dynamodb_table = "tf-locs"
    encrypt        = true
    region         = "us-east-1"

  }
}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = module.ekscluster.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.ekscluster.eks_cluster_certificate)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.ekscluster.eks_cluster_name
}
