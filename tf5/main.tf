
# Create a VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "example-vpc"
  }
}

# Create a subnet in the VPC
resource "aws_subnet" "example_subnet" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = "us-east-2a"  # Change this to your preferred AZ

  tags = {
    Name = "example-subnet"
  }
}

# Create a security group for the EC2 instance
resource "aws_security_group" "example_sg" {
  name        = "example-sg"
  description = "Allow inbound SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.example_vpc.id
}

# Create an EC2 instance in the subnet
resource "aws_instance" "example_instance" {
  ami             = "ami-0e83be366243f524a"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.example_subnet.id
  security_groups  = [aws_security_group.example_sg.id]

  tags = {
    Name = "example-instance"
  }

  # Provisioner to install Apache2 on the EC2 instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2"
    ]
  }
}

# Create a null_resource to run local-exec provisioner after the EC2 instance is created
resource "null_resource" "example_local_exec" {
  triggers = {
    instance_id = aws_instance.example_instance.id
  }

  provisioner "local-exec" {
    command = "echo 'Public IP: ${aws_instance.example_instance.public_ip}' > instance_ip.txt"
  }
}