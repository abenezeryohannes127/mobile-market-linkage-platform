<?php include("../config.php");
if($_SESSION['role']!='admin'){ header("Location: ../login.php"); }

$id=$_GET['id'];
if(isset($_POST['update'])){
$name=$_POST['name']; $email=$_POST['email']; $role=$_POST['role'];
$conn->query("UPDATE users SET name='$name', email='$email', role='$role' WHERE id=$id");
header("Location: users.php");
}
$u=$conn->query("SELECT * FROM users WHERE id=$id")->fetch_assoc();
?>
<form method="POST">
Name:<input name="name" value="<?= $u['name'] ?>"><br>
Email:<input name="email" value="<?= $u['email'] ?>"><br>
Role:
<select name="role">
<option value="buyer" <?= $u['role']=='buyer'?'selected':'' ?>>Buyer</option>
<option value="seller" <?= $u['role']=='seller'?'selected':'' ?>>Seller</option>
<option value="driver" <?= $u['role']=='driver'?'selected':'' ?>>Driver</option>
<option value="admin" <?= $u['role']=='admin'?'selected':'' ?>>Admin</option>
</select><br>
<button name="update">Update</button>
</form>