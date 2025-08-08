-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 07, 2025 at 06:48 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_bo`
--

-- --------------------------------------------------------

--
-- Table structure for table `bengkel`
--

CREATE TABLE `bengkel` (
  `workshop_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `open_time` time DEFAULT NULL,
  `close_time` time DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `image` varchar(255) DEFAULT 'default.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bengkel`
--

INSERT INTO `bengkel` (`workshop_id`, `name`, `address`, `phone`, `owner_id`, `open_time`, `close_time`, `created_at`, `image`) VALUES
(1, 'Bengkel Anjay Motor', 'Jl. Mawar No. 123, Bandung', NULL, NULL, NULL, NULL, '2025-07-20 16:42:50', '4045rlys.png'),
(2, 'Bengkel Motor Jaya', 'Jl. Melati No. 45, Jakarta', NULL, NULL, NULL, NULL, '2025-07-20 16:42:50', 'kucing-montir-5-3eba3d3bd7713d93e893d78a6f57e31c-95c1a53f0696d0c7aad3c9b56b8da200.jpg'),
(3, 'Bengkel Sukses Abadi', 'Jl. Kenanga No. 10, Surabaya', NULL, NULL, NULL, NULL, '2025-07-20 16:42:50', 'potret-kocak-di-bengkel.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `workshop_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `booking_date` date NOT NULL,
  `booking_time` time NOT NULL,
  `status` enum('pending','confirmed','canceled','completed') DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `workshop_id`, `service_id`, `booking_date`, `booking_time`, `status`, `created_at`) VALUES
(1, 12, 1, 8, '2025-07-31', '09:00:00', 'pending', '2025-07-31 12:21:35'),
(2, 12, 1, 8, '2025-07-31', '09:00:00', 'pending', '2025-07-31 12:21:53');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `id` int(11) NOT NULL,
  `id_kereta` int(11) NOT NULL,
  `stasiun_awal` int(11) NOT NULL,
  `stasiun_akhir` int(11) NOT NULL,
  `waktu_berangkat` time NOT NULL,
  `waktu_tiba` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `jadwal`
--

