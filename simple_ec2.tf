# Create Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = "perala_key"                
  public_key = file("perala_key.pub")    
}

# Use default VPC
resource "aws_default_vpc" "default" {}

# Security Group
resource "aws_security_group" "my_sg_group" {
  name        = "allow_tls"
  description = "Allow user to connect"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "port 22 allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 80 allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 443 allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysecurity"
  }
}

# EC2 Instance
resource "aws_instance" "my_instance" {
  ami           = "ami-0360c520857e3138f"
  instance_type = "t2.medium"
  key_name      = aws_key_pair.my_key.key_name   
  vpc_security_group_ids = [aws_security_group.my_sg_group.id] 
  user_data = file("nginx.sh")

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "my-instance"
  }
}



### Note :-  go to ec2----cat rakesh_key ----copy the context in notepad save it --its private key
             go to download folder create file name rakesh_key paste the notepad content init and use as pem.key
