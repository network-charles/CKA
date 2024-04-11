output "master" {
  value = "aws ssm start-session --target ${data.aws_instance.eu_west_2a.id}"
}

output "master_public_ip" {
  value = "${data.aws_instance.eu_west_2a.public_ip}:80"
}

output "worker1" {
  value = "aws ssm start-session --target ${data.aws_instance.eu_west_2b.id}"
}

output "worker2" {
  value = "aws ssm start-session --target ${data.aws_instance.eu_west_2c.id}"
}

output "worker1_public_ip" {
  value = "${data.aws_instance.eu_west_2c.public_ip}:80"
}

output "worker2_public_ip" {
  value = "${data.aws_instance.eu_west_2c.public_ip}:80"
}