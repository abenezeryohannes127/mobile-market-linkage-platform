<?php
include "../db.php";
$data=json_decode(file_get_contents("php://input"));
$stmt=$conn->prepare("UPDATE orders SET driver_id=? WHERE id=?");
$stmt->bind_param("ii",$data->driver_id,$data->order_id);
$stmt->execute();
echo json_encode(["success"=>true]);
?>