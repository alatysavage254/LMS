# How to Run the Application in Terminal

## Quick Start (3 Steps)

### Step 1: Start MySQL/MariaDB Database
```bash
sudo systemctl start mariadb
```

### Step 2: Navigate to Project Directory
```bash
cd "/media/alaty/drive/Project X/LMS"
```

### Step 3: Start PHP Development Server
```bash
php -S localhost:8000
```

That's it! The server will start and show:
```
PHP 8.4.11 Development Server (http://localhost:8000) started
```

## Access Your Application

Open your web browser and go to:
```
http://localhost:8000
```

## Stop the Server

Press `Ctrl + C` in the terminal where the server is running.

## Alternative: Run in Background

If you want to run the server in the background:
```bash
php -S localhost:8000 > /dev/null 2>&1 &
```

To stop a background server:
```bash
pkill -f "php -S localhost:8000"
```

## Check if Server is Running

```bash
ps aux | grep "php -S localhost:8000" | grep -v grep
```

## Check Database Status

```bash
sudo systemctl status mariadb
```

## Full Setup (First Time Only)

If you haven't set up the database yet:

```bash
# 1. Start MySQL
sudo systemctl start mariadb

# 2. Create database
sudo mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS db_lms;"

# 3. Import database
sudo mysql -u root -p db_lms < "db here/db_lms.sql"

# 4. Start PHP server
cd "/media/alaty/drive/Project X/LMS"
php -S localhost:8000
```

## Login Credentials

- Username: `admin`
- Password: `admin`


