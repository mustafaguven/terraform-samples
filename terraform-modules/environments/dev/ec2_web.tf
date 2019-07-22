module "myec2" {
  source = "./../../modules/ec2"
  environment = "dev"
  instance_type = "t2.micro"
}
