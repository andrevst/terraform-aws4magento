# Magento 2 on AWS with Terraform

## What this repository is

This repo creates an infrastructure to host Magento 2 application on AWS Thisinfrastructure consists of 2 servers: caching server and server which will host Magento application. The entry point to the infrastructure will be AWS load-balancer, which will be terminating SSL and taking care of correct routing. You will need to describe infrastructure as code using Terraform

## Pre Requisites

- Ubuntu LTS
  - sudo Privileges
- PHP 7.2

### PHP 7.2

Magento 2.3 works on PHP 7 so for safety and quality we will use it

#### Install Modules

The following Modules are required to install our magento solution in a Ubuntu Server

- php7.2-fpm
- php7.2-gd
- php7.2-mysql
- php7.2-curl
- php7.2-intl
- php7.2-xsl
- php7.2-mbstring
- php7.2-zip
- php7.2-bcmath
- php7.2-opcache

```shell
# To install PHP 7.2 and all dependencies
sudo apt-get install php7.2-fpm php7.2-common php7.2-gd php7.2-mysql php7.2-curl php7.2-intl php7.2-xsl php7.2-mbstring php7.2-zip php7.2-bcmath php7.2-soap php7.2-opcache

# Define PHP configs
#memory limit
sudo sed -i "s/memory_limit = . */memory_limit = 768M/" /etc/php/7.2/fpm/php.ini
# max file size
sudo sed -i "s/framework_max_filesize = . */upload_max_filesize = 128M/" /etc/php/7.2/fpm/php.ini
# zlip output
sudo sed -i "s/zlib.output_compression = . */Zlib.output_compression = em/" /etc/php/7.2/fpm/php.ini
# max execution time
sudo sed -i "s/max_execution_time = */max_execution_time = 18000/" /etc/php/7.2/fpm/php.ini
# Check all with 
grep -n 'memory_limit\|upload_max_filesize\|Zlib.output_compression\|max_execution_time' /etc/php/7.2/fpm/php.ini
```

#### Intall Composer

> Composer is a PHP package manager

## References

- [PHP 7.2](https://www.php.net/releases/7_2_0.php)
