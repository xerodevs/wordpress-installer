#!/bin/bash
# programmers : xerogroupdevs, h3ct0rjs@xerogroup.co, jsarias@xerogroup.co
# usage: ./wordpress.sh wordpress-name
. ./utils.sh

cat << "EOF"
__      ___ __  _ __ ___  ___ ___
\ \ /\ / / '_ \| '__/ _ \/ __/ __|
 \ V  V /| |_) | | |  __/\__ \__ \
  \_/\_/ | .__/|_|  \___||___/___/
         |_|   XeroGroup.co
         h3ct0rjs@xerogroup.co
EOF

if [ -z "$1" ]
then
    utils.printererr "No argument supplied"
    utils.printererr "USAGE: $0 wordpress-name , e.g ./wordpress.sh site1"
    exit
fi

utils.printeinfo "Getting latest wordpress installation"
wget https://wordpress.org/latest.tar.gz -O /tmp/w.tar.gz
if [ -f /tmp/w.tar.gz ]; then
    utils.printeok "Wordpress Downloaded"
fi

utils.printeinfo "Setting enviroment in  /var/www/html"
mkdir -p /var/www/html/$1
CONFIG_FILE=/var/www/html/$1/wp-config.php
utils.printeok "Uncompressing installer file"
tar -xvf /tmp/w.tar.gz -C /var/www/html/$1/
mv /var/www/html/$1/wordpress/* /var/www/html/$1/
utils.printeok "Changing wordpress permission"
chown -v www-data:www-data /var/www/html/$1/
utils.printerok "Configure Database"
utils.printerinfo "Configuring Database"
utils.printerinput "Please enter root user MySQL password!"
read rootpasswd
utils.printerinput "Please enter the NAME of the new WordPress database! (example: database1)"
read dbname
charset='utf8'
utils.printerinput "Creating new WordPress database..."
mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET ${charset} */;"
utils.printerok "Database successfully created!"
utils.printerinfo "Showing existing databases..."
mysql -uroot -p${rootpasswd} -e "show databases;"
utils.printerinput "Please enter the NAME of the new WordPress database user! (example: user1)"
read username
utils.printerinput "Please enter the PASSWORD for the new WordPress database user!"
read userpass
utils.printerinfo "Creating new user..."
mysql -uroot -p${rootpasswd} -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
utils.printerok "User successfully created!"
utils.printerinfo "Granting ALL privileges on ${dbname} to ${username}!"
mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
utils.printerinfo "Generating secure salt keys"
cp /var/www/html/$1/wp-config-sample.php /var/www/html/$1/wp-config.php
SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
SRC="define('AUTH_KEY'"; DST=$(echo $SALT|cat|grep -o define\(\'AUTH_KEY\'.\\{70\\}); sed -i "/$SRC/c$DST" $CONFIG_FILE
SRC="define('SECURE_AUTH_KEY'"; DST=$(echo $SALT|cat|grep -o define\(\'SECURE_AUTH_KEY\'.\\{70\\}); sed -i "/$SRC/c$DST" $CONFIG_FILE
SRC="define('LOGGED_IN_KEY'"; DST=$(echo $SALT|cat|grep -o define\(\'LOGGED_IN_KEY\'.\\{70\\}); sed -i "/$SRC/c$DST" $CONFIG_FILE
SRC="define('NONCE_KEY'"; DST=$(echo $SALT|cat|grep -o define\(\'NONCE_KEY\'.\\{70\\}); sed -i "/$SRC/c$DST" $CONFIG_FILE
SRC="define('AUTH_SALT'"; DST=$(echo $SALT|cat|grep -o define\(\'AUTH_SALT\'.\\{70\\}); sed -i "/$SRC/c$DST" $CONFIG_FILE
SRC="define('SECURE_AUTH_SALT'"; DST=$(echo $SALT|cat|grep -o define\(\'SECURE_AUTH_SALT\'.\\{70\\}); sed -i "/$SRC/c$DST" $CONFIG_FILE
SRC="define('LOGGED_IN_SALT'"; DST=$(echo $SALT|cat|grep -o define\(\'LOGGED_IN_SALT\'.\\{70\\}); sed -i "/$SRC/c$DST" $CONFIG_FILE
SRC="define('NONCE_SALT'"; DST=$(echo $SALT|cat|grep -o define\(\'NONCE_SALT\'.\\{70\\}); sed -i "/$SRC/c$DST" $CONFIG_FILE
sed -i -e 's/database_name_here/${dbname}/g'  /var/www/html/$1/$CONFIG_FILE
sed -i -e 's/username_here/${username}/g'  /var/www/html/$1/$CONFIG_FILE
sed -i -e 's/password_here/${userpass}/g'  /var/www/html/$1/$CONFIG_FILE
echo "define('FS_METHOD', 'direct');">> /var/www/html/$1/wp-config.php
#ToDo add the nginx copy, and proper replacements.
utils.printerok "Done"