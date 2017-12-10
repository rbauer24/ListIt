<?php

		// return all attributes refer to the template_id == session variable $temp_id, defined in createlist.php
		// display on editlist.html
		
    include_once('config.php');
    include_once('dbutils.php');
    		
    // connect to the database
    $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
    		
		session_start();
		$session_temp_id = $_SESSION['template_id'];
		// $session_temp_id = 1;
    // set up a query to get the data on template_attribute refer to template_id == $temp_id
		
    $query = "SELECT * FROM template_attribute WHERE template_id=$session_temp_id order by ordernumber";
    
    // run the query
    $result = queryDB($query, $db);
    
    // assign results to array
    $rows = array();
    while ($row = nextTuple($result)) {
        $rows[] = $row;
    }
    
    // put together JSON object to send back
	$response = array();
    $response['status'] = 'success';
    $response['value'] = $rows;
    header('Content-Type: application/json');
    echo(json_encode($response));
?>