<?php include("../config.php");
$order_id = $_POST['order_id'];
$driver_id = $_POST['driver_id'];

$conn->query("UPDATE orders SET driver_id='$driver_id', status='on the way' WHERE id='$order_id'");
header("Location: orders.php");
?>