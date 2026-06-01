<?php
include "../db.php";
$data=json_decode(file_get_contents("php://input"));
$stmt=$conn->prepare("UPDATE orders SET status=? WHERE id=?");
$stmt->bind_param("si",$data->status,$data->order_id);
$stmt->execute();
echo json_encode(["success"=>true]);
?>