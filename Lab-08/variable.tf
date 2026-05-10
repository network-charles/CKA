# Define the availability zones
variable "availability_zones" {
  type = list
  default = ["eu-west-2a", "eu-west-2b"] # Replace with your desired availability zones
}