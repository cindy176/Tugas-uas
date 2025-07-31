<?php
require_once '../includes/db.php';

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $nama = $_POST['nama'];
    $email = $_POST['email'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

    // Validasi format email
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = "Email tidak valid!";
    } else {
        // Cek apakah email sudah terdaftar
        $stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $error = "Email sudah terdaftar!";
        } else {
            // Insert user baru
            $stmt = $conn->prepare("INSERT INTO users (nama, email, password) VALUES (?, ?, ?)");
            $stmt->bind_param("sss", $nama, $email, $password);
            
            if ($stmt->execute()) {
                echo "<script>alert('Pendaftaran berhasil! Silakan login.'); window.location='../index.php';</script>";
            } else {
                $error = "Gagal daftar: " . $stmt->error;
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Daftar Akun</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/daftar.css">
</head>
<body>
<div class="form-container">
    <h2>Daftar Akun</h2>
    <?php if (!empty($error)): ?>
        <div class="error"><?= $error; ?></div>
    <?php endif; ?>
    <form method="POST">
        <input type="text" name="nama" placeholder="Nama Lengkap" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Daftar</button>
        <p>Sudah punya akun? <a href="../index.php">Login di sini</a></p>
    </form>
</div>
</body>
</html>

