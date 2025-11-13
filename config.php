<?php
define("db_host", "localhost");
define("db_user", "lms_user");
define("db_pass","lms_password"); 
define("db_name", "db_lms");

class db_connect
{
	public $host = db_host;
	public $user = db_user;
	public $pass = db_pass;
	public $name = db_name;
	public $conn;
	public $error;

	public function connect()
	{
		try {
			// Try connecting with localhost first, fallback to 127.0.0.1
			$this->conn = @new mysqli(
				$this->host,
				$this->user,
				$this->pass,
				$this->name
			);

			// Check for connection error
			if ($this->conn->connect_error) {
				// Try with 127.0.0.1 if localhost fails
				if ($this->host == "localhost") {
					$this->conn = @new mysqli(
						"127.0.0.1",
						$this->user,
						$this->pass,
						$this->name
					);
				}
				
				if ($this->conn->connect_error) {
					$this->error = "Fatal Error: Can't connect to database. " . $this->conn->connect_error;
					return false;
				}
			}

			return $this->conn;
		} catch (Exception $e) {
			$this->error = "Fatal Error: Can't connect to database. " . $e->getMessage();
			return false;
		}
	}
}
?>