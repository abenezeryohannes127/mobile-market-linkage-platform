
<?php
include "config.php";
$name=$_POST['name'];
$price=$_POST['price'];
$seller_id=$_POST['seller_id'];

$q="INSERT INTO products(name,price,seller_id) VALUES('$name','$price','$seller_id')";
mysqli_query($conn,$q);
echo json_encode(["status"=>"success"]);
?>
