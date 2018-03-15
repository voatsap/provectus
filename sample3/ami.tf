## Get instance AMI
data "aws_ami" "provectus-ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["provectus-ami*"]
  }
}
