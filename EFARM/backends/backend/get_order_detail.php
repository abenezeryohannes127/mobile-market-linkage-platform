<?php
header("Content-Type: application/json");
include "db2.php";

$data = json_decode(file_get_contents("php://input"));
$order_id = $data->order_id;

$stmt = $conn->prepare("
    SELECT o.id AS order_id, o.buyer_id, o.driver_id, o.status,
           p.id AS product_id, p.name AS product_name, p.price, p.image
    FROM orders o
    JOIN products p ON o.product_id = p.id
    WHERE o.id = ?
");
$stmt->bind_param("i", $order_id);
$stmt->execute();
$result = $stmt->get_result();

$order_detail = $result->fetch_assoc();
echo json_encode($order_detail);
?>