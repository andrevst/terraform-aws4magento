# Magento 2 on AWS with Terraform

## What this repository is

This repo creates an infrastructure to host Magento 2 application on AWS Thisinfrastructure consists of 2 servers: caching server and server which will host Magento application. The entry point to the infrastructure will be AWS load-balancer, which will be terminating SSL and taking care of correct routing. You will need to describe infrastructure as code using Terraform

## Pre Requisites

- Terraform
- Ubuntu LTS
  - sudo Privileges
- PHP 7.2

## Install Magento on AWS t2.micro

This is the step-by-step to configure it mannualy. So first, SSH on the VM.

### Increase RAM size of t2.micro using swap storage

t2.Micro has 1 GB of RAM, Magento needs at least 2GB so we will use Swap Storage to add more 3GB to it.

```shell
sudo fallocate -l 3G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### Install NGINX

We will use [NGNIX](https://www.nginx.com/), a  Web Server and used as a reverse proxy, HTTP cache, load balancer, and mail proxy, etc.

```shell
# First available Nginx version on repositories. 
sudo apt-cache policy nginx
# Then install Nginx.
sudo apt-get -y install nginx
# Make sure it is online
sudo systemctl start nginx.service
# Check it
sudo systemctl status nginx.service
```

## References

- [SWAP Memory](https://medium.com/@ravinandan.db/how-to-use-aws-free-tier-to-deploy-magento2-for-learning-purpose-32831531b18b)
