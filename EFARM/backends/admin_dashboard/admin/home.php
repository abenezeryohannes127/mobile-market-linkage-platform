<?php include("../config.php"); 
if($_SESSION['role']!='admin'){ header("Location: ../login.php"); } 
include("layout.php"); ?>

<div style="margin-left:210px; padding:20px;">
<h1>Welcome Admin Dashboard</h1>
</div>
