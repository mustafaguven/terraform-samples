resource "aws_eip" "my_eip" {
  instance = "${aws_instance.my_web.id}"
}
