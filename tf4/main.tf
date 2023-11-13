resource "aws_vpc" "example_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

}

resource "aws_subnet" "example_subnet" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = "us-east-2a" 

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

}