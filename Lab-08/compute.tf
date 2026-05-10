# Define an AWS EKS cluster
resource "aws_eks_cluster" "eks" {
  name     = "eks"
  role_arn = aws_iam_role.eks-iam-role.arn

  # Configure VPC settings for the EKS cluster
  vpc_config {
    endpoint_public_access = true
    subnet_ids             = [
      aws_subnet.my_subnet[0].id,
      aws_subnet.my_subnet[1].id
    ]
    security_group_ids     = [aws_security_group.sg.id]
  }

  # Configure Kubernetes network settings
  kubernetes_network_config {
    service_ipv4_cidr = "10.2.0.0/24"
    ip_family         = "ipv4"
  }

  # Ensure the EKS cluster creation depends on the IAM role being created first
  depends_on = [
    aws_iam_role.eks-iam-role
  ]
}

# Define an AWS EKS node group
resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "workernodes"
  node_role_arn   = aws_iam_role.worker-nodes-iam-role.arn
  subnet_ids      = [
    aws_subnet.my_subnet[0].id
  ]

  # Configure node group specifications
  capacity_type  = "SPOT"
  instance_types = ["t3.small"]
  disk_size      = "20"

  # Configure auto-scaling settings for the node group
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Configure remote access settings
  remote_access {
    ec2_ssh_key = aws_key_pair.key_pair.key_name
  }

  # Ensure node group creation depends on IAM role policies being attached first
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-Node,
  ]
}

# Define a Kubernetes service account
resource "kubernetes_service_account" "service-account" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
      "app.kubernetes.io/component" = "controller"
    }
    annotations = {
      "eks.amazonaws.com/role-arn"               = aws_iam_role.aws_load_balancer_controller.arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }
}

# Define a Helm release for the AWS Load Balancer Controller
resource "helm_release" "aws-load-balancer-controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  # Set values for the Helm chart
  set {
    name  = "vpcId"
    value = aws_vpc.K8s.id
  }

  set {
    name  = "clusterName"
    value = aws_eks_cluster.eks.id
  }

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.eu-west-2.amazonaws.com/amazon/aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.service-account.metadata[0].name
  }

  # Ensure Helm release depends on the EKS node group and IAM role policies being attached first
  depends_on = [
    aws_eks_node_group.worker-node-group,
    aws_iam_role_policy_attachment.aws_load_balancer_controller_attach
  ]
}
