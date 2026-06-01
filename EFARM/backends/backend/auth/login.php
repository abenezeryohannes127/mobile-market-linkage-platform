<?php
include "../db.php";
$data=json_decode(file_get_contents("php://input"));
$stmt=$conn->prepare("SELECT * FROM users WHERE email=?");
$stmt->bind_param("s",$data->email);
$stmt->execute();
$res=$stmt->get_result();
if($u=$res->fetch_assoc()){
 if($u['password']==$data->password){
  echo json_encode(["success"=>true,"role"=>$u['role'],"id"=>$u['id']]);
 } else {echo json_encode(["success"=>false]);}
}
?>