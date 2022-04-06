<?php
require_once("ApplicationRestHandler.php");
				
$id = "";
if(isset($_GET["id"]))
	$id = $_GET["id"];

/*
controls the RESTful services
URL mapping
*/
switch($id){
	//Get all  roles	
	case "101" :
		$restHandler = new ApplicationRestHandler();
		$restHandler->get_roles($_GET["applicationName"], $_GET["jsonParams"]);
		break;	
	//Get role (by user_mail)
	case "102" :
		$restHandler = new ApplicationRestHandler();
		$restHandler->get_role($_GET["applicationName"], $_GET["jsonParams"]);
		break;	
				
	case "" :
		//404 - not found;
		break;
}
?>


