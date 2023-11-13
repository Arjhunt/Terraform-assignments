# Create EC2 instances in Ohio
resource "aws_instance" "example_instance_ohio" {
  ami           = "ami-0e83be366243f524a"
  count= 2
  instance_type = "t2.micro"
}

# Create EC2 instances in Northern Virginia
resource "aws_instance" "example_instance_n_virginia" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  count = 2
  provider      = aws.n_virginia
}
