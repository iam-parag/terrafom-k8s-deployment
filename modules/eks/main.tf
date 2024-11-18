resource "aws_eks_cluster" "eks" {
  name                          = "${lower(join("-", [var.project, "eks", var.environment]))}-eks-cluster"
  role_arn                      = aws_iam_role.eks_cluster.arn
  version                       = var.eks_kube_version
  vpc_config {
    endpoint_private_access     = true   
    endpoint_public_access      = false
    subnet_ids                  = var.private_sub_ids 

  }
  depends_on  = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}

#SERVICE NODE GROUP
resource "aws_eks_node_group" "service_node_group" {
  cluster_name                = aws_eks_cluster.eks.name
  node_group_name             = "ng-${lower(join("-", [var.project, "service_node_group", var.environment]))}-service"
  node_role_arn               = aws_iam_role.node_group.arn
  subnet_ids                  =  var.private_sub_ids                    # VPC PRIVATE SUBNET ID LIST
  version                     =  var.eks_kube_version                    # Kubernetes version
  # Configuration block with scaling settings
  
  scaling_config {
    desired_size              = var.service_node_group.desired_size
    max_size                  = var.service_node_group.max_size         # Maximum number of worker nodes.
    min_size                  = var.service_node_group.min_size         # Minimum nuservice_node_groupmber of worker nodes.
  }
  remote_access {
    ec2_ssh_key =  var.key_name_eks
  }
  ami_type                    = var.service_node_group.ami_type
  capacity_type               = var.service_node_group.capacity_type    # Valid values: ON_DEMAND, SPOT
  disk_size                   = var.service_node_group.disk_size        # Disk size in GiB for worker nodes
  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version        = false
  instance_types              = var.service_node_group.instance_types   # List of instance types associated with the EKS Node Group
  labels                      = var.service_node_group.labels
   

  tags = {
      Name = format("%s-worker-node", aws_eks_cluster.eks.name)
  }

  depends_on = [
      aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
      aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
      aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}


