# Those are the basics commands to install magento in a LEMP
# Update and upgrade SO
echo '---- Let`s start. Updating and Upgrading system ----'
sudo apt-get -y update
sudo apt-get -y upgrade
echo '---- Step 1 done ----'
# Increase RAM size of t2.micro using swap storage
echo '---- Step 2 Increase Memory ----'
sudo fallocate -l 3G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '---- Step 2 done ----'
echo '---- step 3 - Install NGINX ----'
# First available Nginx version on repositories. 
sudo apt-cache policy nginx
# Then install Nginx.
sudo apt-get -y install nginx
# Make sure it is online
sudo systemctl start nginx.service
echo '---- Step 3 done ----'
echo '---- Step 4 Install & Config PHP ----'
sudo apt-cache policy php7.2
# Install PHP 7.2 and extensions.
sudo apt-get -y install php7.2-fpm php7.2-cli php7.2 php7.2-common php7.2-gd php7.2-mysql php7.2-curl php7.2-intl php7.2-xsl php7.2-mbstring php7.2-zip php7.2-bcmath php7.2-iconv php7.2-soap
# Verify it
sudo php -v
# Check PHP extensions
sudo php -me
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
echo '---- Step 4 done ----'
echo '---- Step 5 Install MySQL ----'
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
echo '---- Step 5 done ----'
echo '---- Step 6 Install Composer & Create deploy ----'
sudo apt install composer
# Create user
sudo adduser deploy
# Create webapp folder
sudo mkdir -p /var/www/html/webapp
# Change the folder permissions
sudo chown -R deploy:www-data /var/www/html/webapp
cd /var/www/html/webapp
echo '---- Step 6 done ----'
echo '---- Step 7 Install Magento with deploy user ----'
# Use deploy
sudo su deploy
# Install Magento
composer create-project --repository=https://repo.magento.com/ magento/project-community-edition=2.3.0 .
echo '---- All done ----'