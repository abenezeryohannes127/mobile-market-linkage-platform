<?php
include 'db.php';

$id = $_POST['id'];
$name = $_POST['name'];
$price = $_POST['price'];

$conn->query("UPDATE products SET name='$name', price='$price' WHERE id='$id'");

echo json_encode(["status"=>"updated"]);
?>
