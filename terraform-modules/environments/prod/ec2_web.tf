module "myec2" {
  source = "./../../modules/ec2"
  environment = "prod"
  instance_type = "m3.medium"
}
