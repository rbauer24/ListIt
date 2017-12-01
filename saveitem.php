<?php
include_once('config.php');
    include_once('dbutils.php');
    		
    // connect to the database
     $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
     
     // session id of list id and template id
session_start();
$session_list_id = $_SESSION['listid'];
$session_template_id = $_SESSION['template_id'];


// get data from form - json object
$data = json_decode(file_get_contents('php://input'), true);

// get the template attributes for the current template
    // set up a query to get them, use $session_template_id
     $query = "SELECT * FROM template_attribute WHERE template_id=$session_template_id";
     
     // run the query
    $result = queryDB($query, $db);
    
    // figure out the order to input into newitem
    $query = "SELECT max(ordernumber) AS maxorder FROM item  WHERE list_id=$session_list_id";
    // run the query
    $itemresult = queryDB ($query,$db);
    
    // default for max order
    //$maxorder=0;
    
    if (nTuples($itemresult)>0){
        $row = nextTuple($itemresult);
        $maxorder = $row ["maxorder"];
        if($maxorder == NULL) {
            $maxorder = 0;
        } else {
            $maxorder++;
        }
    }
    // create a new item under the current list -> insert into item (listid) values $session_list_id
    $insert = "INSERT INTO item (list_id, ordernumber) VALUES ( $session_list_id,$maxorder)";
    
    // run insert statment
    queryDB($insert,$db);
    
    
    // get the id for this item you just created
    $itemid= mysqli_insert_id($db);
    
    // set by default
    $i=0;
    // loop through each of the template attributes you get
    foreach ($result as $row ) {
        
        // access each of the items passed through in $data
        $ordernumber= $row['ordernumber'];
        $label=$row['label'];
        $type=$row['type'];
        $value=$data[$i];
        // you insert a new attribute under the current item the the label and type you can get from the template attribute and the value from $data[$i]
        $insertattr= "INSERT INTO attribute (item_id,ordernumber, label, type, value) VALUES ($itemid, $ordernumber, '$label', '$type', '$value')";
              
         // run insert statment
        queryDB($insertattr,$db);
        // increase for next loop
        $i++;

        
    }
    
    // $i=0
        // access each of the items passed through in $data
        // you can access them by index $data[$i]
        // you insert a new attribute under the current item, wi
        //the the label and type you can get from the template attribute and the value from $data[$i]
        // $i++
     
?>