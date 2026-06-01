<?php
header("Content-Type: application/json");
include "db.php";

//$data = json_decode(file_get_contents("php://input"));
//$receiver_id = $data->receiver_id;
$receiver_id = $_GET['receiver_id'];

$sql = "SELECT m.*, u.name as sender_name 
        FROM messages m
        JOIN users u ON m.sender_id = u.id
        WHERE m.receiver_id = '$receiver_id'
        ORDER BY m.created_at DESC";

$result = mysqli_query($conn, $sql);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

echo json_encode($data);
?>