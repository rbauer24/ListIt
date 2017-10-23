<?php
    /*
     * Takes an attribute and returns a session variable's corresponding value
     */
    
    $isComplete = true;
    $errorMessage = "";

    session_start();
    if (!isset($_SESSION['username'])) {
        // if not logged in
        
        $isComplete = false;
        $errorMessage .= " You are not logged in and cannot get a session variable. ";
    }
    
    if ($isComplete) {
        // if logged in
        
        // get data from form
        $data = json_decode(file_get_contents('php://input'), true);
        $attribute = $data['attribute'];
        
        if (!isset($attribute)) {
            $isComplete = false;
            $errorMessage .= " You need to submit a valid attribute. ";
        } else if (!isset($_SESSION[$attribute])) {
            $isComplete = false;
            $errorMessage .= " The session variable $attribute is not set. ";
        }
    }
    
    if ($isComplete) {
        // set session variable if everything's ok
        $value = $_SESSION[$attribute];
        
         // send response back
        $response = array();
        $response['status'] = 'success';
        $response['value'] = $value;
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