INSERT INTO `jadwal` (`id`, `id_kereta`, `stasiun_awal`, `stasiun_akhir`, `waktu_berangkat`, `waktu_tiba`) VALUES
(1, 1, 1, 3, '06:00:00', '07:10:00'),
(2, 2, 2, 4, '07:30:00', '08:25:00'),
(3, 3, 5, 3, '08:15:00', '09:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `kereta`
--

CREATE TABLE `kereta` (
  `id` int(11) NOT NULL,
  `nama_kereta` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `image` varchar(100) NOT NULL,
  `workshop_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `kereta`
--

INSERT INTO `kereta` (`id`, `nama_kereta`, `address`, `image`, `workshop_id`) VALUES
(1, 'KRL Commuter Line', 'Stasiun Manggarai', '01jsb9xnhm6wts3mvdya9fptrk.png', 1),
(2, 'KRL Ekspres Serpong', 'Stasiun Serpong', 'krl-commuter-line-cli-225-produksi-inka-di-madiun-1745214066082_169.jpeg', 2),
(3, 'KRL Bekasi Line', 'Stasiun Bekasi Timur', 'Untitled.jpg', 3);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `workshop_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(11) NOT NULL,
  `workshop_id` int(11) NOT NULL,
  `service_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `workshop_id`, `service_name`, `description`, `price`, `duration`) VALUES
(8, 1, 'Pemesanan Makanan', 'Pesan makanan langsung dari kursi Anda', 50000.00, 10),
(9, 1, 'Permintaan Selimut', 'Layanan penyediaan selimut untuk kenyamanan penumpang', 0.00, 5),
(10, 1, 'Bantuan Medis', 'Panggil petugas medis untuk penanganan darurat', 0.00, 0),
(11, 1, 'Informasi Jadwal', 'Layanan informasi jadwal stasiun dan kereta', 0.00, 5),
(12, 1, 'Layanan Kebersihan', 'Panggil petugas kebersihan ke kursi Anda', 0.00, 10),
(13, 1, 'Peminjaman Charger', 'Pinjam charger HP untuk sementara', 10000.00, 30),
(14, 1, 'Koneksi Wi-Fi Premium', 'Akses internet kecepatan tinggi', 20000.00, 60);

-- --------------------------------------------------------

--
-- Table structure for table `stasiun`
--

CREATE TABLE `stasiun` (
  `id` int(11) NOT NULL,
  `nama_stasiun` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `stasiun`
--

INSERT INTO `stasiun` (`id`, `nama_stasiun`) VALUES
(1, 'Bogor'),
(2, 'Depok'),
(3, 'Manggarai'),
(4, 'Tanah Abang'),
(5, 'Bekasi');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `nama_layanan` varchar(100) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('admin','customer','owner') DEFAULT 'customer',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `nama`, `email`, `password`, `phone`, `role`, `created_at`) VALUES
(1, 'Admin KRL', 'admin@krl.com', '$2y$10$n3sanYeM3tSJtQ3EvEvlvu.MibZPLcQDOC/L.xfnMa4UksGci3CeW', '081234567890', 'admin', '2025-07-15 07:49:07'),
(2, 'John Doe', 'john@example.com', '$2y$10$CATyyjWcWn/E44lJEd69uuaThwwf9V2unAMR2cdlgsoUXQ/NSKIoS', '081234567891', 'customer', '2025-07-15 08:00:36'),
(3, 'Jane Smith', 'jane@example.com', '$2y$10$fuQjwKBPAK.IP7eZyx3he.2C1sQDufIIVQQ4eoiYYLvz5eEnSdHp.', '081234567892', 'customer', '2025-07-19 09:24:11'),
(4, 'Budi Santoso', 'budi@example.com', '$2y$10$ZTTxvqrM2DQeoZ8Yb.1Jv.1Gr34KsRa4raZtD/g/FMmtsNrdqYPT.', '081234567893', 'customer', '2025-07-19 09:24:56'),
(5, 'Siti Nurhaliza', 'siti@example.com', '$2y$10$4SFCfvpb1Y6QGb/D3rbn.euzci5iuaK5S4QoB0jNjqA4V86mLyzyG', '081234567894', 'customer', '2025-07-22 16:44:12'),
(6, 'Ahmad Rahman', 'ahmad@example.com', '$2y$10$R9oiPOg9eGta.HBEBYpB8uFXQELzNKmSzNu3FQZMacxy612LM4Vuq', '081234567895', 'customer', '2025-07-22 17:32:04'),
(7, 'Dewi Sartika', 'dewi@example.com', '$2y$10$JJSkPWU9mFwWhypwVIhy7Og1kMIBPsxile78NtsjqmqPU6rYqNsrS', '081234567896', 'customer', '2025-07-22 17:32:30'),
(8, 'Rudi Hermawan', 'rudi@example.com', '$2y$10$CvnwHrtyaoUriVRAJ95i6OuwMyN/wwo7figNMjIYVmfB5crl8ixp6', '081234567897', 'customer', '2025-07-22 18:28:08'),
(9, 'Yuni Safitri', 'yuni@example.com', '$2y$10$z1VFoWNDrtppnnPO3IuFheRpgafioqBp3HUCFFYugPPQdQCfi4OBa', '081234567898', 'customer', '2025-07-23 08:34:30'),
(10, 'Abyan Pratama', 'abyan@example.com', '$2y$10$zvS0QXmlQ06yyr2uuH0z0ulprpcurv3OgcKUPwfSoj6jjLfwZKvhC', '081234567899', 'customer', '2025-07-23 12:36:39'),
(11, 'Lina Marlina', 'lina@example.com', '$2y$10$XE.9ebaNALT9BcCbWNzZfOV1O9cdDhb2dObYsw/aWEuOAieOlcLwi', '081234567800', 'customer', '2025-07-30 16:19:25'),
(12, 'Hosea Wijaya', 'hosea@example.com', '$2y$10$IU5sC6zj17SJ.SUYNQXTAuGXKjrpx5n6nAFsvNqFHtrZi1.jm4jwO', '081234567801', 'customer', '2025-07-31 11:13:16'),
(13, 'Demo User', 'demo@krl.com', '$2y$10$2NhxRNnDYqiKPXSsAmJES.NJJFqIUA5Aby5z/VddSYmyTWaRx45M6', '081234567802', 'customer', '2025-08-02 09:09:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bengkel`
--
ALTER TABLE `bengkel`
  ADD PRIMARY KEY (`workshop_id`),
  ADD KEY `owner_id` (`owner_id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`);

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kereta` (`id_kereta`),
  ADD KEY `stasiun_awal` (`stasiun_awal`),
  ADD KEY `stasiun_akhir` (`stasiun_akhir`);

--
-- Indexes for table `kereta`
--
ALTER TABLE `kereta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `workshop_id` (`workshop_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`),
  ADD KEY `workshop_id` (`workshop_id`);

--
-- Indexes for table `stasiun`
--
ALTER TABLE `stasiun`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bengkel`
--
ALTER TABLE `bengkel`
  MODIFY `workshop_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jadwal`
--
ALTER TABLE `jadwal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kereta`
--
ALTER TABLE `kereta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `stasiun`
--
ALTER TABLE `stasiun`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bengkel`
--
ALTER TABLE `bengkel`
  ADD CONSTRAINT `bengkel_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD CONSTRAINT `jadwal_ibfk_1` FOREIGN KEY (`id_kereta`) REFERENCES `kereta` (`id`),
  ADD CONSTRAINT `jadwal_ibfk_2` FOREIGN KEY (`stasiun_awal`) REFERENCES `stasiun` (`id`),
  ADD CONSTRAINT `jadwal_ibfk_3` FOREIGN KEY (`stasiun_akhir`) REFERENCES `stasiun` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`workshop_id`) REFERENCES `bengkel` (`workshop_id`) ON DELETE CASCADE;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`workshop_id`) REFERENCES `bengkel` (`workshop_id`) ON DELETE CASCADE;
