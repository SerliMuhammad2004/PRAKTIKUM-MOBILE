void main() {
  print("=== Aplikasi Pemantau Jadwal Minum Obat Harian ===\n");

  // --- Data Pengguna ---
  String? namaPengguna = "Serly";
  print("Hai, ${namaPengguna ?? 'Pengguna'}! Berikut jadwal obat kamu hari ini:\n");

  // --- Daftar Obat Hari Ini ---
  final List<Map<String, dynamic>> daftarObat = [
    {"nama": "Paracetamol", "dosis": 500.0, "sudahDiminum": true},
    {"nama": "Amoxicillin", "dosis": 250.0, "sudahDiminum": false},
  ];

  // --- Tampilkan Daftar Obat ---
  print("Daftar Obat Hari Ini:");
  for (var i = 0; i < daftarObat.length; i++) {
    var o = daftarObat[i];
    String status = o["sudahDiminum"] ? "✅ Sudah diminum" : "⏰ Belum diminum";
    print("${i + 1}. ${o["nama"]} (${o["dosis"]} mg) → $status");
  }

  // --- Hitung Jumlah Obat Diminum ---
  int totalObat = daftarObat.length;
  int jumlahDiminum = daftarObat.where((o) => o["sudahDiminum"] == true).length;

  // --- Tampilkan Total ---
  print("\nTotal obat diminum: $jumlahDiminum/$totalObat");

  try {
    double persenDiminum = (jumlahDiminum / totalObat) * 100;
    print("Persentase kepatuhan minum obat: ${persenDiminum.toStringAsFixed(1)}%");
  } catch (e) {
    print("Terjadi kesalahan saat menghitung persentase: $e");
  }

  // --- Pesan Motivasi ---
  if (jumlahDiminum == totalObat) {
    print("Semua obat sudah diminum!");
  } else {
    int sisa = totalObat - jumlahDiminum;
    print("Masih ada $sisa obat yang belum diminum. Jangan lupa ya, ${namaPengguna ?? ''} :)");
  }


  const String pesanPenutup = "Tetap semangat menjaga kesehatan !!";
  print("\n$pesanPenutup");
}
