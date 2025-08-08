<?php
session_start();
require_once '../includes/db.php';

// Cek login
if (!isset($_SESSION['user'])) {
    header("Location: ../index.php");
    exit;
}

$user_id = $_SESSION['user']['user_id'];

// Cek apakah ada request POST untuk pembatalan
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['booking_id'])) {
    $booking_id = intval($_POST['booking_id']);
    
    // Pastikan booking milik user yang sedang login
    $stmt = $conn->prepare("SELECT status FROM bookings WHERE booking_id = ? AND user_id = ?");
    $stmt->bind_param("ii", $booking_id, $user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        $booking = $result->fetch_assoc();
        
        // Hanya bisa batalkan jika status masih pending
        if ($booking['status'] === 'pending') {
            $update_stmt = $conn->prepare("UPDATE bookings SET status = 'canceled' WHERE booking_id = ? AND user_id = ?");
            $update_stmt->bind_param("ii", $booking_id, $user_id);
            
            if ($update_stmt->execute()) {
                echo json_encode(['success' => true, 'message' => 'Booking berhasil dibatalkan']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Gagal membatalkan booking']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Booking tidak dapat dibatalkan']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Booking tidak ditemukan']);
    }
    exit;
}

// Jika bukan POST request, redirect ke halaman riwayat
header("Location: riwayat.php");
exit;
?>
