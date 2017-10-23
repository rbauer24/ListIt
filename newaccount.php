<?php
    include_once('config.php');
    include_once('dbutils.php');
    
    // get data from form
    $data = json_decode(file_get_contents('php://input'), true);
    $username = $data['username'];
	$password = $data['password'];
	$password2 = $data['password2'];
    
   // connect to the database
    $db = connectDB($dbhost, $dbuser, $dbpassword, $dbname);    
    
    // check for required fields
    $isComplete = true;
    $errorMessage = "";
    
    if (!isset($username)) {
        $errorMessage .= " Please enter a username.";
        $isComplete = false;
    } else {
        $username = makeStringSafe($db, $username);
    }

    if (!isset($password)) {
        $errorMessage .= " Please enter a password.";
        $isComplete = false;
    }	    
	
	if (!isset($password2)) {
        $errorMessage .= " Please enter a password again.";
        $isComplete = false;
    }
	
	if ($password != $password2) {
		$errorMessage .= " Your two passwords are not the same.";
		$isComplete = false;
	}
	    
	
    if ($isComplete) {
    
		// check if there's a user with the same username
		$query = "SELECT * FROM account WHERE username='$username';";
		$result = queryDB($query, $db);
		if (nTuples($result) > 0) {
            // we have a duplicate
            $errorMessage .= " Username $username already exists. Please select a different username. ";
        }
    }
    
    if ($isComplete) {
        // generate the hashed version of the password
        $hashedpass = crypt($password, getSalt());
        
        // put together sql code to insert tuple or record
        $insert = "INSERT INTO account(username, hashedpass) VALUES ('$username', '$hashedpass');";
    
        // run the insert statement
        $result = queryDB($insert, $db);
        
        // we have successfully inserted the record
        // send response back
        $response = array();
        $response['status'] = 'success';
        header('Content-Type: application/json');
        echo(json_encode($response));
	} else {
        // if there was an error along the way
        $response = array();
        $response['status'] = 'error';
        $response['message'] = $errorMessage;
        header('Content-Type: application/json');
        echo(json_encode($response));   
	}    

?>