<?php
    include_once('config.php');
    include_once('dbutils.php');
    // according to JP
    
    // connect to the database
    $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
    
		session_start();
		$session_account_id = $_SESSION['account_id'];
		
    // set up a query to get the list of lists
    $query = "SELECT * FROM list WHERE account_id=$session_account_id";
    
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