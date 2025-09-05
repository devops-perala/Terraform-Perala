#---------------------
# terraform + Provider Block
#---------------------
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.11.0"
    }
  }
}
# provider block
provider "aws" {
  region = "us-east-1"
}

# --------------------
variable "aws_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "aws_root_storage_size" {
  type    = number
  default = 15
}

variable "ec2_ami_id" {
  type    = string
  default = "ami-0360c520857e3138f"
}

# --------------------
# EC2 Instance
# --------------------
resource "aws_instance" "my_ec2" {
  ami                    = var.ec2_ami_id
  instance_type          = var.aws_instance_type
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.my_sg_group.id]   

  root_block_device {
    volume_size = var.aws_root_storage_size
    volume_type = "gp3"
  }

  tags = {
    Name = "rakeshperala"   
  }
}
#-------------------------
# output
#------------------------
output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.my_ec2.public_dns
}

output "ec2_private_ip" {
  value = aws_instance.my_ec2.private_ip
}
