<?php
header("Content-Type: application/json");
include "db.php";

$data = json_decode(file_get_contents("php://input"));
$order_id = $data->order_id;
$status = $data->status;

$stmt = $conn->prepare("UPDATE orders SET status=? WHERE id=?");
$stmt->bind_param("si", $status, $order_id);

if($stmt->execute()){
    echo json_encode(["success" => true]);
}else{
    echo json_encode(["success" => false]);
}
?>