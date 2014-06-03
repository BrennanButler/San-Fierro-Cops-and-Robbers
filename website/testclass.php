<?php
	
	define("SFCNR_APPLICATION", true);

	require("config.php");
	require("classes/database.class.php");
	require("classes/template.class.php");
	
	$template->SetTitle("chicken_title");
	$template->SetDesc("poops 'n all");

	include("./templates/header.template.php");

	include("./test.php"); 
	$obj = new Sql($ServerDetails['mysql_host'], $ServerDetails['mysql_username'], $ServerDetails['mysql_password'], "sfcnr");
	$res = $obj->query("SELECT * FROM `sweeper`");
	while($row = $res->fetch_assoc())
	{
		print_r( $row );
	}
	
?>