COMMIT;

-- =====================================================
-- UPDATE UNTUK FITUR RIWAYAT TRANSAKSI KRL
-- =====================================================

-- 1. Tambah kolom jadwal_id ke tabel bookings
ALTER TABLE `bookings` ADD COLUMN `jadwal_id` INT NULL AFTER `user_id`;

-- 2. Tambah foreign key untuk jadwal_id
ALTER TABLE `bookings` ADD CONSTRAINT `fk_bookings_jadwal` 
FOREIGN KEY (`jadwal_id`) REFERENCES `jadwal`(`id`) ON DELETE CASCADE;

-- 3. Ubah kolom workshop_id agar bisa NULL (untuk kompatibilitas)
ALTER TABLE `bookings` MODIFY COLUMN `workshop_id` INT NULL;

-- 4. Update data services untuk KRL (jika belum ada)
INSERT INTO `services` (`workshop_id`, `service_name`, `description`, `price`, `duration`) VALUES
(1, 'Tiket Ekonomi', 'Tiket KRL kelas ekonomi', 5000.00, 0),
(1, 'Tiket Bisnis', 'Tiket KRL kelas bisnis', 10000.00, 0),
(1, 'Tiket Eksekutif', 'Tiket KRL kelas eksekutif', 15000.00, 0);

-- 5. Hapus data users yang tidak pantas dan reset data
DELETE FROM `users` WHERE `email` LIKE '%percobaan%' OR `email` LIKE '%kontol%' OR `email` LIKE '%capenyo%' OR `nama` LIKE '%anjing%' OR `nama` LIKE '%kontol%';

-- 6. Reset AUTO_INCREMENT untuk users
ALTER TABLE `users` AUTO_INCREMENT = 1;

-- 7. Hapus data bookings yang terkait dengan users yang dihapus
DELETE FROM `bookings` WHERE `user_id` NOT IN (SELECT `user_id` FROM `users`);

-- 8. Reset AUTO_INCREMENT untuk bookings
ALTER TABLE `bookings` AUTO_INCREMENT = 1;

-- Catatan: Setelah menjalankan query ini, sistem akan mendukung:
-- - Booking berdasarkan jadwal KRL (jadwal_id)
-- - Riwayat transaksi yang menampilkan detail jadwal
-- - Pembatalan booking
-- - Data users yang bersih tanpa data percobaan

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
