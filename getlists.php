<?php
    include_once('config.php');
    include_once('dbutils.php');
    // according to JP
    
session_start();
$session_id= $_SESSION['account_id'];

    // connect to the database
    $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
    
    //check if logged in
    if (!isset($session_id)) {
    // if no id was passed, then we fail
    $query = "SELECT * FROM list";
    
} else {
    // if logged in
        // fancy query with whether they
        $query="SELECT list.id,list.name,list.template_id,list.account_id,list.visible,list.votes, case when list.id in (SELECT list_id from VOTES WHERE account_id=$session_id) then 'yes' else 'no' end as voted from list";
        
}

$result = queryDB($query, $db);

    // assign results to array
    $lists = array();
    $i = 0;
    while ($list = nextTuple($result)) {
        $lists[$i] = $list;
        
        $listid = $list['id'];
        
        // now get the items under the current list
        $query = "SELECT * FROM item WHERE list_id = $listid AND visible=1 ORDER BY ordernumber";
        
        // run the query
        $result_item = queryDB($query, $db);
        $items = array();
        $j = 0;
        while ($item = nextTuple($result_item)) {
            $items[$j] = $item;
            
            $itemid = $item['id'];
            
            // now get the attributes for this item
            $query = "SELECT * FROM attribute WHERE item_id = $itemid ORDER BY ordernumber";
            
            //run the query
            $result_attribute = queryDB($query, $db);
            $attributes = array();
            $k = 0;
            while ($attribute = nextTuple($result_attribute)) {
                $attributes[$k] = $attribute;
                $k++;
            }
            
            $items[$j]['attributes'] = $attributes;
            $j++;
        }
        
        $lists[$i]['items'] = $items;
        
        $i++;
    }
    
    // put together JSON object to send back
    // send response back
    $response = array();
    $response['status'] = 'success';
    $response['value'] = $lists;
    header('Content-Type: application/json');
    echo(json_encode($response));
?>