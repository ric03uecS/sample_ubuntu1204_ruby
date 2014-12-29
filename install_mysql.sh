
#!/bin/bash -e 

echo "===================== Installing mysql 5.6 ====================="
echo "===================== Setting mysql defaults ==============================="
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password aaa'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password aaa'

sudo add-apt-repository -y ppa:ondrej/mysql-5.6
sudo apt-get -y update

yes Y | sudo apt-get -yy install mysql-server

chown -R mysql:mysql /var/lib/mysql/*

sudo /usr/bin/mysqld_safe &
sleep 5
mysqladmin -u root -p'aaa' password ''
echo "GRANT ALL ON *.* TO shippable@localhost IDENTIFIED BY ''; FLUSH PRIVILEGES;" | mysql -uroot
echo "GRANT ALL ON *.* TO ''@localhost IDENTIFIED BY ''; FLUSH PRIVILEGES;" | mysql -uroot
echo "=============== Added mysql priviliges ===================="
