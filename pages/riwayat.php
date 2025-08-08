<?php
// Aktifkan error reporting untuk debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
require_once '../includes/db.php';

// Cek login
if (!isset($_SESSION['user'])) {
    header("Location: ../index.php");
    exit;
}

$user_id = $_SESSION['user']['user_id'];

// Ambil data riwayat booking user
$query = "SELECT b.booking_id, b.booking_date, b.booking_time, b.status,
                 k.nama_kereta, s1.nama_stasiun AS stasiun_asal, s2.nama_stasiun AS stasiun_tujuan,
                 j.waktu_berangkat, j.waktu_tiba, sr.service_name, sr.price
          FROM bookings b
          LEFT JOIN jadwal j ON b.jadwal_id = j.id
          LEFT JOIN kereta k ON j.id_kereta = k.id
          LEFT JOIN stasiun s1 ON j.stasiun_awal = s1.id
          LEFT JOIN stasiun s2 ON j.stasiun_akhir = s2.id
          JOIN services sr ON b.service_id = sr.service_id
          WHERE b.user_id = ?
          ORDER BY b.booking_date DESC, b.booking_time DESC";

$stmt = $conn->prepare($query);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Riwayat Transaksi KRL</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/riwayat.css">
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
        <a href="riwayat.php" class="active">📋 Riwayat</a>
        <a href="logout.php">🚪 Logout</a>
    </div>
    <div class="overlay" onclick="toggleMenu()" id="overlay"></div>

    <!-- HEADER -->
    <header class="header">
        <div class="header-content">
            <div class="header-left">
                <a href="cari.php" class="btn-back">← Kembali ke Cari Kereta</a>
            </div>
            <div class="header-center">
                <h1>📋 Riwayat Transaksi KRL</h1>
                <p>Lihat semua jadwal KRL yang sudah Anda pesan</p>
            </div>
        </div>
    </header>

    <!-- CONTAINER RIWAYAT -->
    <div class="riwayat-container">
        <?php if ($result && $result->num_rows > 0): ?>
            <?php while ($row = $result->fetch_assoc()): ?>
                <div class="riwayat-card">
                    <div class="riwayat-header">
                        <div class="kereta-info">
                            <h3>🚆 <?= htmlspecialchars($row['nama_kereta']) ?></h3>
                            <span class="booking-id">ID: #<?= $row['booking_id'] ?></span>
                        </div>
                        <div class="status-badge status-<?= $row['status'] ?>">
                            <?php
                            $statusText = [
                                'pending' => '⏳ Menunggu',
                                'confirmed' => '✅ Dikonfirmasi',
                                'canceled' => '❌ Dibatalkan',
                                'completed' => '✅ Selesai'
                            ];
                            echo $statusText[$row['status']] ?? $row['status'];
                            ?>
                        </div>
                    </div>

                    <div class="riwayat-details">
                        <div class="detail-row">
                            <div class="detail-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span><?= $row['stasiun_asal'] ? htmlspecialchars($row['stasiun_asal']) . ' → ' . htmlspecialchars($row['stasiun_tujuan']) : 'Rute tidak tersedia' ?></span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-clock"></i>
                                <span><?= $row['waktu_berangkat'] ? htmlspecialchars($row['waktu_berangkat']) . ' - ' . htmlspecialchars($row['waktu_tiba']) : 'Waktu tidak tersedia' ?></span>
                            </div>
                        </div>

                        <div class="detail-row">
                            <div class="detail-item">
                                <i class="fas fa-calendar"></i>
                                <span>Tanggal: <?= date('d/m/Y', strtotime($row['booking_date'])) ?></span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-ticket-alt"></i>
                                <span><?= htmlspecialchars($row['service_name']) ?></span>
                            </div>
                        </div>

                        <div class="detail-row">
                            <div class="detail-item">
                                <i class="fas fa-money-bill-wave"></i>
                                <span>Rp <?= number_format($row['price'], 0, ',', '.') ?></span>
                            </div>
                        </div>
                    </div>

                    <div class="riwayat-actions">
                        <?php if ($row['status'] === 'pending'): ?>
                            <button class="btn-cancel" onclick="cancelBooking(<?= $row['booking_id'] ?>)">
                                ❌ Batalkan
                            </button>
                        <?php endif; ?>
                        
                        <?php if ($row['status'] === 'confirmed'): ?>
                            <button class="btn-view" onclick="viewTicket(<?= $row['booking_id'] ?>)">
                                🎫 Lihat Tiket
                            </button>
                        <?php endif; ?>
                    </div>
                </div>
            <?php endwhile; ?>
        <?php else: ?>
            <div class="empty-state">
                <div class="empty-icon">📋</div>
                <h3>Belum Ada Transaksi</h3>
                <p>Anda belum memiliki riwayat transaksi KRL. Mulai pesan tiket sekarang!</p>
                <a href="cari.php" class="btn-primary">🚆 Pesan Tiket</a>
            </div>
        <?php endif; ?>
    </div>

    <script src="../assets/js/main.js"></script>
    <script>
        function cancelBooking(bookingId) {
            if (confirm('Apakah Anda yakin ingin membatalkan booking ini?')) {
                // Kirim request AJAX untuk pembatalan
                fetch('cancel_booking.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'booking_id=' + bookingId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        location.reload(); // Reload halaman untuk update status
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Terjadi kesalahan saat membatalkan booking');
                });
            }
        }

        function viewTicket(bookingId) {
            // Implementasi melihat tiket
            alert('Fitur lihat tiket akan segera tersedia!');
        }
    </script>
</body>
</html>
