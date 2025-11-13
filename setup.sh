#!/bin/bash

# Lacowe Loan Management System - Quick Setup Script
# This script helps set up the LMS on Kali Linux/Debian/Ubuntu

echo "========================================="
echo "Lacowe Loan Management System Setup"
echo "========================================="
echo ""

# Check if running as root for certain operations
if [ "$EUID" -ne 0 ]; then 
    echo "Note: Some operations may require sudo privileges"
    echo ""
fi

# Step 1: Check if Apache is installed
echo "Step 1: Checking Apache..."
if ! command -v apache2 &> /dev/null; then
    echo "Apache not found. Installing Apache..."
    sudo apt update
    sudo apt install apache2 -y
else
    echo "✓ Apache is installed"
fi

# Step 2: Check if PHP is installed
echo ""
echo "Step 2: Checking PHP..."
if ! command -v php &> /dev/null; then
    echo "PHP not found. Installing PHP..."
    sudo apt install php php-mysqli -y
else
    echo "✓ PHP is installed"
    # Check for mysqli extension
    if php -m | grep -q mysqli; then
        echo "✓ PHP mysqli extension is installed"
    else
        echo "Installing PHP mysqli extension..."
        sudo apt install php-mysqli -y
    fi
fi

# Step 3: Check if MySQL is installed
echo ""
echo "Step 3: Checking MySQL..."
if ! command -v mysql &> /dev/null; then
    echo "MySQL not found. Installing MySQL..."
    sudo apt install mysql-server -y
else
    echo "✓ MySQL is installed"
fi

# Step 4: Start services
echo ""
echo "Step 4: Starting services..."
sudo systemctl start apache2 2>/dev/null
sudo systemctl start mysql 2>/dev/null
sudo systemctl enable apache2 2>/dev/null
sudo systemctl enable mysql 2>/dev/null
echo "✓ Services started"

# Step 5: Database setup
echo ""
echo "Step 5: Setting up database..."
echo "Please enter MySQL root password (press Enter if no password):"
read -s MYSQL_PASSWORD

# Create database
if [ -z "$MYSQL_PASSWORD" ]; then
    sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS db_lms;" 2>/dev/null
    sudo mysql -u root db_lms < "db here/db_lms.sql" 2>/dev/null
else
    sudo mysql -u root -p"$MYSQL_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS db_lms;" 2>/dev/null
    sudo mysql -u root -p"$MYSQL_PASSWORD" db_lms < "db here/db_lms.sql" 2>/dev/null
fi

if [ $? -eq 0 ]; then
    echo "✓ Database created and imported"
else
    echo "⚠ Database setup may have failed. Please import manually:"
    echo "   sudo mysql -u root -p db_lms < 'db here/db_lms.sql'"
fi

# Step 6: Set permissions
echo ""
echo "Step 6: Setting file permissions..."
PROJECT_DIR="$(pwd)"
sudo chown -R www-data:www-data "$PROJECT_DIR" 2>/dev/null
sudo chmod -R 755 "$PROJECT_DIR" 2>/dev/null
echo "✓ Permissions set"

# Step 7: Create symbolic link in web root (optional)
echo ""
echo "Step 7: Create web server link..."
read -p "Create symbolic link in /var/www/html? (y/n): " CREATE_LINK
if [ "$CREATE_LINK" = "y" ] || [ "$CREATE_LINK" = "Y" ]; then
    sudo ln -sf "$PROJECT_DIR" /var/www/html/lms
    echo "✓ Symbolic link created at /var/www/html/lms"
    echo ""
    echo "========================================="
    echo "Setup Complete!"
    echo "========================================="
    echo ""
    echo "Access your application at:"
    echo "  http://localhost/lms"
    echo ""
    echo "Default login credentials:"
    echo "  Username: admin"
    echo "  Password: admin"
else
    echo ""
    echo "========================================="
    echo "Setup Complete!"
    echo "========================================="
    echo ""
    echo "To run the application:"
    echo "  Option 1: Use PHP built-in server:"
    echo "    php -S localhost:8000"
    echo "    Then visit: http://localhost:8000"
    echo ""
    echo "  Option 2: Create symbolic link manually:"
    echo "    sudo ln -s '$PROJECT_DIR' /var/www/html/lms"
    echo "    Then visit: http://localhost/lms"
    echo ""
    echo "Default login credentials:"
    echo "  Username: admin"
    echo "  Password: admin"
fi

echo ""
echo "Note: If MySQL root has a password, update config.php"



