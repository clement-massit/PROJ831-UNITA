<?php
require_once(__DIR__."/../Connection.php");

class LogServiceController{

    private $db_conn;
    private $db_sche;

    public function __construct() {         
        $paramDb = parse_ini_file('param.ini');
        $this->db_conn = pg_connect(Connection::get($paramDb['database'])); 
        $this->db_sche =  sprintf($paramDb['schema']);
    }
  
  /*  public function get($jsonParams) {
        $query= "SELECT * FROM ".$this->db_sche.".get_log_service('".$jsonParams."'::json);";
        $result = pg_query($this->db_conn, $query); 
        $json = pg_fetch_array($result);
        return json_decode($json[0], true);        
    }*/

    public function log($jsonParams) {
        /*echo '<script type="text/javascript">alert("'.str_replace("'", "''", $jsonParams).'");</script>';*/
        $query= "SELECT * FROM ".$this->db_sche.".insert_log_service('".str_replace("'", "''", $jsonParams)."'::json);";
        $result = pg_query($this->db_conn, $query);         
        $json = pg_fetch_array($result);
        return json_decode($json[0], true);          
    }
}
?>