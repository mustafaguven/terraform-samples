provider "aws" {
  region     = "eu-central-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_instance" "my_web" {
  ami = "ami-0cc293023f983ed53"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.my_sg.name}"]
  key_name = "terraform"
  tags = {
    Name = "web-server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx.service"
    ]

    connection {
      type = "ssh"
      user = "ec2-user"
      host = self.public_ip
      timeout = "1m"
      private_key = "${file("./terraform.pem")}"
    }
  }
}

resource "aws_security_group" "my_sg" {
  name = "web-server-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.all_internet}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.all_internet}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.all_internet}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["${var.all_internet}"]
  }
}

resource "aws_eip" "my_eip" {
  instance = "${aws_instance.my_web.id}"
}
