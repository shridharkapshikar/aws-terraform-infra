variable "AWS_REGION" {    
    default = "ap-south-1"
}
variable "PRIVATE_KEY_PATH" {
  default = "dev-region-key-pair"
}

variable "PUBLIC_KEY_PATH" {
  default = "dev-region-key-pair.pub"
}

variable "EC2_USER" {
  default = "ec2-user"
}
variable "AMI" {
  type = "map"
  default = {
    "ap-south-1" = "ami-0cb0e70f44e1a4bb5"
  }
}
