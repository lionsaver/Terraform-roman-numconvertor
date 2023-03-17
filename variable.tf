variable "domain_name" {
  default = "liondevops.click"
  description = "domain name"
  type = string
}

variable "record_name" {
  default = "www"
  description = "sub domain name"
  type = string
}

variable "ec2_type" {
  default = "t2.micro"
}

variable "keypair" {
  default = "first-key"
  
}