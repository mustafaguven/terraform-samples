resource "aws_instance" "my_web" {
  ami = "ami-0cc293023f983ed53"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.my_sg.name}"]
  key_name = "terraform"
  tags = {
    Name = "local-exec-web-server"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.my_web.public_ip} >> ip.txt"
  }
}
