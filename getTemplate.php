<?php
    include_once('config.php');
    include_once('dbutils.php');
    		
    // connect to the database
    $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
    		
    // set up a query to get the data on template table
    $query = "SELECT * FROM template";
    
    // run the query
    $result = queryDB($query, $db);
    
    // assign results to array
    $rows = array();
    while ($row = nextTuple($result)) {
        $rows[] = $row;
    }
    
    // put together JSON object to send back
    header('Content-Type: application/json');			// sending back a json object
    echo(json_encode($rows));
?>