# Lacowe Loan Management System - Setup Guide

## Prerequisites
- Apache web server
- PHP 7.4 or higher (with mysqli extension)
- MySQL/MariaDB database server

## Step 1: Install Required Software

### On Kali Linux/Debian/Ubuntu:

```bash
# Update package list
sudo apt update

# Install Apache, PHP, and MySQL
sudo apt install apache2 php php-mysqli mysql-server -y

# Start Apache and MySQL services
sudo systemctl start apache2
sudo systemctl start mysql
sudo systemctl enable apache2
sudo systemctl enable mysql
```

## Step 2: Set Up MySQL Database

```bash
# Secure MySQL installation (optional but recommended)
sudo mysql_secure_installation

# Login to MySQL
sudo mysql -u root -p
```

### In MySQL console:

```sql
-- Create database
CREATE DATABASE db_lms;

-- Create a MySQL user (optional, or use root)
CREATE USER 'lms_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON db_lms.* TO 'lms_user'@'localhost';
FLUSH PRIVILEGES;

-- Exit MySQL
EXIT;
```

## Step 3: Import Database

```bash
# Navigate to your project directory
cd "/media/alaty/drive/Project X/LMS"

# Import the database
sudo mysql -u root -p db_lms < "db here/db_lms.sql"
```

## Step 4: Configure Database Connection

Edit the `config.php` file if needed (current settings work with default MySQL root user):

```php
define("db_host", "localhost");
define("db_user", "root");        // Change if you created a different user
define("db_pass", "");            // Change if MySQL root has a password
define("db_name", "db_lms");
```

**Note:** If your MySQL root user has a password, update `db_pass` in `config.php`.

## Step 5: Set Up Web Server

### Option A: Using Apache (Recommended)

```bash
# Copy project to web root (if not already there)
sudo cp -r "/media/alaty/drive/Project X/LMS" /var/www/html/lms

# OR create a symbolic link
sudo ln -s "/media/alaty/drive/Project X/LMS" /var/www/html/lms

# Set proper permissions
sudo chown -R www-data:www-data /var/www/html/lms
sudo chmod -R 755 /var/www/html/lms
```

### Option B: Using PHP Built-in Server (For Development)

```bash
# Navigate to project directory
cd "/media/alaty/drive/Project X/LMS"

# Start PHP development server
php -S localhost:8000
```

## Step 6: Access the Application

### If using Apache:
Open your browser and go to:
```
http://localhost/lms
```

### If using PHP built-in server:
Open your browser and go to:
```
http://localhost:8000
```

## Step 7: Login

**Default Credentials:**
- Username: `admin`
- Password: `admin`

## Troubleshooting

### Database Connection Error
- Check if MySQL is running: `sudo systemctl status mysql`
- Verify database exists: `sudo mysql -u root -p -e "SHOW DATABASES;"`
- Check database credentials in `config.php`

### Permission Errors
- Ensure Apache can read files: `sudo chmod -R 755 /var/www/html/lms`
- Check Apache error logs: `sudo tail -f /var/log/apache2/error.log`

### PHP Errors
- Check PHP version: `php -v` (should be 7.4+)
- Verify mysqli extension: `php -m | grep mysqli`
- Check PHP error logs: `sudo tail -f /var/log/apache2/error.log`

### Port Already in Use
- If port 80 is in use, use a different port or stop the conflicting service
- For PHP built-in server, use a different port: `php -S localhost:8080`

## File Structure

```
LMS/
├── index.php          # Login page
├── home.php           # Dashboard
├── config.php         # Database configuration
├── class.php          # Main database class
├── login.php          # Login handler
├── logout.php         # Logout handler
├── session.php        # Session check
├── borrower.php       # Borrower management
├── loan.php           # Loan management
├── payment.php        # Payment management
├── loan_type.php      # Loan type management
├── loan_plan.php      # Loan plan management
├── user.php           # User management
├── db here/
│   └── db_lms.sql     # Database dump
└── [other files]
```

## Quick Start Commands

```bash
# Start services
sudo systemctl start apache2 mysql

# Check service status
sudo systemctl status apache2
sudo systemctl status mysql

# Stop services
sudo systemctl stop apache2 mysql

# Restart services
sudo systemctl restart apache2 mysql
```



