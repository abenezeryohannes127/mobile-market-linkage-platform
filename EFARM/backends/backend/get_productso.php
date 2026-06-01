<?php
 include 'db.php';
 $user_id = $_GET['user_id']; 
$r=$conn->query("SELECT * FROM products WHERE user_id ='$user_id'"); 
$d=[]; 
while($row=$r->fetch_assoc())$d[]=$row; 
echo json_encode($d);
 ?>