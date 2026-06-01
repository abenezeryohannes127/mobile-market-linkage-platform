
<?php
include "config.php";
$order_id=$_POST['order_id'];
$status=$_POST['status'];

mysqli_query($conn,"UPDATE orders SET status='$status' WHERE id='$order_id'");
echo json_encode(["status"=>"updated"]);
?>
