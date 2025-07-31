-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 30, 2025 at 11:58 AM
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
  `nama_kereta` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `kereta`
--

INSERT INTO `kereta` (`id`, `nama_kereta`) VALUES
(1, 'KRL Commuter Line'),
(2, 'KRL Ekspres Serpong'),
(3, 'KRL Bekasi Line');

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
(1, 1, 'Ganti Oli', 'Ganti oli mesin dengan oli terbaik', 100000.00, 30),
(2, 1, 'Tune Up Mesin', 'Pemeriksaan dan perawatan mesin lengkap', 250000.00, 1),
(3, 1, 'Servis Rem', 'Perawatan dan penggantian kampas rem', 150000.00, 45),
(4, 2, 'Servis AC', 'Pembersihan dan perawatan AC mobil', 300000.00, 1),
(5, 2, 'Ganti Ban', 'Penggantian ban depan dan belakang', 400000.00, 1),
(6, 3, 'Cek Kelistrikan', 'Pemeriksaan kelistrikan kendaraan', 120000.00, 45),
(7, 3, 'Spooring Balancing', 'Penyetelan spooring dan balancing roda', 350000.00, 1);

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
(1, 'Ini hanya percobaan', 'percobaan@gmail.com', '$2y$10$n3sanYeM3tSJtQ3EvEvlvu.MibZPLcQDOC/L.xfnMa4UksGci3CeW', NULL, 'customer', '2025-07-15 07:49:07'),
(2, 'Ini hanya percobaan', 'percobaan@example.com', '$2y$10$CATyyjWcWn/E44lJEd69uuaThwwf9V2unAMR2cdlgsoUXQ/NSKIoS', NULL, 'customer', '2025-07-15 08:00:36'),
(3, 'hosea', 'hoseatai@gmail.com', '$2y$10$fuQjwKBPAK.IP7eZyx3he.2C1sQDufIIVQQ4eoiYYLvz5eEnSdHp.', NULL, 'customer', '2025-07-19 09:24:11'),
(4, 'hosetot', 'hoseataiii@hotmail.com', '$2y$10$ZTTxvqrM2DQeoZ8Yb.1Jv.1Gr34KsRa4raZtD/g/FMmtsNrdqYPT.', NULL, 'customer', '2025-07-19 09:24:56'),
(5, 'hoseajsjj', 'hoseajsjj@gmail.com', '$2y$10$4SFCfvpb1Y6QGb/D3rbn.euzci5iuaK5S4QoB0jNjqA4V86mLyzyG', NULL, 'customer', '2025-07-22 16:44:12'),
(6, 'anjingkontol', 'kontol@gmail.com', '$2y$10$R9oiPOg9eGta.HBEBYpB8uFXQELzNKmSzNu3FQZMacxy612LM4Vuq', NULL, 'customer', '2025-07-22 17:32:04'),
(7, 'hoseaaaaaa', 'capenyo@gmail.com', '$2y$10$JJSkPWU9mFwWhypwVIhy7Og1kMIBPsxile78NtsjqmqPU6rYqNsrS', NULL, 'customer', '2025-07-22 17:32:30'),
(8, 'daftar', 'daftar@gmail.com', '$2y$10$CvnwHrtyaoUriVRAJ95i6OuwMyN/wwo7figNMjIYVmfB5crl8ixp6', NULL, 'customer', '2025-07-22 18:28:08'),
(9, 'yusa', 'yusa@gmail.com', '$2y$10$z1VFoWNDrtppnnPO3IuFheRpgafioqBp3HUCFFYugPPQdQCfi4OBa', NULL, 'customer', '2025-07-23 08:34:30'),
(10, 'abyan', 'abyanganteng@gmail.com', '$2y$10$zvS0QXmlQ06yyr2uuH0z0ulprpcurv3OgcKUPwfSoj6jjLfwZKvhC', NULL, 'customer', '2025-07-23 12:36:39'),
(11, 'hosea', 'email1@gmail.com', '$2y$10$XE.9ebaNALT9BcCbWNzZfOV1O9cdDhb2dObYsw/aWEuOAieOlcLwi', NULL, 'customer', '2025-07-30 16:19:25');

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
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `workshop_id` (`workshop_id`),
  ADD KEY `service_id` (`service_id`);

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
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bengkel`
--
ALTER TABLE `bengkel`
  ADD CONSTRAINT `bengkel_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`workshop_id`) REFERENCES `bengkel` (`workshop_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`) ON DELETE CASCADE;

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
