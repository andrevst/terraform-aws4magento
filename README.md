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

### Install and configure PHP 7.2

#### PHP 7.2 and Extensions

```Shell
# Check for availability for PHP 7.2.
sudo apt-cache policy php7.2
# Install PHP 7.2 and extensions.
sudo apt-get -y install php7.2-fpm php7.2-cli php7.2 php7.2-common php7.2-gd php7.2-mysql php7.2-curl php7.2-intl php7.2-xsl php7.2-mbstring php7.2-zip php7.2-bcmath php7.2-iconv php7.2-soap
# Verify it
sudo php -v
# Check PHP extensions
sudo php -me
```

#### PHP configs to Magento

```shell
# Modify parameters to suit the Magento needs.
# RAM allocation.
sudo sed -i "s/memory_limit = .*/memory_limit = 2048M/" /etc/php/7.2/fpm/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 2048M/" /etc/php/7.2/cli/php.ini
# Check it
grep -n 'memory_limit' /etc/php/7.2/fpm/php.ini
grep -n 'memory_limit' /etc/php/7.2/cli/php.ini
# Execution time.
sudo sed -i "s/max_execution_time = .*/max_execution_time  = 1800/" /etc/php/7.2/fpm/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time  = 1800/" /etc/php/7.2/cli/php.ini
# Check it
grep -n 'max_execution_time' /etc/php/7.2/fpm/php.ini
grep -n 'max_execution_time' /etc/php/7.2/cli/php.ini
# Zlib compression
sudo sed -i "s/zlib.output_compression = .*/zlib.output_compression = 0/" /etc/php/7.2/fpm/php.ini
sudo sed -i "s/zlib.output_compression = .*/zlib.output_compression = 0/" /etc/php/7.2/cli/php.ini
# Check it
grep -n 'Zlib.output_compression' /etc/php/7.2/fpm/php.ini
grep -n 'Zlib.output_compression' /etc/php/7.2/cli/php.ini
# Restart PHP to changes takes effect
sudo systemctl restart php7.2-fpm
```

## References

- [SWAP Memory](https://medium.com/@ravinandan.db/how-to-use-aws-free-tier-to-deploy-magento2-for-learning-purpose-32831531b18b)
