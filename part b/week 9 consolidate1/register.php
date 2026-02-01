<?php include "db.php"; ?>

<form method="POST">
    <input type="text" name="username" placeholder="Username" required>
    <input type="email" name="email" placeholder="Email" required>

    <input type="password" name="password"
           placeholder="Password (min 8 chars)"
           minlength="8" required>

    <label>
        <input type="checkbox" required>
        I agree to the Privacy Policy
    </label>

    <button type="submit">Register</button>
</form>

<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $email = $_POST["email"];
    $password = password_hash($_POST["password"], PASSWORD_DEFAULT);

    $sql = "INSERT INTO users (username, email, password)
            VALUES ('$username', '$email', '$password')";

    if ($conn->query($sql)) {
        echo "Registration successful!";
    }
}
?>
