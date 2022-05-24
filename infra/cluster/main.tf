data "aws_caller_identity" "current" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "${var.name_prefix}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = []
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.21.0"

  cluster_name    ="${var.name_prefix}-cluster"
  cluster_version = "1.21"

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

//  cluster_addons = {
//    coredns = {
//      resolve_conflicts = "OVERWRITE"
//    }
//    kube-proxy = {}
//    vpc-cni = {
//      resolve_conflicts = "OVERWRITE"
//    }
//  }

//  cluster_encryption_config = [{
//    provider_key_arn = "ac01234b-00d9-40f6-ac95-e42345f78b00"
//    resources        = ["secrets"]
//  }]

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

//  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = ["t3.medium"]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

//  # Fargate Profile(s)
//  fargate_profiles = {
//    default = {
//      name = "default"
//      selectors = [
//        {
//          namespace = "default"
//        }
//      ]
//    }
//  }

  # aws-auth configmap
  //create_aws_auth_configmap = true
  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/outscope-devops-role"
      username = "outscope-devops-role"
      groups   = ["eks-console-dashboard-full-access-group"]
    },
  ]
}