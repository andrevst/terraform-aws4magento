# Magento 2 on AWS with Terraform

## What this repository is

This repo creates an infrastructure to host Magento 2 application on AWS The infrastructure consists in 2 servers: caching server and application server which will host Magento application. The entry point to the infrastructure will be AWS load-balancer, which will be terminating SSL and taking care of correct routing. It describes infrastructure as code using Terraform.

## Pre Requisites

- AWS Account to host resources
  - Amazon EC2 t2.micro
    - Ubuntu 18.04 LTS with sudo
  - Amazon RDS
  - Amazon Load Balancer
- Magento 2 Account
- Terraform
- A domain

### Local setup

### Online setup

1. Create or access an AWS Account
2. Configure an IAM user
    1. Give it AmazonEC2FullAccess, ElasticLoadBalancingFullAccess and AmazonRDSFullAccess
    2. Donwload credentials CSV
3. On EC2 dashboard, create a SSH Key Pair
    1. Access Key Pair under Network and Security Section
    2. Create a pem file

###


## References

- 
