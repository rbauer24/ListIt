<?php
	
    include_once('config.php');
    include_once('dbutils.php');
    		
    // connect to the database
    $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
    
 // get data from form
        $data = json_decode(file_get_contents('php://input'), true);
        $listid = $data['listid'];
        
		// start the session and get listid and go through template_id to overwite the old one
        session_start();
        $_SESSION['listid']=$listid;
        $query= "SELECT template_id FROM list WHERE id=$listid AND visible=1";
        $result=  queryDB($query, $db);
        $row = nextTuple($result);
        $_SESSION['template_id'] = $row['template_id'];
        // write in new session variable which will overwrite previous one from editlist.php 
        
          // send response back
        $response = array();
        $response['status'] = 'success';
        header('Content-Type: application/json');
        echo(json_encode($response));
?>