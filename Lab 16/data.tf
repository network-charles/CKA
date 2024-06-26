# define a service role to the assumed
data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# define policies to be attached to the role 
data "aws_iam_policy" "AmazonEKSClusterPolicy" {
  name = "AmazonEKSClusterPolicy"
}

data "aws_iam_policy" "AmazonEC2ContainerRegistryReadOnly" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

# define a service role to the assumed
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# define policies to be attached to the role 
data "aws_iam_policy" "AmazonEKSWorkerNodePolicy" {
  name = "AmazonEKSWorkerNodePolicy"
}

data "aws_iam_policy" "AmazonEKS_CNI_Policy" {
  name = "AmazonEKS_CNI_Policy"
}

data "aws_iam_policy" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  name = "EC2InstanceProfileForImageBuilderECRContainerBuilds"
}

data "aws_instance" "instance1" {
  filter {
    name   = "tag:eks:cluster-name"
    values = ["eks"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  filter {
    name   = "availability-zone"
    values = ["eu-west-2a"]
  }

  depends_on = [aws_eks_node_group.worker-node-group]
}

data "aws_instance" "instance2" {
  filter {
    name   = "tag:eks:cluster-name"
    values = ["eks"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  filter {
    name   = "availability-zone"
    values = ["eu-west-2b"]
  }

  depends_on = [aws_eks_node_group.worker-node-group]
}
