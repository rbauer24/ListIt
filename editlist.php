<?php
/*
 * Script to update songs.sql record
 * takes json object with full update of record
 */

include_once('config.php');
include_once('dbutils.php');

// session id of list id and template id
session_start();
$session_list_id = $_SESSION['listid'];
$session_template_id = $_SESSION['template_id'];

// connect to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

// get attributes refer to the template
$query = "SELECT * FROM template_attribute WHERE template_id = $session_template_id";

// get data from form - json object
$data = json_decode(file_get_contents('php://input'), true);
// $id = $data['id'];


// variable to keep track if the form is complete (set to false if there are any issues with data)
$isComplete = true;

// error message we'll give user in case there are issues with data
$errorMessage = "";

// check each of the required variables in the table


if (!isset($session_list_id)) {
		// if no id was passed, then failed
		$errorMessage .= "no id was sent.  ";
		$isComplete = false;
} else {
		// check if the id is in the table
		$query = "SELECT * FROM list WHERE id=$session_list_id";
	
		// run the query
		$result = queryDB($query, $db);
	
		if (nTuples($result) == 0) {
			$errorMessage .= "the id, $session_list_id, does not match any ids in the table  ";
			$isComplete = false;
		}
}


// Stop execution and show error if the form is not complete
if($isComplete) {
    // if everything required is complete        
            
    // make video string safe
    // $video = makeStringSafe($db, $video);
    
    //
    // first enter record into attribute table
    //
    // put together SQL statement to insert new record
    //$query = "UPDATE list SET WHERE id=$session_list_id";
    
    // run the insert statement
    $result = queryDB($query, $db);
    
    // send response back
    $response = array();
    $response['status'] = 'success';
    $response['id'] = $session_list_id;
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