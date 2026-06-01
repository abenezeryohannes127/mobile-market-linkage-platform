<?php
include "../db.php";
$data=json_decode(file_get_contents("php://input"));
$stmt=$conn->prepare("INSERT INTO orders(product_id,buyer_id,status) VALUES(?,?, 'pending')");
$stmt->bind_param("ii",$data->product_id,$data->buyer_id);
$stmt->execute();
echo json_encode(["success"=>true]);
?>