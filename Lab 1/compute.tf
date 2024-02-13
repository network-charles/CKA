# Create a launch template for ASG 
resource "aws_launch_template" "lt" {
  image_id               = data.aws_ami.amazon.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.sg.id]
  # amazon linux rhel 
  # user_data = filebase64("${path.module}/k8s_amazon_rhel.sh")
  # ubuntu 
  user_data = filebase64("${path.module}/k8s_ubuntu.sh")

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2.name
  }
}

# Create an ASG with a launch template and tag.
resource "aws_autoscaling_group" "asg" {
  name                = "asg"
  desired_capacity    = 3
  max_size            = 3
  min_size            = 3
  vpc_zone_identifier = [aws_subnet.my_subnet_1.id, aws_subnet.my_subnet_2.id, aws_subnet.my_subnet_3.id]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg"
    propagate_at_launch = true
  }

}
