## Create LoadBalancer
module "m-elb-provectus" {
  source           = "./elb"
  elb_name         = "elb-provectus"
  vpc_id           = "${module.vpc.vpc_id}"
  subnet_az1       = "${aws_subnet.default_subnet.id}"
  subnet_az2       = "${aws_subnet.default_subnet.id}"
  backend_port     = "3334"
  backend_protocol = "http"

  ssl_certificate_id = "${data.aws_acm_certificate.star-shalb-com.arn}"
  health_check_target = "HTTP:3334/"

  #  elb_security_group = "${aws_security_group.elb-sg.id}"
}

# Get the certificate assigned
data "aws_acm_certificate" "star-shalb-com" {
    domain   = "*.aws.shalb.com"
    statuses = ["ISSUED"]

}

# Attach the domain to ELB

resource "aws_route53_record" "provectus-aws-shalb-com" {
  zone_id = "Z36XQDCMS0HHZM"
  name    = "provectus.aws.shalb.com"
  type    = "CNAME"
  ttl     = "300"
  records = ["${module.m-elb-provectus.elb_dns_name}"]
}

## Add rule for access to ELB SG into default SG
resource "aws_security_group_rule" "allow_3334_provectus" {
  type                     = "ingress"
  from_port                = 3334
  to_port                  = 3334
  protocol                 = "tcp"
  source_security_group_id = "${module.m-elb-provectus.elb_sg_id}"
  security_group_id        = "${module.vpc.vpc_default_security_group}"
}
