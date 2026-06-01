<?php include("../config.php"); 
if($_SESSION['role']!='admin'){ header("Location: ../login.php"); } 
include("layout.php"); ?>

<div style="margin-left:210px; padding:20px;">
<h2>Users</h2>
<table border="1" cellpadding="10">
<tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Action</th></tr>

<?php
$res = $conn->query("SELECT * FROM users");
while($row = $res->fetch_assoc()){
?>
<tr>
<td><?= $row['id'] ?></td>
<td><?= $row['name'] ?></td>
<td><?= $row['email'] ?></td>
<td><?= $row['role'] ?></td>
<td>
<a href="edit_user.php?id=<?= $row['id'] ?>">Edit</a> |
<a href="delete_user.php?id=<?= $row['id'] ?>">Delete</a>
</td>
</tr>
<?php } ?>
</table>
</div>
