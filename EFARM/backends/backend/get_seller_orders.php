<?php
header("Content-Type: application/json");
include "db.php";

$data = json_decode(file_get_contents("php://input"));
$product_id = $data->product_id;

$stmt = $conn->prepare("SELECT o.id, o.product_id, o.buyer_id, o.driver_id, o.status, p.name AS product_name 
                        FROM orders o 
                        JOIN products p ON o.product_id = p.id 
                        WHERE o.product_id=?");
$stmt->bind_param("i", $product_id);
$stmt->execute();
$result = $stmt->get_result();

$orders = [];
while($row = $result->fetch_assoc()){
    $orders[] = $row;
}

echo json_encode($orders);
?>