<?php
    include_once('config.php');
    include_once('dbutils.php');

    // Connect to db
    $db = connectDB($dbhost, $dbuser, $dbpassword, $dbname);
    
    // Set up a query to get data on songs
    $query = "SELECT * FROM songs;";
    
    // Run the query
    $result = queryDB($query, $db);
    
    // Assing results to array
    $rows = array();
    while ($row=nextTuple($result)) {
        $rows[] = $row;
    }
    
    // Put together JSON object to send back
    header('Content-Type: application/json');
    echo (json_encode($rows));
  
?>

