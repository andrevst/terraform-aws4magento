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
# Execution time.
sudo sed -i "s/max_execution_time = .*/max_execution_time  = 1800/" /etc/php/7.2/fpm/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time  = 1800/" /etc/php/7.2/cli/php.ini
# Zlib compression
sudo sed -i "s/zlib.output_compression = .*/zlib.output_compression = 0/" /etc/php/7.2/fpm/php.ini
sudo sed -i "s/zlib.output_compression = .*/zlib.output_compression = 0/" /etc/php/7.2/cli/php.ini
# Check it all
grep -n 'memory_limit\|upload_max_filesize\|Zlib.output_compression\|max_execution_time' /etc/php/7.2/fpm/php.ini
grep -n 'memory_limit\|Zlib.output_compression\|max_execution_time' /etc/php/7.2/cli/php.ini
# Restart PHP to changes takes effect
sudo systemctl restart php7.2-fpm
```

### Install MySQL 5.7

```shell
# Check for the available version on the Repositories.
sudo apt-cache policy mysql-server
# Install MYSQL.
sudo apt install -y mysql-server mysql-client
# Check MYSQL server status.
sudo systemctl status mysql.service
# Start MYSQL server
sudo systemctl start mysql.service
# Secure the installation
sudo mysql_secure_installation
#Test the MYSQL.
sudo mysql -u root -p
```

### Install Magento

#### Install Composer

```shell
sudo apt install composer
```

#### Create Deploy user and directory

```shell
# Create user
sudo adduser deploy
# Create webapp folder
sudo mkdir -p /var/www/html/webapp
# Change the folder permissions
sudo chown -R deploy:www-data /var/www/html/webapp
cd /var/www/html/webapp

```

#### Install Magento with composer using deply user

```shell
# Use deploy
sudo su deploy
# Install Magento
composer create-project --repository=https://repo.magento.com/ magento/project-community-edition=2.3.0 .
```

#### Configuring Nginx

```shell
# Create a new virtual host for the Magento site with a sample Nginx configuration file
sudo cp /var/www/html/webapp/nginx.conf.sample /etc/nginx/magento.conf
# Create a virtual host configuration file called “magento”
sudo nano /etc/nginx/sites-available/magento
```

- Add the following contents to the file. Make sure to replace your domain name in place of magentotest.fosslinux.com in the below text.

```json
  upstream fastcgi_backend {
     server  unix:/run/php/php7.2-fpm.sock;
 }
server {
listen 80;
     server_name magentotest.andrevst.dev;
     set $MAGE_ROOT /var/www/html/webapp;
     include /etc/nginx/magento.conf;
 }
 ```

Save and exit the file.

```shell
# Enable the virtual host.
sudo ln -s /etc/nginx/sites-available/magento /etc/nginx/sites-enabled
# Verify nginx syntax.
sudo nginx -t
# Restart Nginx service.
sudo systemctl restart nginx
```

## References

- [SWAP Memory](https://medium.com/@ravinandan.db/how-to-use-aws-free-tier-to-deploy-magento2-for-learning-purpose-32831531b18b)
