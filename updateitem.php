<?php
// instead of insert do update to items in database

/*
 * Script to update songs.sql record
 * takes json object with full update of record
 */

include_once('config.php');
include_once('dbutils.php');

// get data from form - json object
$data = json_decode(file_get_contents('php://input'), true);
//$id = $data['id'];

$item_id = $data['itemid'];
$attribute_values = $data['data'];
session_start();
$session_template_id = $_SESSION['template_id'];

$list_id = $_SESSION['listid'];

// connect to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

$isComplete = true;
$errorMessage = "";

if (!isset($item_id)) {
		// if no id was passed, then failed
		$errorMessage .= "no id was sent.  ";
		$isComplete = false;
} else {
		// check if the id is in the table
		$query = "SELECT * FROM attribute WHERE item_id=$item_id";
	
		// run the query
		$result = queryDB($query, $db);
	
		if (nTuples($result) == 0) {
			$errorMessage .= "the item id, $item_id, does not match any ids in the table  ";
			$isComplete = false;
		}
}

if ($isComplete) {
// get the template attributes for the current template
    // set up a query to get them, use $session_template_id
     $query = "SELECT * FROM template_attribute WHERE template_id=$session_template_id ORDER BY ordernumber";
     
     // run the query
    $result = queryDB($query, $db);

    // set by default
    $i=0;
    // loop through each of the template attributes you get
    foreach ($result as $row ) {
        
        // access each of the items passed through in $data
        $ordernumber= $row['ordernumber'];
        $label=$row['label'];
        $type=$row['type'];
        $value=$attribute_values[$i];
        // you insert a new attribute under the current item the the label and type you can get from the template attribute and the value from $data[$i]
        $insertattr= "UPDATE attribute SET value='$value' WHERE item_id=$item_id AND label='$label'";
              
         // run insert statment
        queryDB($insertattr,$db);
        // increase for next loop
        $i++;

        
    }
    
        $response = array();
        $response['status'] = 'success';
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