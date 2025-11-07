===== Langkah 1: Buat Proyek Dart =====
1. Buka terminal dan ketik perintah:
- `dart create ecommerce_system`
- cd `ecommerce_system`

===== Langkah 2: Buat Enum Role =====
Enum digunakan untuk menentukan apakah pengguna adalah Admin atau Customer.
`enum Role { Admin, Customer }`

===== Langkah 3: Buat Kelas `Product` =====
Kelas ini menyimpan data produk.
Gunakan `bool inStock` untuk menandai apakah produk tersedia.


===== Langkah 4: Buat Kelas User (dengan Null Safety & Late) =====
Kelas `User` adalah induk untuk `AdminUser` dan `CustomerUser`.

===== Langkah 5: Buat Subclass `AdminUser` dan `CustomerUser` =====
Admin bisa menambah dan menghapus produk, sedangkan Customer hanya bisa melihat.

===== Langkah 6: Tambahkan Exception Handling =====
Kita buat exception khusus untuk menangani produk yang stoknya habis

===== Langkah 7: Buat Katalog Produk (Map) =====
Katalog disimpan dalam bentuk `Map<String, Product>`, di mana key-nya adalah nama produk.

===== Langkah 8: Buat Fungsi Asinkron (fetchProductDetails) =====
Fungsi ini meniru pengambilan data dari server menggunakan `Future.delayed().`

===== Langkah 9: Buat Fungsi `main()` untuk Menjalankan Program =====
Di sini semua bagian digabungkan.

===== Langkah 10: Jalankan Program =====
Ketik di terminal:
`dart run`