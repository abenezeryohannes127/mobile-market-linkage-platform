<?php
header("Content-Type: application/json");
include 'db.php';

$name = $_POST['name'];
$price = $_POST['price'];
//$address = $_POST['address'];
$userId =  $_POST['user_id'];
$image = $_FILES['image']['name'];
$tmp = $_FILES['image']['tmp_name'];

$path = "uploads/".$image;
move_uploaded_file($tmp,$path);

$sql = "INSERT INTO products(name,price,image,user_id) VALUES('$name','$price','$image','$userId')";

if($conn->query($sql)){
    echo json_encode(["status"=>"success"]);
}else{
    echo json_encode(["status"=>"error"]);
}
?>
