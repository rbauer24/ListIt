<?php
/*
 * Deletes item. Gets item id in json object.
*/
include_once('config.php');
include_once('dbutils.php');

// get data from form
$data = json_decode(file_get_contents('php://input'), true);
$id = $data['id'];


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
    // check if the id is in the table
    $query = "SELECT * FROM item WHERE id=$id";
    
    // run the query
    $result = queryDB($query, $db);
    
    if(nTuples($result) == 0) {
        $errorMessage .= "The id provided, $id does not match any ids of list in the table.  ";
        $isComplete = false;
    }
}

if ($isComplete) {
    // let's Update the record of visible to make item not seen 
    $query = "UPDATE item SET visible=0 WHERE id=$id";
    
    // run the delete statement
    queryDB($query, $db);
    
    // send response back
    $response = array();
    $response['status'] = 'success';
    $response['id'] = $songid;
    header('Content-Type: application/json');
    echo(json_encode($response));
} else {
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