<?php
header("Content-Type: application/json");
include 'db.php';
 $p=$_POST['product_id'];
  $b=$_POST['buyer_id'];
   $conn->query("INSERT INTO orders(product_id,buyer_id,status) VALUES('$p','$b','pending')");
   echo json_encode(['success'=>true]); ?>