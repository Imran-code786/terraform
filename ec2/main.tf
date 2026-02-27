data "aws_ami" "centos8" {
  most_recent = true
  owners      = ["950538586636"]

  filter {
    name   = "name"
    values = ["Centos-8-DevOps-Practice*"]
  }
}

resource "aws_instance" "rocky8_instances" {
  for_each = var.instances

  ami           = data.aws_ami.centos8.id
  instance_type = each.value
  key_name      = var.key_name

  associate_public_ip_address = true

  tags = {
    Name = each.key
  }
}

output "public_ips" {
  value = {for k, v in aws_instance.rocky8_instances : k => v.public_ip}
}