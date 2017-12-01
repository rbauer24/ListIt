<?php
include_once('config.php');
include_once('dbutils.php');

// get data from form
$data = json_decode(file_get_contents('php://input'), true);
$name = $data['name'];
$temp_id = $data ['template_id'];

session_start();
$account_id = $_SESSION['account_id'];


// connect to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);


// variable to keep track if the form is complete (set to false if there are any issues with data)
$isComplete = true;

// error message we'll give user in case there are issues with data
$errorMessage = "";


// check each of the required variables in the table
if (!isset($name) || (strlen($name) == 0)) {
    $errorMessage .= "Please enter a name.\n";
    $isComplete = false;
}

if (!isset($temp_id)) {
    $errorMessage .= "Please select a template.\n";
    $isComplete = false;
}

// Stop execution and show error if the form is not complete
if($isComplete) {
    // if everything required is complete        
            
    // make video string safe
    $video = makeStringSafe($db, $name);
    
    //
    // first enter record into players table
    //
    // put together SQL statement to insert new record
    $query = "INSERT INTO list(name, template_id, account_id) VALUES ('$name', $temp_id, $account_id);";
    
    // run the insert statement
    $result = queryDB($query, $db);
    
    
    // get the id for list we just entered
    session_start();
    $_SESSION['listid'] = mysqli_insert_id($db);
    $_SESSION['template_id'] = $temp_id;
    
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