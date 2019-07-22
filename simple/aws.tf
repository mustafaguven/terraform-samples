provider "aws" {
  region     = "eu-central-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

/*
resource "aws_instance" "myec2" {
  ami = "ami-0cc293023f983ed53"
  instance_type = "t2.micro"
}
*/

# resource "aws_s3_bucket" "my_bucket"{
#   bucket = "terraform-test-deneme-01"
# }

resource "aws_eip" "my_eip" {
  vpc = true
}

resource "aws_security_group" "allow_all" {
  name        = "interpolation-demo"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${aws_eip.my_eip.public_ip}/32"]
  }
}
