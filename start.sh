#!/bin/bash

# Quick Start Script for Lacowe LMS
# Starts PHP built-in development server

echo "========================================="
echo "Starting Lacowe Loan Management System"
echo "========================================="
echo ""

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Check if PHP is installed
if ! command -v php &> /dev/null; then
    echo "Error: PHP is not installed!"
    echo "Please install PHP: sudo apt install php php-mysqli"
    exit 1
fi

# Check if MySQL is running
if ! pgrep -x "mysqld" > /dev/null; then
    echo "Warning: MySQL doesn't appear to be running."
    echo "Starting MySQL..."
    sudo systemctl start mysql 2>/dev/null || sudo service mysql start 2>/dev/null
    sleep 2
fi

# Check database connection
echo "Checking database connection..."
php -r "
require_once 'config.php';
\$db = new db_connect();
\$conn = \$db->connect();
if (\$conn) {
    echo '✓ Database connection successful\n';
} else {
    echo '✗ Database connection failed: ' . \$db->error . '\n';
    echo 'Please check your database configuration in config.php\n';
    exit(1);
}
"

if [ $? -ne 0 ]; then
    echo ""
    echo "Please fix the database connection issue before starting the server."
    exit 1
fi

echo ""
echo "Starting PHP development server..."
echo "Server will be available at: http://localhost:8000"
echo ""
echo "Default login credentials:"
echo "  Username: admin"
echo "  Password: admin"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Start PHP built-in server
php -S localhost:8000



