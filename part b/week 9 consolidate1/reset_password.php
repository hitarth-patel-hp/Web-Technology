<?php
include "db.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $newPass = password_hash($_POST["password"], PASSWORD_DEFAULT);
    $id = $_SESSION["user_id"];

    $conn->query("UPDATE users SET password='$newPass' WHERE id=$id");
    echo "Password updated!";
}
?>

<form method="POST">
    <input type="password" name="password" required>
    <button type="submit">Reset Password</button>
</form>
