data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name = "name"
    # amazon linux rhel 
    #values = ["al2023-ami-2023.3.20240131.0-kernel-6.1-x86_64"] 

    # ubuntu
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
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
data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  name = "AmazonSSMManagedInstanceCore"
}

# grab running instances 
data "aws_instance" "eu_west_2a" {
  filter {
    name   = "tag:Name"
    values = ["asg"]
  }

  filter {
    name   = "availability-zone"
    values = ["eu-west-2a"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  depends_on = [aws_autoscaling_group.asg]
}

data "aws_instance" "eu_west_2b" {
  filter {
    name   = "tag:Name"
    values = ["asg"]
  }

  filter {
    name   = "availability-zone"
    values = ["eu-west-2b"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  depends_on = [aws_autoscaling_group.asg]
}

data "aws_instance" "eu_west_2c" {
  filter {
    name   = "tag:Name"
    values = ["asg"]
  }

  filter {
    name   = "availability-zone"
    values = ["eu-west-2c"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  depends_on = [aws_autoscaling_group.asg]
}