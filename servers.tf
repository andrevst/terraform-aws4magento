#ec2.tf file
 
#This is use to create EC2 instance.
 
resource "aws_instance" "magento-server" {
  ami             = var.ami
  instance_type   = var.type
  key_name        = var.key_name
  vpc_security_group_ids = [aws_security_group.Security_Group.id]
  tags = {
    Name = var.app_tag
  }
 
#This line of code is use to change the size of created root volume.
 
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = 30
    volume_type           = "gp2"
  }
}

resource "aws_instance" "varnish-server" {
  ami             = var.ami
  instance_type   = var.type
  key_name        = var.key_name
  vpc_security_group_ids = [aws_security_group.Security_Group.id]
  tags = {
    Name = var.varnish_tag
  }
 
#This line of code is use to change the size of created root volume.
 
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = 30
    volume_type           = "gp2"
  }
}