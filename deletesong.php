<?php
    /*
     *Deletes player. Gets player id object
     */

    include_once('config.php');
    include_once('dbutils.php');
    
    // Connect to db
    $db = connectDB($dbhost, $dbuser, $dbpassword, $dbname);
    
    // get data from form
    $data = json_decode(file_get_contents('php://input'),true);
    $id = $data['id'];
    
    // variable to make sure whether form is complete
    $isComplete = true;
    
    // error message in case there are problems
    $errorMessage = "";
    
    if (!isset($id)) {
        // if no id was passed we fail
        $errorMessage .= "No id was sent. ";
        $isComplete = false;
    } else {
        // check if id is in table
        $query = "SELECT * FROM songs WHERE id=$id";
        
        //run query
        $result = queryDB($query,$db);
        
        if(nTuples($result) == 0) {
            $errorMessage .= "The id provided does not match any ids of songs in the table. ";
            $isComplete = false; 
        }
    }

    if($isComplete) {
        // lets delete the record
        $query = "DELETE FROM songs WHERE id=$id";
        
        // run the delete statement
        queryDB($query, $db);
        
        // send response back to caller of this php file
        $response = array();
        $response['status'] = 'success';
        header('Content-Type: application/json');
        echo(json_encode($response));
    } else {
        // generate error to send to caller
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