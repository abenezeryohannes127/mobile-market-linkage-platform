<?php
include "db.php";

$sender = $_POST['sender_id'];
$receiver = $_POST['receiver_id'];
$message = $_POST['message'];

$sql = "INSERT INTO messages (sender_id, receiver_id, message)
        VALUES ('$sender','$receiver','$message')";

if(mysqli_query($conn,$sql)){
    echo json_encode(["status"=>"success"]);
}else{
    echo json_encode(["status"=>"error"]);
}
?>