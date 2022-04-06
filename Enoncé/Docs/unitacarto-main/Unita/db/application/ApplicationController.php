<?php
require_once(__DIR__."/../Connection.php");

class ApplicationController{

    private $db_conn;
    private $db_sche;

    public function __construct() {       
        $paramDb = parse_ini_file('param.ini');
        $this->db_conn = pg_connect(Connection::get($paramDb['database'])); 
        $this->db_sche =  sprintf($paramDb['schema']);
    }
    
    public function get_roles($jsonParams) {
        $query= "SELECT * FROM ".$this->db_sche.".get_roles('".$jsonParams."'::json);";
        $result = pg_query($this->db_conn, $query);         
        $json = pg_fetch_array($result);
        return json_decode($json[0], true);      
    }

    public function get_role($jsonParams) {
        $query= "SELECT * FROM ".$this->db_sche.".get_role('".$jsonParams."'::json);";
        $result = pg_query($this->db_conn, $query);         
        $json = pg_fetch_array($result);
        return json_decode($json[0], true);      
    }
}
?>