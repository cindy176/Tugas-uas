# Fitur Riwayat Transaksi KRL

## Deskripsi
Fitur ini memungkinkan pengguna untuk melihat semua jadwal KRL yang sudah dipesan dan mengelola booking mereka.

## Fitur yang Tersedia

### 1. Halaman Riwayat Transaksi (`pages/riwayat.php`)
- Menampilkan semua booking KRL yang sudah dibuat
- Informasi detail: nama kereta, rute, waktu, harga, status
- Status booking: pending, confirmed, canceled, completed
- Tombol aksi sesuai status booking

### 2. Pembatalan Booking (`pages/cancel_booking.php`)
- Hanya booking dengan status "pending" yang bisa dibatalkan
- Menggunakan AJAX untuk proses pembatalan tanpa reload halaman
- Validasi keamanan: hanya pemilik booking yang bisa membatalkan

### 3. Menu Navigasi
- Menu "Riwayat" ditambahkan ke slide menu
- Akses mudah dari halaman utama

## Struktur Database

### Tabel `bookings` (Updated)
```sql
ALTER TABLE bookings ADD COLUMN jadwal_id INT NULL AFTER user_id;
ALTER TABLE bookings ADD CONSTRAINT fk_bookings_jadwal 
FOREIGN KEY (jadwal_id) REFERENCES jadwal(id) ON DELETE CASCADE;
```

### Data Services untuk KRL
```sql
INSERT INTO services (workshop_id, service_name, description, price, duration) VALUES
(1, 'Tiket Ekonomi', 'Tiket KRL kelas ekonomi', 5000.00, 0),
(1, 'Tiket Bisnis', 'Tiket KRL kelas bisnis', 10000.00, 0),
(1, 'Tiket Eksekutif', 'Tiket KRL kelas eksekutif', 15000.00, 0);
```

## File yang Ditambahkan/Dimodifikasi

### File Baru:
1. `pages/riwayat.php` - Halaman riwayat transaksi
2. `assets/css/riwayat.css` - Styling halaman riwayat
3. `pages/cancel_booking.php` - Handler pembatalan booking
4. `update_database.sql` - Query update database

### File yang Dimodifikasi:
1. `pages/cari.php` - Menambahkan menu riwayat
2. `pages/transaksi.php` - Menggunakan jadwal_id alih-alih workshop_id

## Cara Penggunaan

### 1. Melihat Riwayat Transaksi
1. Login ke sistem
2. Klik menu hamburger (⋮) di pojok kiri atas
3. Pilih "📋 Riwayat"
4. Lihat semua booking yang sudah dibuat

### 2. Membatalkan Booking
1. Buka halaman riwayat
2. Cari booking dengan status "⏳ Menunggu"
3. Klik tombol "❌ Batalkan"
4. Konfirmasi pembatalan
5. Status akan berubah menjadi "❌ Dibatalkan"

### 3. Melihat Detail Booking
- Setiap card riwayat menampilkan:
  - Nama kereta dan ID booking
  - Rute (stasiun asal → tujuan)
  - Waktu keberangkatan dan kedatangan
  - Tanggal booking
  - Jenis tiket dan harga
  - Status booking

## Status Booking

- **⏳ Menunggu** - Booking baru dibuat, menunggu konfirmasi
- **✅ Dikonfirmasi** - Booking sudah dikonfirmasi, bisa lihat tiket
- **❌ Dibatalkan** - Booking dibatalkan oleh user
- **✅ Selesai** - Perjalanan sudah selesai

## Keamanan

- Validasi session untuk memastikan user sudah login
- Validasi kepemilikan booking (user hanya bisa melihat/membatalkan booking miliknya)
- Prepared statements untuk mencegah SQL injection
- CSRF protection melalui validasi session

## Responsive Design

- Halaman responsive untuk desktop, tablet, dan mobile
- Menu slide yang adaptif
- Card layout yang fleksibel
- Font dan spacing yang optimal untuk berbagai ukuran layar

## Troubleshooting

### Jika riwayat kosong:
1. Pastikan sudah ada booking yang dibuat
2. Cek apakah user_id di session sesuai dengan data booking
3. Pastikan struktur database sudah diupdate

### Jika pembatalan gagal:
1. Pastikan status booking masih "pending"
2. Cek apakah booking milik user yang sedang login
3. Pastikan file `cancel_booking.php` bisa diakses

### Jika menu riwayat tidak muncul:
1. Pastikan file `riwayat.php` sudah dibuat
2. Cek apakah CSS dan JavaScript sudah dimuat dengan benar
3. Pastikan tidak ada error di console browser

