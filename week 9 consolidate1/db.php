<?php
$conn = new mysqli("localhost", "root", "", "bookstore");
session_start();

if ($conn->connect_error) {
    die("Database connection failed");
}
?>
