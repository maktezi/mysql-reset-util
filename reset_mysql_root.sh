#!/bin/bash

# Full Reset MySQL root password on a Linux Ubunto/Debian.

# Stop MySQL service
echo "Stopping MySQL service..."
sudo systemctl stop mysql

# Remove MySQL packages and configurations
echo "Removing MySQL packages..."
sudo apt remove --purge mysql-server mysql-client mysql-common -y
sudo apt autoremove -y
sudo apt autoclean

# Delete MySQL data and configuration files
echo "Deleting MySQL data and configuration files..."
sudo rm -rf /var/lib/mysql
sudo rm -rf /etc/mysql

# Update package lists and reinstall MySQL server
echo "Updating package lists and reinstalling MySQL server..."
sudo apt update
sudo apt install mysql-server -y

# Secure MySQL installation
echo "Running mysql_secure_installation..."
sudo mysql_secure_installation

# Log into MySQL and reset the root password
echo "Resetting MySQL root password..."
sudo mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '[password]';
FLUSH PRIVILEGES;
EOF

echo "MySQL root password has been reset. You can now log in with the new password using:"
echo "mysql -u root -p"
