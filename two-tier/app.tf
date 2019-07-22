
resource "aws_instance" "my_app" {
  ami = "ami-0cc293023f983ed53"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.my_app_sg.name}"]
  tags = {
    Name = "app-server"
  }
}

resource "aws_security_group" "my_app_sg" {
  name = "app-server-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.my_eip.public_ip}/32"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.my_eip.public_ip}/32"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.all_internet}"]
  }
}

resource "aws_eip" "my_app_eip" {
  instance = "${aws_instance.my_app.id}"
}
