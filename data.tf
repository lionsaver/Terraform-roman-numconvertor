data "aws_ami" "tf_ami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_acm_certificate" "amazon_issued" {
  domain      = "liondevops.click"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

# data "template_file" "init" {
#   template = "${file("${path.module}/userdata.sh")}"
# }

data "template_file" "userdata" {
  template = file("${abspath(path.module)}/user-data.sh")
  vars = {
    server-name = local.tags
  }
}