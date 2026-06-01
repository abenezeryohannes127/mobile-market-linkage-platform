<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="index.php">Dashboard</a></li>
            <li><a href="orders.php">Orders</a></li>
            <li><a href="users.php">Users</a></li>
           
            <li><a href="#">Logout</a></li>

        </ul>
    </div>
    <div class="main-content">
        <h1>Welcome, Admin</h1>
        <p><center><h2>Product's</h2></center>
<table>
<div class="button_add">Add</div> 
<tr>

<th>ID </th>
<th>Name </th>
<th>Description </th>
<th>price </th>
<th>Stock </th>
<th>Image </th>
<th>Category </th>
<th>Action </th>
</tr>
<tr>
<td>1</td>
<td>Lorem ipsum dolor </td>
<td>Lorem ipsum dolor sit amet</td>
<td>200$</td>
<td>2000</td>
<td>image1</td>
<td>catagory1</td>
<td ><a href="#" class="button_update">Update</a><a href="#" class="button_delete">Delete</a></td>
</tr>
<tr>
<td>2</td>
<td>Lorem ipsum </td>
<td>Lorem ipsum dolor sit amet</td>
<td>300$</td>
<td>2000</td>
<td>image1</td>
<td>catagory1</td>
<td ><a href="#" class="button_update">Update</a><a href="#" class="button_delete">Delete</a></td>
</tr><tr>
<td>3</td>
<td>Lorem ipsum </td>
<td>Lorem ipsum dolor sit amet</td>
<td>400$</td>
<td>2000</td>
<td>image1</td>
<td>catagory1</td>
<td ><a href="#" class="button_update">Update</a><a href="#" class="button_delete">Delete</a></td>
</tr>
<tr>
<td>4</td>
<td>Lorem ipsum </td>
<td>Lorem ipsum dolor sit amet</td>
<td>500$</td>
<td>2000</td>
<td>image1</td>
<td>catagory1</td>
<td ><a href="#" class="button_update">Update</a><a href="#" class="button_delete">Delete</a></td>
</tr></table>
</p>
    </div>
    <script src="script.js"></script>
</body>
</html>
