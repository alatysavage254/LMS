#!/bin/bash

# Quick script to run the Lacowe LMS application

echo "========================================="
echo "Starting Lacowe Loan Management System"
echo "========================================="
echo ""

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Check if PHP server is already running
if pgrep -f "php -S localhost:8000" > /dev/null; then
    echo "✓ PHP server is already running on port 8000"
else
    echo "Starting PHP server..."
    php -S localhost:8000 > /dev/null 2>&1 &
    sleep 2
    echo "✓ PHP server started on port 8000"
fi

# Check MySQL/MariaDB status
echo ""
echo "Checking database status..."
if systemctl is-active --quiet mariadb 2>/dev/null || systemctl is-active --quiet mysql 2>/dev/null; then
    echo "✓ Database is running"
else
    echo "⚠ Database is not running"
    echo ""
    echo "To start the database, run:"
    echo "  sudo systemctl start mariadb"
    echo "  or"
    echo "  sudo systemctl start mysql"
    echo ""
    echo "The application will load, but login won't work until the database is started."
fi

echo ""
echo "========================================="
echo "Application is ready!"
echo "========================================="
echo ""
echo "🌐 Open your browser and go to:"
echo "   http://localhost:8000"
echo ""
echo "📋 Default login credentials:"
echo "   Username: admin"
echo "   Password: admin"
echo ""
echo "⚠ Note: You need to start MySQL/MariaDB to use the application:"
echo "   sudo systemctl start mariadb"
echo ""
echo "Press Ctrl+C to stop the server"

# Keep the script running and show server logs
tail -f /dev/null


