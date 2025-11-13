# Starting MySQL/MariaDB Database

## Quick Start

To start the database server, run:

```bash
sudo systemctl start mariadb
```

Or if you have MySQL instead:

```bash
sudo systemctl start mysql
```

## Verify Database is Running

```bash
sudo systemctl status mariadb
```

You should see "Active: active (running)"

## Import Database (if not already done)

```bash
# First, create the database if it doesn't exist
sudo mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS db_lms;"

# Then import the SQL file
sudo mysql -u root -p db_lms < "db here/db_lms.sql"
```

## Enable Auto-start on Boot

```bash
sudo systemctl enable mariadb
```

## Troubleshooting

If you get "Access denied" errors:
- Make sure you're using the correct MySQL root password
- If you don't have a password set, you might need to set one or use `sudo mysql` without `-p`

If the socket file is not found:
- Make sure MySQL/MariaDB is running
- Try using `127.0.0.1` instead of `localhost` in config.php (already handled in updated code)



