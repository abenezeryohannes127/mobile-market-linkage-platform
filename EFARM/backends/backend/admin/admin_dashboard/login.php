<?php include("config.php"); ?>

<?php
if(isset($_POST['login'])){
    $email = $_POST['email'];
    $password = $_POST['password'];

    $res = $conn->query("SELECT * FROM users WHERE email='$email' AND password='$password'");
    if($res->num_rows > 0){
        $user = $res->fetch_assoc();
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['role'] = $user['role'];

        if($user['role'] == 'admin'){
            header("Location: admin/home.php");
        } else {
            echo "Access denied. Admin only.";
        }
    } else {
        echo "Invalid login";
    }
}
?>

<form method="POST">
    <h2>Admin Login</h2>
    Email: <input type="text" name="email"><br>
    Password: <input type="password" name="password"><br>
    <button name="login">Login</button>
</form>
