# Installing PHP 7.2
echo '---- Step 1 php 7.2 install ----'
sudo apt-get -y install php7.2-fpm php7.2-common php7.2-gd php7.2-mysql php7.2-curl php7.2-intl php7.2-xsl php7.2-mbstring php7.2-zip php7.2-bcmath php7.2-soap php7.2-opcache
echo '---- Step 1 done ----'
# Define PHP configs
echo '---- Step 2 php 7.2 configuration ----'
sudo sed -i "s/memory_limit = .*/memory_limit = 768M/" /etc/php/7.2/fpm/php.ini
grep -n 'memory_limit' /etc/php/7.2/fpm/php.ini
echo '---- Step 2.1 done ----'
sudo sed -i "s/framework_max_filesize = .*/upload_max_filesize = 128M/" /etc/php/7.2/fpm/php.ini
grep -n -n 'upload_max_filesize' /etc/php/7.2/fpm/php.ini
echo '---- Step 2.2 done ----'
sudo sed -i "s/zlib.output_compression = .*/Zlib.output_compression = em/" /etc/php/7.2/fpm/php.ini
grep -n -n 'Zlib.output_compression' /etc/php/7.2/fpm/php.ini
echo '---- Step 2.3 done ----'
sudo sed -i "s/extension = = .*/extension = phar.so/" /etc/php/7.2/fpm/php.ini
grep -n 'max_execution_time' /etc/php/7.2/fpm/php.ini
echo '---- step 2.4 done ----'
echo '---- step 3 - get composer ----'
curl -sS https://getcomposer.org/installer | php 
sudo mv composer.phar /usr/local/bin/composer
echo '---- All done ----'