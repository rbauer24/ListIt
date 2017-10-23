<?php
    /*
     * Takes attribute/value pair and sets it as session variable if logged in
     */
    
    $isComplete = true;
    $errorMessage = "";

    session_start();
    if (!isset($_SESSION['username'])) {
        // if not logged in
        
        $isComplete = false;
        $errorMessage .= " You are not logged in and cannot set a session variable. ";
    }
    
    if ($isComplete) {
        // if logged in
        
        // get data from form
        $data = json_decode(file_get_contents('php://input'), true);
        $attribute = $data['attribute'];
        $value = $data['value'];
        
        if (!isset($attribute) || $attribute == 'username') {
            $isComplete = false;
            $errorMessage .= " You need to submit a valid attribute. ";
        }
        
        if (!isset($value)) {
            $isComplete = false;
            $errorMessage .= " You need to submit a value. ";
        }
    }
    
    if ($isComplete) {
        // set session variable if everything's ok
        $_SESSION[$attribute] = $value;
        
         // send response back
        $response = array();
        $response['status'] = 'success';
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