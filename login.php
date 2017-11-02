<?php
    include_once('config.php');
    include_once('dbutils.php');
    
    // get data from form
    $data = json_decode(file_get_contents('php://input'), true);
    $username = $data['username'];
	$password = $data['password'];
    
   // connect to the database
    $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);    
    
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
	
    if ($isComplete) {   
    
        // get the hashed password from the user with the email that got entered
        $query = "SELECT hashedpass FROM account WHERE username='$username';";
        $result = queryDB($query, $db);
        
        if (nTuples($result) == 0) {
            // no such username
            $errorMessage .= " Username $username does not correspond to any account in the system. ";
            $isComplete = false;
        }
    }
    
    if ($isComplete) {            
        // there is an account that corresponds to the email that the user entered
		// get the hashed password for that account
		$row = nextTuple($result);
		$hashedpass = $row['hashedpass'];
		
		// compare entered password to the password on the database
		if ($hashedpass != crypt($password, $hashedpass)) {
            // if password is incorrect
            $errorMessage .= " The password you enterered is incorrect. ";
            $isComplete = false;
        }
    }
         
    if ($isComplete) {   
        // password was entered correctly
        
        // start a session
        session_start();
        $_SESSION['username'] = $username;
        
        // send response back
        $response = array();
        $response['status'] = 'success';
		$response['message'] = 'logged in';
        header('Content-Type: application/json');
        echo(json_encode($response));
    } else {
        // send response for error
        $response = array();
        $response['status'] = 'error';
        $response['message'] = $errorMessage;
        header('Content-Type: application/json');
        echo(json_encode($response));        
    }

?>
