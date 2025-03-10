
resource "aws_iam_role" "eks_cluster" {
    name                        = "${lower(join("-", [var.project, "eks_cluster", var.environment]))}-eks-role"
    assume_role_policy          = <<POLICY
{
"Version": "2012-10-17",
"Statement": [
    {
    "Effect": "Allow",
    "Principal": {
        "Service": "eks.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
    }
]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
 
  policy_arn                    = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role                        = aws_iam_role.eks_cluster.name
}

# Create IAM role for EKS Node Group
resource "aws_iam_role" "node_group" {
  # The name of the role
  name                         = "${lower(join("-", [var.project, "node_group", var.environment]))}-eks-node-group-role"
  assume_role_policy           = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  policy_arn                   = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role                         = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  policy_arn                   = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role                         = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn                   = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role                         = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_ssm_policy" {
  policy_arn                  = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role                        = aws_iam_role.node_group.name
}

