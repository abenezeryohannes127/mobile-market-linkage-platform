<?php
include "db.php";

$user1 = $_GET['user1'];
$user2 = $_GET['user2'];

$sql = "SELECT * FROM messages 
        WHERE (sender_id='$user1' AND receiver_id='$user2')
        OR (sender_id='$user2' AND receiver_id='$user1')
        ORDER BY created_at ASC";

$result = mysqli_query($conn, $sql);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

echo json_encode($data);
?>