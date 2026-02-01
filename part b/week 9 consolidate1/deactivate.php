<?php
include "db.php";

$id = $_SESSION["user_id"];
$conn->query("UPDATE users SET active=0 WHERE id=$id");

session_destroy();
echo "Account deactivated successfully.";
?>
