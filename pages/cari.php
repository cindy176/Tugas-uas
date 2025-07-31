<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
require_once '../includes/db.php';

if (!isset($_SESSION['user'])) {
    header('Location: ../index.php');
    exit();
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Cari Jadwal KRL</title>
  <link rel="stylesheet" href="../assets/css/style.css">
  <link rel="stylesheet" href="../assets/css/cari.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    body.custom-bg {
      background: url('../assets/img/01jsb9xnhm6wts3mvdya9fptrk.png') no-repeat center center fixed;
      background-size: cover;
    }
  </style>
</head>
<body class="custom-bg">
  <!-- MENU SLIDE -->
  <button class="menu-toggle" onclick="toggleMenu()">⋮</button>
  <div class="slide-menu" id="slideMenu">
    <a href="cari.php">🚉 Home</a>
    <a href="../pages/logout.php">🚪 Logout</a>
  </div>
  <div class="overlay" onclick="toggleMenu()" id="overlay"></div>

  <!-- HEADER -->
  <header class="header">
    <h1>🚆 Cari Jadwal KRL</h1>
    <p>Temukan jadwal KRL terbaik untuk perjalananmu</p>
  </header>

  <!-- GRID CARD -->
  <div class="grid-container">
    <?php
    $query = "SELECT j.id AS jadwal_id, k.nama_kereta, s1.nama_stasiun AS asal, s2.nama_stasiun AS tujuan, 
                     j.waktu_berangkat, j.waktu_tiba, k.workshop_id
              FROM jadwal j
              JOIN kereta k ON j.id_kereta = k.id
              JOIN stasiun s1 ON j.stasiun_awal = s1.id
              JOIN stasiun s2 ON j.stasiun_akhir = s2.id";
    $result = mysqli_query($conn, $query);

    if ($result && mysqli_num_rows($result) > 0) {
        while ($row = mysqli_fetch_assoc($result)) {
            echo '
            <div class="card">
              <img src="../assets/img/Untitled.jpg" alt="KRL" class="bengkel-img">
              <div class="card-content">
                <h3>🚆 '.htmlspecialchars($row['nama_kereta']).'</h3>
                <p><i class="fa fa-map-marker-alt"></i> '.htmlspecialchars($row['asal']).' → '.htmlspecialchars($row['tujuan']).'</p>
                <p><i class="fa fa-clock"></i> '.htmlspecialchars($row['waktu_berangkat']).' - '.htmlspecialchars($row['waktu_tiba']).'</p>
                <div class="rating">⏱️ Tepat waktu</div>
                <div class="tags">
                  <span class="tag">🚉 KRL</span>
                  <span class="tag">💺 Ekonomi</span>
                  <span class="tag">🕒 Setiap Hari</span>
                </div>
                <a href="booking.php?id='.$row['workshop_id'].'&jadwal='.$row['jadwal_id'].'" class="btn-book">🎟️ Pesan Tiket</a>
              </div>
              <button class="btn-favorite"><i class="far fa-heart"></i></button>
            </div>
            ';
        }
    } else {
        echo '<p>Tidak ada jadwal KRL tersedia.</p>';
    }
    ?>
  </div>

  <script src="../assets/js/main.js"></script>
</body>
</html>
