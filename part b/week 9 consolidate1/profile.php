<?php
include "db.php";

$id = $_SESSION["user_id"];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST["email"];
    $conn->query("UPDATE users SET email='$email' WHERE id=$id");
    echo "Email updated successfully!";
}
?>

<form method="POST">
    <input type="email" name="email" placeholder="New Email" required>
    <button type="submit">Save</button>
</form>

<a href="reset_password.php">Forgot Password?</a><br>
<a href="deactivate.php">Deactivate Account</a>
