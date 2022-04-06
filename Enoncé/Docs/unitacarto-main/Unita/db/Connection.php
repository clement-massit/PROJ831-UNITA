<?php

class Connection {
                           
    private static $conn;
                               
    public static function get() {                           
      
        $paramDb = parse_ini_file('param.ini');
        if ($paramDb === false) {
            throw new \Exception("Error reading database config file, please check param.ini file");
        }
     
        $connString = sprintf("host=%s port=%d dbname=%s user=%s password=%s",
            $paramDb['host'],
            $paramDb['port'],
            $paramDb['database'],
            $paramDb['user'],
            $paramDb['password']);
                    
        return $connString;
    }
                           
    protected function __construct() { }
                           
}
?>