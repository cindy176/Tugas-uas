<?php
session_start();
require_once '../includes/db.php';

// Cek login
if (!isset($_SESSION['user'])) {
    header("Location: ../index.php");
    exit;
}

// Cek parameter ID
if (!isset($_GET['id'])) {
    $_SESSION['message'] = "❌ ID kereta tidak ditemukan.";
    header("Location: cari.php");
    exit;
}

$id = intval($_GET['id']); // ini adalah workshop_id

// Ambil data kereta berdasarkan workshop_id
$sql = "SELECT nama_kereta, address, image FROM kereta WHERE workshop_id = '$id'";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $row     = $result->fetch_assoc();
    $kereta  = $row['nama_kereta'];
    $alamat  = $row['address'];
    $gambar  = "../assets/img/" . $row['image'];
} else {
    $_SESSION['message'] = "❌ Data kereta tidak ditemukan.";
    header("Location: cari.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Booking KRL</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../assets/css/booking.css">
  <link rel="stylesheet" href="../assets/css/sytle.css">
</head>
<body>

  <div class="booking-container">
    <div class="booking-card">

      <div class="booking-image">
        <img src="<?= $gambar; ?>" alt="Foto Kereta">
      </div>

      <div class="booking-detail">
        <h2>Konfirmasi Booking</h2>
        <p><strong>Nama Kereta:</strong> <?= htmlspecialchars($kereta); ?></p>
        <p><strong>Alamat:</strong> <?= htmlspecialchars($alamat); ?></p>

        <div class="btn-group">
          <a href="transaksi.php?workshop_id=<?= $id; ?>" class="btn">➡ Ke Halaman Transaksi</a>
          <a href="cari.php" class="btn danger">❌ Batal</a>
        </div>
      </div>

    </div>
  </div>

</body>
</html>



