<?php
	
if(!defined("SFCNR_APPLICATION"))
	exit;

class Sql extends mysqli {


	public function __construct($host, $user, $pass, $database, $debug = 0) 
	{
		parent::__construct($host, $user, $pass, $database);


		if(mysqli_connect_error())
		{
				echo "Connection to the database failed ( " . mysqli_connect_errno() . " ) " . mysqli_connect_error();
		}
	}
}

?>