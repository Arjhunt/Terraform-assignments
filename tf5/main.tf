provider "aws" {
        access_key = "AKIAYBNAYU2PHVN55UQG"
        secret_key = "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"
        region = "us-east-2"
}

resource "aws_instance" "a5-instance" {
        ami = "ami-0e83be366243f524a"
        instance_type = "t2.micro"
        key_name = "ohiokey"
        user_data = "${file("install-apache2.sh")}"
        tags = {
                Name = "a5-instance"
        }
}

output "IPv4" {
        value = aws_instance.a5-instance.public_ip
}


