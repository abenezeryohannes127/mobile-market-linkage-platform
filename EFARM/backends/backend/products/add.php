<?php
include "../db.php";
$data=json_decode(file_get_contents("php://input"));
$stmt=$conn->prepare("INSERT INTO products(name,price,seller_id) VALUES(?,?,?)");
$stmt->bind_param("sdi",$data->name,$data->price,$data->seller_id);
$stmt->execute();
echo json_encode(["success"=>true]);
?>