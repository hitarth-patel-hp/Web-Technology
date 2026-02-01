<?php
include "db.php";

if (!isset($_SESSION["user_id"])) {
    die("Please log in to continue.");
}
?>

<h2>Welcome to the Bookstore</h2>

<p>You can now review books.</p>
<a href="profile.php">Profile</a> |
<a href="logout.php">Logout</a>
