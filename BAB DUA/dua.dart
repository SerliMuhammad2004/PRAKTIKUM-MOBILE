
// ========== ENUM ==========
enum KategoriProduk { DataManagement, NetworkAutomation }

enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

// ========== CLASS PRODUK DIGITAL ==========
class ProdukDigital {
  String namaProduk;
  double harga;
  KategoriProduk kategori;
  int jumlahTerjual;

  ProdukDigital(
    this.namaProduk,
    this.harga,
    this.kategori,
    this.jumlahTerjual,
  ); //Positional Argumen

  // ========== METHOD TERAPKAN DISKON ==========
  void terapkanDiskon() {
    if (kategori == KategoriProduk.NetworkAutomation && jumlahTerjual > 50) {
      double hargaDiskon = harga * 0.85;
      if (hargaDiskon < 200000) {
        harga = 200000; // harga akhir minimal
      } else {
        harga = hargaDiskon;
      }
    }
  }

  @override
  String toString() =>
      '$namaProduk (${kategori.name}) - Rp${harga.toStringAsFixed(0)}';
}

// ========== ABSTRACT CLASS KARYAWAN ==========
abstract class Karyawan {
  String nama;
  int umur;
  String peran;
  bool aktif = true;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void bekerja();
}

// ========== SUBCLASS KARYAWAN TETAP DAN KONTRAK ==========
class KaryawanTetap extends Karyawan {
  KaryawanTetap(
    String nama, {
    required int umur,
    required String peran,
  }) //penerapan  arguments nama = positional, umur & peran = named argument
  : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print('$nama bekerja penuh waktu sebagai $peran.');
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, {required int umur, required String peran})
    : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print('$nama bekerja sesuai proyek sebagai $peran.');
  }
}

// ========== MIXIN KINERJA ==========
mixin Kinerja {
  int produktivitas = 80;
  DateTime? terakhirUpdate;

  void updateProduktivitas(int nilaiBaru) {
    if (terakhirUpdate == null ||
        DateTime.now().difference(terakhirUpdate!).inDays >= 30) {
      if (nilaiBaru >= 0 && nilaiBaru <= 100) {
        produktivitas = nilaiBaru;
        terakhirUpdate = DateTime.now();
        print('Produktivitas diperbarui ke $produktivitas%');
      } else {
        throw Exception('Nilai produktivitas harus antara 0–100.');
      }
    } else {
      throw Exception('Produktivitas hanya bisa diperbarui setiap 30 hari.');
    }
  }
}

// ========== CLASS KARYAWAN DENGAN KINERJA ==========
class KaryawanDenganKinerja extends Karyawan with Kinerja {
  KaryawanDenganKinerja(String nama, {required int umur, required String peran})
    : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print('$nama bekerja sebagai $peran dengan produktivitas $produktivitas%.');
  }
}

// ========== CLASS PROYEK ==========
class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan;
  List<Karyawan> tim = [];
  int hariBerjalan = 0;

  void tambahKaryawan(Karyawan karyawan) {
    tim.add(karyawan);
    print('${karyawan.nama} ditambahkan ke tim proyek.');
  }

  void tambahHari(int hari) {
    hariBerjalan += hari;
  }

  void lanjutFase() {
    switch (fase) {
      case FaseProyek.Perencanaan:
        if (tim.length >= 5) {
          fase = FaseProyek.Pengembangan;
          print('Proyek beralih ke tahap Pengembangan.');
        } else {
          print('Tim belum cukup (minimal 5 orang).');
        }
        break;

      case FaseProyek.Pengembangan:
        if (hariBerjalan > 45) {
          fase = FaseProyek.Evaluasi;
          print('Proyek beralih ke tahap Evaluasi.');
        } else {
          print('Belum cukup hari berjalan (>45 hari).');
        }
        break;

      case FaseProyek.Evaluasi:
        print('Proyek sudah di tahap akhir (Evaluasi).');
        break;
    }
  }
}

// ========== CLASS PERUSAHAAN ==========
class Perusahaan {
  static const int batasKaryawanAktif = 20;
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < batasKaryawanAktif) {
      karyawanAktif.add(karyawan);
      print('Menambahkan ${karyawan.nama} sebagai karyawan aktif.');
    } else {
      print('Batas maksimal 20 karyawan aktif sudah tercapai!');
    }
  }

  void resignKaryawan(Karyawan karyawan) {
    if (karyawanAktif.remove(karyawan)) {
      karyawan.aktif = false;
      karyawanNonAktif.add(karyawan);
      print('${karyawan.nama} telah resign dan menjadi non-aktif.');
    }
  }

  void tampilkanData() {
    print('\n=== Karyawan Aktif (${karyawanAktif.length}) ===');
    for (var k in karyawanAktif) {
      print('- ${k.nama} (${k.peran})');
    }

    print('\n=== Karyawan Non-Aktif (${karyawanNonAktif.length}) ===');
    for (var k in karyawanNonAktif) {
      print('- ${k.nama} (${k.peran})');
    }
  }
}

// ========== MAIN PROGRAM ==========
void main() {
  print('=== SISTEM MANAJEMEN PERUSAHAAN TONGIT ===\n');

  // 1. Buat Produk Digital dengan menggunakan positional argumen (berurutan) untuk mengisi nilai dari parameter
  var produk1 = ProdukDigital(
    'Data Optimizer',
    150000,
    KategoriProduk.DataManagement,
    40,
  );
  var produk2 = ProdukDigital(
    'Network AutoPro',
    250000,
    KategoriProduk.NetworkAutomation,
    70,
  );

  produk2.terapkanDiskon();

  print('Daftar Produk:');
  print('- $produk1');
  print('- $produk2\n');

  // 2. Tambah Karyawan dengan nama sebagai positional dan umur sebagai named
  var tongIT = Perusahaan();
  var dev1 = KaryawanTetap('Serly', umur: 25, peran: 'Developer');
  var dev2 = KaryawanKontrak('Atin', umur: 27, peran: 'Network Engineer');
  var dev3 = KaryawanTetap('Elsa', umur: 26, peran: 'Data Analist');
  var manajer = KaryawanDenganKinerja('Rizky', umur: 35, peran: 'Manager');

  tongIT.tambahKaryawan(dev1);
  tongIT.tambahKaryawan(dev2);
  tongIT.tambahKaryawan(dev3);
  tongIT.tambahKaryawan(manajer);

  // 3. Update Kinerja
  try {
    manajer.updateProduktivitas(90);
  } catch (e) {
    print('Error: $e');
  }

  // 4. Proyek Baru
  var proyekA = Proyek();
  proyekA.tambahKaryawan(dev1);
  proyekA.tambahKaryawan(dev2);
  proyekA.tambahKaryawan(dev3);
  proyekA.tambahKaryawan(manajer);
  proyekA.tambahKaryawan(KaryawanTetap('Bunga', umur: 26, peran: 'Tester'));
  proyekA.tambahKaryawan(KaryawanKontrak('Rian', umur: 24, peran: 'Support'));

  proyekA.lanjutFase(); // dari Perencanaan -> Pengembangan
  proyekA.tambahHari(50); 
  proyekA.lanjutFase(); // dari Pengembangan -> Evaluasi

  // 5. Perusahaan Update
  tongIT.tampilkanData();
  tongIT.resignKaryawan(dev2);
  tongIT.tampilkanData();

  print('\n=== Program Selesai ===');
}
