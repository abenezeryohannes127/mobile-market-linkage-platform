
<?php
include "config.php";
$email=$_POST['email'];
$password=$_POST['password'];

$r=mysqli_query($conn,"SELECT * FROM users WHERE email='$email' AND password='$password'");
if(mysqli_num_rows($r)>0){
 echo json_encode(mysqli_fetch_assoc($r));
}else{
 echo json_encode(["status"=>"error"]);
}
?>
