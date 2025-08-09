module "vpc" {
  source         = "./modules/vpc"
  cidr_block_val = var.cidr_block_val
  region = var.region
}

data "aws_availability_zones" "available" {}


module "subnet" {
  source             = "./modules/subnet"
  eks_cluster_name   = "${terraform.workspace}-${var.eks_cluster_name}"
  vpc_id             = module.vpc.vpc_id
  vpc_cidr_block     = var.cidr_block_val
  availability_zones = data.aws_availability_zones.available.names
}

module "Network" {
  source             = "./modules/network"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.subnet.private_subnet_ids
  public_subnet_ids  = module.subnet.public_subnet_ids
  cidr_block_val     = var.cidr_block_val
  public_cidr_block  = var.public_cidr_block
}


module "Iam" {
  source = "./modules/iam"
}

module "security_group" {
  source = "./modules/securitygroup"
  vpc_id = module.vpc.vpc_id
}

module "ekscluster" {
  source             = "./modules/eks-cluster"
  eks_cluster_name   = "${terraform.workspace}-${var.eks_cluster_name}"
  cluster_role_name  = var.eks_cluster_name
  cluster_role_arn   = module.Iam.cluster_role_arn
  private_subnet_ids = module.subnet.private_subnet_ids
  eks_cluster_sg = module.security_group.eks_cluster_sg
}

module "eks_addons" {
  source        = "./modules/eks_addons"
  eks_cluster_name = module.ekscluster.eks_cluster_name
}

data "aws_ssm_parameter" "eks_ami" {
  name = "/aws/service/eks/optimized-ami/1.33/amazon-linux-2023/x86_64/standard/recommended/image_id"
}

# data "aws_ami" "eks_al2023" {
#   most_recent = true
#   owners      = ["602401143452"] # Amazon EKS AMI publisher

#   filter {
#     name   = "name"
#     values = ["amazon-eks-node-al2023-x86_64-standard-1.33-v20250627"]
#   }

#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }
# }





module "launch_template" {
  source          = "./modules/launch_template"
  launch_template = "${terraform.workspace}-${var.launch_template}"
  # image_id           = data.aws_ami.eks_al2023.id
  # instance_profile_name = module.Iam.instance_profile_name
  image_id                = data.aws_ssm_parameter.eks_ami.value
  security_group_ids      = module.security_group.ekssg_id
  instance_type           = var.instance_type
  eks_cluster_name        = "${terraform.workspace}-${var.eks_cluster_name}"
  cluster_service_cidr    = module.ekscluster.eks_service_cidr
  eks_cluster_endpoint    = module.ekscluster.eks_cluster_endpoint
  eks_cluster_certificate = module.ekscluster.eks_cluster_certificate
}


module "nodegroup" {
  source                  = "./modules/nodegroup"
  eks_cluster_name        = "${terraform.workspace}-${var.eks_cluster_name}"
  private_subnet_ids      = module.subnet.private_subnet_ids
  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.launch_template_version
  node_role_arn           = module.Iam.node_role_arn
  eks_NG                  = "${terraform.workspace}-${var.eks_NG}"
  min_size                = var.min_size
  max_size                = var.max_size
  desired_size            = var.desired_size
  depends_on              = [module.ekscluster, module.launch_template]
}

module "aws_auth" {
  source        = "./modules/aws_auth"
  node_role_arn = module.Iam.node_role_arn
  # account_id    = var.account_id

  map_users = [
    {
      userarn  = "arn:aws:iam::247523262347:user/terraform_user"
      username = "terraform_user"
      groups   = ["system:masters"]
    }
  ]

  depends_on = [module.ekscluster]
}



