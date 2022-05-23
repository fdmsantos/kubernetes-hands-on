//resource "aws_iam_role" "node-role" {
//  name = "${var.name_prefix}-node-role"
//  assume_role_policy = <<POLICY
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect": "Allow",
//      "Principal": {
//        "Service": "ec2.amazonaws.com"
//      },
//      "Action": "sts:AssumeRole"
//    }
//  ]
//}
//POLICY
//}
//
//resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
//  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
//  role       = aws_iam_role.node-role.name
//}
//
//resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
//  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
//  role       = aws_iam_role.node-role.name
//}
//
//resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
//  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
//  role       = aws_iam_role.node-role.name
//}
//
//resource "aws_eks_node_group" "this" {
//  cluster_name    = aws_eks_cluster.this.name
//  node_group_name = "${var.name_prefix}-node-group"
//  node_role_arn   = aws_iam_role.node-role.arn
//  subnet_ids      = module.vpc.public_subnets
//  scaling_config {
//    desired_size = 1
//    max_size     = 1
//    min_size     = 1
//  }
//  depends_on = [
//    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
//    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
//    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
//  ]
//}