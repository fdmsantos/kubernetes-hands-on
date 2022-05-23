//data "http" "workstation-external-ip" {
//  url = "http://ipv4.icanhazip.com"
//}
//
//locals {
//  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
//}
//
//module "vpc" {
//  source  = "terraform-aws-modules/vpc/aws"
//  version = "3.14.0"
//
//  name = "${var.name_prefix}-vpc"
//  cidr = "10.0.0.0/16"
//
//  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
//  private_subnets = []
//  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", ]
//
//  enable_nat_gateway = false
//  enable_vpn_gateway = false
//}
//
//resource "aws_iam_role" "this" {
//  name               = "${var.name_prefix}-role"
//  assume_role_policy = <<POLICY
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect": "Allow",
//      "Principal": {
//        "Service": "eks.amazonaws.com"
//      },
//      "Action": "sts:AssumeRole"
//    }
//  ]
//}
//POLICY
//}
//
//resource "aws_iam_role_policy_attachment" "this" {
//  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
//  role       = aws_iam_role.this.name
//}
//
//resource "aws_security_group" "this" {
//  name        = "${var.name_prefix}-cluster-sg"
//  description = "Cluster communication with worker nodes"
//  vpc_id      = module.vpc.vpc_id
//  egress {
//    from_port   = 0
//    to_port     = 0
//    protocol    = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}
//
//resource "aws_security_group_rule" "cluster-ingress-workstation-https" {
//  cidr_blocks       = [local.workstation-external-cidr]
//  description       = "Allow workstation to communicate with the cluster API Server"
//  from_port         = 443
//  protocol          = "tcp"
//  security_group_id = aws_security_group.this.id
//  to_port           = 443
//  type              = "ingress"
//}
//
//resource "aws_eks_cluster" "this" {
//  name     = "${var.name_prefix}-cluster"
//  role_arn = aws_iam_role.this.arn
//  vpc_config {
//    security_group_ids = [aws_security_group.this.id]
//    subnet_ids         = module.vpc.public_subnets
//  }
//  depends_on = [
//    aws_iam_role_policy_attachment.this,
//  ]
//}