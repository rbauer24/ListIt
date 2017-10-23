<?php
    include_once('config.php');
    include_once('dbutils.php');
    
    // Connect to db
    $db = connectDB($dbhost, $dbuser, $dbpassword, $dbname); 
    
    
    // get data from form
    $data = json_decode(file_get_contents('php://input'),true);
    $name = $data['name'];
    $artist = $data['artist'];
    $album = $data['album'];
    $year_released = $data['year_released'];
    $video = $data['video'];
    

    
    
    
    // variable to make sure whether form is complete
    $isComplete = true;
    
    // error message in case there are problems
    $errorMessage = "";
    
    // check if we have name
    if(!isset($name) || (strlen($name) == 0)) {
        $errorMessage .= "Please enter a name. <br/>";
        $isComplete = false;
    }
    
    // check if we have artist
    if(!isset($artist) || (strlen($artist) == 0)) {
        $errorMessage .= "Please enter an artist. <br/>";
        $isComplete = false;
    }
    
    // check if we have album
    if(!isset($album) || (strlen($album) == 0)) {
        $errorMessage .= "Please enter an album. <br/>";
        $isComplete = false;
    }
    
    // check if we have year released
    if(!isset($year_released)) {
        $errorMessage .= "Please enter the year released. <br/>";
        $isComplete = false;
    } elseif($year_released < 1900 || $year_released > 2017) {
        $errorMessage .= "Please enter the year released between 1900 and 2017. <br/>";
        $isComplete = false;
    }
    // check if we have video
    if(!isset($video) || (strlen($video) == 0)) {
        $errorMessage .= "Please enter a video. <br/>";
        $isComplete = false;
    }
    

    
    // check if song with same name, artist, album, year_released is in db but only if we have all data
    if($isComplete) {
        // this select statement returns any records in the songs table that match name, artist, album, and year_released
        $query = "SELECT * FROM songs WHERE name = '$name' AND artist = '$artist' AND album = '$album' AND year_released = $year_released";
        
        // run the select statement
        $result = queryDB($query, $db);
        
        // check if there is a duplicate
        if (nTuples($result) > 0) {
            // there is a duplicate
            $isComplete = false;
            $errorMessage .= "A song with name: $name, artist: $artist, album: $album, and year of release: $year_released is already in the database.";
        }
        
    }
    
    
    // proceed depending on whether data is ready
    if($isComplete){
        // everything looks good
        
        // connect to db
        //$db = connectDB($dbhost, $dbname, $dbpassword, $dbuser);
        
        // make video safe for sql
        $video = makeStringSafe($db, $video);
        
        // put together the insert statement to enter new record in table
        $query = "INSERT INTO songs(name, artist, album, year_released, video) VALUES('$name', '$artist', '$album', $year_released, '$video');";
        
        // run the insert statement
        $result = queryDB($query, $db);
        
        $songid = mysqli_insert_id($db);
        
        // send response back to caller of this php file
        $response = array();
        $response['status'] = 'success';
        $response['id'] = $songid;
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