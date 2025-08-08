-- Update struktur database untuk sistem KRL
-- Jalankan query ini di phpMyAdmin atau MySQL client

-- 1. Tambah kolom jadwal_id ke tabel bookings
ALTER TABLE bookings ADD COLUMN jadwal_id INT NULL AFTER user_id;

-- 2. Tambah foreign key untuk jadwal_id
ALTER TABLE bookings ADD CONSTRAINT fk_bookings_jadwal 
FOREIGN KEY (jadwal_id) REFERENCES jadwal(id) ON DELETE CASCADE;

-- 3. Update data services untuk KRL (jika belum ada)
INSERT INTO services (workshop_id, service_name, description, price, duration) VALUES
(1, 'Tiket Ekonomi', 'Tiket KRL kelas ekonomi', 5000.00, 0),
(1, 'Tiket Bisnis', 'Tiket KRL kelas bisnis', 10000.00, 0),
(1, 'Tiket Eksekutif', 'Tiket KRL kelas eksekutif', 15000.00, 0);

-- 4. Pastikan tabel kereta memiliki data yang benar
-- (Data sudah ada di db_bo.sql)

-- 5. Pastikan tabel jadwal memiliki data yang benar  
-- (Data sudah ada di db_bo.sql)

-- 6. Pastikan tabel stasiun memiliki data yang benar
-- (Data sudah ada di db_bo.sql)

-- Catatan: Setelah menjalankan query ini, sistem akan mendukung:
-- - Booking berdasarkan jadwal KRL (jadwal_id)
-- - Riwayat transaksi yang menampilkan detail jadwal
-- - Pembatalan booking
