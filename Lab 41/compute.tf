# Create two clusters 
resource "aws_eks_cluster" "cluster_1" {
  name     = "cluster_1"
  role_arn = aws_iam_role.eks-iam-role.arn

  vpc_config {
    endpoint_public_access = true
    subnet_ids = [
      aws_subnet.cluster_1[0].id,
      aws_subnet.cluster_1[1].id
    ]
    security_group_ids = [aws_security_group.cluster_1.id]
  }

  kubernetes_network_config {
    service_ipv4_cidr = "10.1.0.0/24"
    ip_family         = "ipv4"
  }

  depends_on = [
    aws_iam_role.eks-iam-role
  ]
}

resource "aws_eks_cluster" "cluster_2" {
  provider = aws.eu-west-2
  name     = "cluster_2"
  role_arn = aws_iam_role.eks-iam-role.arn

  vpc_config {
    endpoint_public_access = true
    subnet_ids = [
      aws_subnet.cluster_2[0].id,
      aws_subnet.cluster_2[1].id
    ]
    security_group_ids = [aws_security_group.cluster_2.id]
  }

  kubernetes_network_config {
    service_ipv4_cidr = "10.2.0.0/24"
    ip_family         = "ipv4"
  }

  depends_on = [
    aws_iam_role.eks-iam-role
  ]
}

# Create worker node groups for each clusters
resource "aws_eks_node_group" "cluster_1" {
  cluster_name    = aws_eks_cluster.cluster_1.name
  node_group_name = "cluster_1"
  node_role_arn   = aws_iam_role.worker-nodes-iam-role.arn
  subnet_ids = [
    aws_subnet.cluster_1[0].id,
    aws_subnet.cluster_1[1].id
  ]

  capacity_type  = "SPOT"
  instance_types = ["t3.small"]
  disk_size      = "20"

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = aws_key_pair.cluster_1_key_pair.key_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-Node,
  ]
}

resource "aws_eks_node_group" "cluster_2" {
  provider = aws.eu-west-2
  cluster_name    = aws_eks_cluster.cluster_2.name
  node_group_name = "cluster_2"
  node_role_arn   = aws_iam_role.worker-nodes-iam-role.arn
  subnet_ids = [
    aws_subnet.cluster_2[0].id,
    aws_subnet.cluster_2[1].id
  ]

  capacity_type  = "SPOT"
  instance_types = ["t3.small"]
  disk_size      = "20"

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = aws_key_pair.cluster_2_key_pair.key_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-Node,
  ]
}
