output "romannum_conv_public_ip" {
    value = "http://${aws_instance.trf-ec2.public_ip}"
}

output "dns_name" {
    value = var.record_name
  
}

output "romannum_conv_public_dns" {
    value = aws_instance.trf-ec2
  
}

output "instance_ami" {
    value = aws_instance.trf-ec2.ami
  
}



