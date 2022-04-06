<?php
require_once(__DIR__."/../../db/logger/LogServiceController.php");
require_once(__DIR__."/../SimpleRest.php");
require_once(__DIR__."/../../db/application/ApplicationController.php");
		
class ApplicationRestHandler extends SimpleRest {

	private $logIN;
    private $logOUT;
	private $logERROR;

	public function __construct() {       
		$paramDb = parse_ini_file('logconfig.ini');		
      	$this->logIN =  sprintf($paramDb['logIN']);
		$this->logOUT =  sprintf($paramDb['logOUT']);
		$this->logERROR =  sprintf($paramDb['logERROR']);
	}

	function get_roles($applicationName, $jsonParams) {		
		$logServiceController = new LogServiceController(); 
		$applicationController = new ApplicationController(); 	
		try{ 			 			
			//TEST ERROR
			//$number = 5/0;     
			//log in  
			if($this->logIN )
				$logServiceController->log('[{"type": "IN", "application_name": "'.$applicationName.'", "service_name": "application", "service_function": "get_roles", "content": '.$jsonParams.'}]');
			//do
			$rawData  = $applicationController->get_roles($jsonParams);
			//logout
			if($this->logOUT)
				$logServiceController->log('[{"type": "OUT", "application_name": "'.$applicationName.'", "service_name": "application", "service_function": "get_roles", "content": '.$this->encodeJson($rawData).'}]');
			$this->doResult($rawData);	
		}catch (ErrorException $e) {
			if($this->logERROR)
				$logServiceController->log('[{"type": "ERROR", "application_name": "'.$applicationName.'", "service_name": "application", "service_function": "get_roles", "message": "'.$e->getMessage().'"}]');
			http_response_code(500);
			throw $e;
		}	
	}

	function get_role($applicationName, $jsonParams) {		
		$logServiceController = new LogServiceController(); 
		$applicationController = new ApplicationController(); 	
		try{ 			 			
			//log in  
			if($this->logIN )
				$logServiceController->log('[{"type": "IN", "application_name": "'.$applicationName.'", "service_name": "application", "service_function": "get_role", "content": '.$jsonParams.'}]');
			//do
			$rawData  = $applicationController->get_role($jsonParams);
			//logout
			if($this->logOUT)
				$logServiceController->log('[{"type": "OUT", "application_name": "'.$applicationName.'", "service_name": "application", "service_function": "get_role", "content": '.$this->encodeJson($rawData).'}]');
			$this->doResult($rawData);	
		}catch (ErrorException $e) {
			if($this->logERROR)
				$logServiceController->log('[{"type": "ERROR", "application_name": "'.$applicationName.'", "service_name": "application", "service_function": "get_role", "message": "'.$e->getMessage().'"}]');
			http_response_code(500);
			throw $e;
		}	
	}	

}
?>