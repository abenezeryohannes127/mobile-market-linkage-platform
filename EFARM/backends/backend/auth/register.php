<?php
include "../db.php";
$data=json_decode(file_get_contents("php://input"));
$stmt=$conn->prepare("INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)");
$stmt->bind_param("ssss",$data->name,$data->email,$data->password,$data->role);
$stmt->execute();
echo json_encode(["success"=>true]);
?>