resource "aws_instance" "my_web" {
  ami = "ami-0cc293023f983ed53"
  instance_type = "${var.instance_type}"
  security_groups = ["default"]
  tags = {
    Name = "${var.environment}-machine"
  }
}
