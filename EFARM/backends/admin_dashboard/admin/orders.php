<?php include("../config.php"); 
if($_SESSION['role']!='admin'){ header("Location: ../login.php"); } 
include("layout.php"); ?>

<div style="margin-left:210px; padding:20px;">
<h2>Orders</h2>
<table border="1" cellpadding="10">
<tr><th>ID</th><th>Buyer</th><th>Status</th><th>Assign Driver</th></tr>

<?php
$orders = $conn->query("SELECT * FROM orders");
while($o = $orders->fetch_assoc()){
?>
<tr>
<td><?= $o['id'] ?></td>
<td><?= $o['buyer_id'] ?></td>
<td><?= $o['status'] ?></td>
<td>
<form method="POST" action="assign_driver.php">
<input type="hidden" name="order_id" value="<?= $o['id'] ?>">
<select name="driver_id">
<option>Select</option>
<?php
$drivers = $conn->query("SELECT * FROM users WHERE role='driver'");
while($d = $drivers->fetch_assoc()){
?>
<option value="<?= $d['id'] ?>"><?= $d['name'] ?></option>
<?php } ?>
</select>
<button>Assign</button>
</form>
</td>
</tr>
<?php } ?>
</table>
</div>
