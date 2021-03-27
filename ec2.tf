#ec2.tf file
 
#This is use to create EC2 instance.
 
resource "aws_instance" "EC2_Instance" {
  ami             = var.ami
  instance_type   = var.type
  key_name        = var.key_name
  vpc_security_group_ids = [aws_security_group.Security_Group.id]
  tags = {
    Name = var.ec2_tag
  }
 
#This line of code is use to change the size of created root volume.
 
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = 30
    volume_type           = "gp2"
  }
 
#By this terraform script get connected with ec2 instance and then upload and run the magento script.
 
  connection {
    type     = "ssh"
    user     = "ubuntu"
    password = ""
    private_key = file(var.pem_file)
    host        = self.public_ip
  }
 
  # provisioner "local-exec" {
  #     command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.pem_file} project-silver-main/magento-install.yml"
  # }
}
 
#By this script ElasticIP is created
 
resource "aws_eip" "Instance_IP" {
  instance = aws_instance.EC2_Instance.id
  vpc = true
 
  tags = {
    Name = "Instance-IP"
  }
}