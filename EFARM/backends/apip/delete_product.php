<?php
include 'db.php';

$id = $_POST['id'];

$conn->query("DELETE FROM products WHERE id='$id'");

echo json_encode(["status"=>"deleted"]);
?>
