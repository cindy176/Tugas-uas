<?php
session_start();
require_once '../includes/db.php';

// Aktifkan error reporting untuk debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// ✅ Pastikan user sudah login
if (!isset($_SESSION['user']) || !isset($_SESSION['user']['user_id'])) {
    header('Location: ../index.php');
    exit();
}

// ✅ Ambil jadwal_id dari URL
$jadwal_id = isset($_GET['jadwal']) ? intval($_GET['jadwal']) : 0;
if ($jadwal_id <= 0) {
    header("Location: cari.php");
    exit;
}

// ✅ Ambil detail jadwal berdasarkan jadwal_id
$queryJadwal = "SELECT j.id, k.nama_kereta, s1.nama_stasiun AS stasiun_asal, s2.nama_stasiun AS stasiun_tujuan,
                       j.waktu_berangkat, j.waktu_tiba
                FROM jadwal j
                JOIN kereta k ON j.id_kereta = k.id
                JOIN stasiun s1 ON j.stasiun_awal = s1.id
                JOIN stasiun s2 ON j.stasiun_akhir = s2.id
                WHERE j.id = $jadwal_id";
$resultJadwal = mysqli_query($conn, $queryJadwal);
$jadwal = mysqli_fetch_assoc($resultJadwal);

// Jika jadwal tidak ditemukan
if (!$jadwal) {
    echo "<h2 style='color:red;'>Jadwal tidak ditemukan. <a href='cari.php'>Kembali</a></h2>";
    exit;
}

// ✅ Ambil semua layanan yang tersedia (untuk KRL)
$queryService = "SELECT service_id, service_name, price FROM services WHERE category = 'KRL'";
$resultService = mysqli_query($conn, $queryService);
$services = [];
if ($resultService && mysqli_num_rows($resultService) > 0) {
    while ($row = mysqli_fetch_assoc($resultService)) {
        $services[] = $row;
    }
}

// ✅ Jika form booking disubmit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $service_id     = intval($_POST['service_id']);
    $booking_date   = $_POST['booking_date'];
    $booking_time   = $_POST['booking_time'];
    $customer_name  = mysqli_real_escape_string($conn, $_POST['customer_name']);
    $customer_phone = mysqli_real_escape_string($conn, $_POST['customer_phone']);

    // ✅ Ambil user_id dari session
    if (isset($_SESSION['user']['user_id'])) {
        $user_id = $_SESSION['user']['user_id'];
    } else {
        // Jika session hanya email → cari user_id dari tabel users
        $email = mysqli_real_escape_string($conn, $_SESSION['user']);
        $res = $conn->query("SELECT user_id FROM users WHERE email='$email' LIMIT 1");
        if ($res && $res->num_rows > 0) {
            $user_id = $res->fetch_assoc()['user_id'];
        } else {
            die("❌ User tidak ditemukan di tabel users!");
        }
    }

    // ✅ Pastikan semua data booking lengkap sebelum insert
    if ($jadwal_id && $service_id && $booking_date && $booking_time) {
        // Insert booking dengan jadwal_id
         $stmt = $conn->prepare("
            INSERT INTO bookings (user_id, jadwal_id, service_id, booking_date, booking_time, status)
            VALUES (?, ?, ?, ?, ?, 'pending')
        ");
        $stmt->bind_param("iiiss", $user_id, $jadwal_id, $service_id, $booking_date, $booking_time);
        $stmt->execute();

       // ✅ Setelah sukses booking → tampilkan alert dan redirect ke cari.php
        echo "<script>alert('Booking berhasil!'); window.location.href = 'cari.php';</script>";
        exit();
    } else {
        echo "<p style='color:red;'>❌ Data booking tidak lengkap!</p>";
    }
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Form Booking</title>
  <link rel="stylesheet" href="../assets/css/main.css">
  <link rel="stylesheet" href="../assets/css/transaksi.css">
</head>
<body>
  <div class="form-container">
    <h1>Booking Tiket <?= htmlspecialchars($jadwal['nama_kereta']); ?></h1>
    <p>📍 <?= htmlspecialchars($jadwal['stasiun_asal']); ?> → <?= htmlspecialchars($jadwal['stasiun_tujuan']); ?></p>
    <p>🕒 <?= htmlspecialchars($jadwal['waktu_berangkat']); ?> - <?= htmlspecialchars($jadwal['waktu_tiba']); ?></p>

    <form action="" method="POST" class="booking-form">
      <input type="hidden" name="jadwal_id" value="<?= $jadwal_id; ?>">

      <div class="form-group">
        <label for="service_id">Pilih Layanan</label>
        <select name="service_id" id="service_id" required>
          <option value="">-- Pilih Layanan --</option>
          <?php if (!empty($services)): ?>
            <?php foreach ($services as $s): ?>
              <option value="<?= $s['service_id']; ?>">
                <?= htmlspecialchars($s['service_name']); ?> - Rp <?= number_format($s['price'], 0, ',', '.'); ?>
              </option>
            <?php endforeach; ?>
          <?php else: ?>
            <option value="" disabled>Tidak ada layanan tersedia</option>
          <?php endif; ?>
        </select>
      </div>

      <div class="form-group">
        <label for="booking_date">Tanggal Booking</label>
        <input type="date" name="booking_date" id="booking_date" required min="<?= date('Y-m-d'); ?>">
      </div>

      <div class="form-group">
        <label for="booking_time">Waktu Booking</label>
        <input type="time" name="booking_time" id="booking_time" required min="08:00" max="17:00">
      </div>

      <div class="form-group">
        <label for="customer_name">Nama Pelanggan</label>
        <input type="text" name="customer_name" id="customer_name" required>
      </div>

      <div class="form-group">
        <label for="customer_phone">Nomor Telepon</label>
        <input type="tel" name="customer_phone" id="customer_phone" required>
      </div>

      <button type="submit" class="btn-submit">✅ Konfirmasi Booking</button>
      <button onclick="location.href='cari.php'" class="btn-submit">📋 Kembali ke Cari Kereta</button>
    </form>
  </div>

  <script>
    document.addEventListener("DOMContentLoaded", function(){
      document.getElementById('booking_date').valueAsDate = new Date();
    });
  </script>
</body>
</html>

