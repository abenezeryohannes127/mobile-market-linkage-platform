
<?php
include "config.php";
$driver_id=$_POST['driver_id'];

$r=mysqli_query($conn,"SELECT * FROM orders WHERE driver_id='$driver_id'");
$data=[];
while($row=mysqli_fetch_assoc($r)){
$data[]=$row;
}
echo json_encode($data);
?>
