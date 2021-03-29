#variables.tf
 
#Variables use in EC2 instance.
 
variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "ami" {
  default = "ami-0663c8300ef945e88"			#Enter ubuntu18.04 or ubuntu20.04 AMI
}

variable "type" {
  default = "t2.micro"			#Enter Instance Type (ex - t2.micro)
}
 
variable "key_name" {
  default = "terraforming-magento"			#my pem key
}

variable "key_test" {
  default = "scandiweb-key"			#test pem key
}
 
variable "region" {
  default = "us-east-2"			#Enter aws region code (ex - ap-south-1)
}
 
variable "pem_file" {
  default = "terraforming-magento.pem"			#Enter Path of pem file
}
 
variable "ec2_tag" {
  default = "test-magento-server"			#Give name to EC2 instance
}
