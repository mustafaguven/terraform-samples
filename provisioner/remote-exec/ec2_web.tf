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
      private_key = "${file("./../../terraform.pem")}"
    }
  }
}
