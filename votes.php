<?php
/*
 * Deletes item. Gets item id in json object.
*/
include_once('config.php');
include_once('dbutils.php');

// get data from form
$data = json_decode(file_get_contents('php://input'), true);
$id = $data['id'];
session_start();
$session_id= $_SESSION['account_id'];


// variable to keep track if the form is complete (set to false if there are any issues with data)
$isComplete = true;

// error message we'll give user in case there are issues with data
$errorMessage = "";

// connect to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

if (!isset($id)) {
    // if no id was passed, then we fail
    $errorMessage .= "No id was sent.  ";
    $isComplete = false;
} else {
    // check if the user already liked the table
    $query= "SELECT * from VOTES WHERE account_id=$session_id AND list_id=$id";
    
    // run the query
    $result = queryDB($query, $db);
    if(nTuples($result)>0){
    // if no id was passed, then we fail
    $errorMessage .= "You have already Voted";
    $isComplete = false;
    }
       
}

if ($isComplete) { // check if the id is in the table
    
    $query = "INSERT INTO VOTES (account_id, list_id,vote) Values($session_id,$id, 1) ";
    
    // run the query
    $result = queryDB($query, $db);
    $updatequery = "UPDATE list SET votes =votes+1 WHERE id=$id";
    // run the query
    $result = queryDB($updatequery, $db);
    
// send response back
    $response = array();
    $response['status'] = 'success';
    $response['id'] = $id;
    header('Content-Type: application/json');
    echo(json_encode($response));
}
 else {
    ob_start();
    var_dump($data);
    $postdump = ob_get_clean();

    $response = array();
    $response['status'] = 'error';
    $response['message'] = $errorMessage . $postdump;
    header('Content-Type: application/json');
    echo(json_encode($response));    
}


?>