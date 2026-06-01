
<?php
header("Content-Type: application/json");
include "config.php";
$data = json_decode(file_get_contents("php://input"));
//$name = $data->name;
$name=$data->name;
$email=$data->email;
$password=$data->password;
$role=$data->role;

$q="INSERT INTO users(name,email,password,role) VALUES('$name','$email','$password','$role')";
if(mysqli_query($conn,$q)){
 echo json_encode(["status"=>"success"]);
}else{
 echo json_encode(["status"=>"error"]);
}
?>
