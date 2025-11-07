// Proyek Mini: Sistem Manajemen Kebun Bunga

import 'dart:async';

// =================== ENUM ===================
enum FasePertumbuhan { Benih, Tumbuh, Berbunga, Panen }

// =================== MIXIN ===================
// Mixin Perawatan: menangani kesehatan dan aturan update tiap 30 hari
mixin Perawatan {
  int kesehatan = 70; // 0..100
  DateTime? terakhirPerawatan;

  // update kesehatan — hanya boleh tiap >=30 hari
  void lakukanPerawatan(int peningkatan) {
    final now = DateTime.now();
    if (terakhirPerawatan == null ||
        now.difference(terakhirPerawatan!).inDays >= 30) {
      kesehatan = (kesehatan + peningkatan).clamp(0, 100);
      terakhirPerawatan = now;
      print('Perawatan selesai. Kesehatan sekarang: $kesehatan');
    } else {
      throw Exception('Perawatan hanya boleh dilakukan setiap 30 hari.');
    }
  }

  // pemeliharaan kecil yang bisa dipanggil kapan saja (tidak mengubah terakhirPerawatan)
  void siramRingan() {
    kesehatan = (kesehatan + 2).clamp(0, 100);
    print('Siram ringan -> kesehatan: $kesehatan');
  }
}

// =================== ABSTRACT CLASS TANAMAN ===================
abstract class Tanaman with Perawatan {
  // nama harus positional argumen (wajib), sementara umur dan warna named
  String nama;
  int umurHari; // usia tanaman dalam hari
  String? warna; // bisa null
  late DateTime plantedAt; // late inisialisasi ketika ditanam
  FasePertumbuhan fase = FasePertumbuhan.Benih;
  bool siapPanen = false;

  Tanaman(this.nama, {required this.umurHari, this.warna});

  // setiap tanaman wajib implementasi deskripsi
  String deskripsi();

  // logika transisi fase berdasarkan umur dan kesehatan
  void cekTransisi() {
    if (umurHari >= 0 && umurHari < 7) {
      fase = FasePertumbuhan.Benih;
    } else if (umurHari >= 7 && umurHari < 21) {
      fase = FasePertumbuhan.Tumbuh;
    } else if (umurHari >= 21 && umurHari < 40) {
      fase = FasePertumbuhan.Berbunga;
    } else {
      fase = FasePertumbuhan.Panen;
      siapPanen = true;
    }
  }

  // metode untuk memajukan hari (simulasi waktu berlalu)
  void majuHari(int hari) {
    umurHari += hari;
    // kesehatan menurun sedikit setiap hari
    kesehatan = (kesehatan - hari).clamp(0, 100);
    cekTransisi();
  }
}

// =================== SUBCLASSES BUNGA ===================
class BungaMawar extends Tanaman {
  int jumlahDurinya;

  BungaMawar(String nama,
      {required int umurHari, String? warna, this.jumlahDurinya = 10})
      : super(nama, umurHari: umurHari, warna: warna);

  @override
  String deskripsi() {
    return 'Mawar "$nama" warna: ${warna ?? "tidak disebutkan"}, duri: $jumlahDurinya, fase: ${fase.name}, kesehatan: $kesehatan';
  }
}

class BungaMatahari extends Tanaman {
  double diameterBungaCm;

  BungaMatahari(String nama,
      {required int umurHari, String? warna, this.diameterBungaCm = 8.0})
      : super(nama, umurHari: umurHari, warna: warna);

  @override
  String deskripsi() {
    return 'Matahari "$nama" warna: ${warna ?? "kuning"}, diameter: ${diameterBungaCm}cm, fase: ${fase.name}, kesehatan: $kesehatan';
  }
}



// =================== ABSTRACT CLASS PEKERJA ===================
abstract class PekerjaKebun {
  String nama;
  PekerjaKebun(this.nama);

  void bekerja(); // abstrak
}

class TukangTanam extends PekerjaKebun {
  TukangTanam(String nama) : super(nama);

  @override
  void bekerja() {
    print('$nama (TukangTanam) menanam bibit baru.');
  }
}

class TukangSiram extends PekerjaKebun {
  TukangSiram(String nama) : super(nama);

  @override
  void bekerja() {
    print('$nama (TukangSiram) menyiram tanaman.');
  }
}

class TukangPanen extends PekerjaKebun {
  TukangPanen(String nama) : super(nama);

  @override
  void bekerja() {
    print('$nama (TukangPanen) memanen tanaman yang siap.');
  }
}

// =================== KELAS KEBUN ===================
class Kebun {
  static const int MAX_ACTIVE_PLANTS = 50;

  final Map<String, int> stokBibit = {}; // nama species -> stok (Map)
  final Map<String, Tanaman> tanamanAktif = {}; // id -> tanaman
  final Set<String> jenisUnik = {}; // set nama species unik
  int _nextId = 1;

  Kebun();

  // tambahkan stok bibit
  void tambahStok(String species, int jumlah) {
    stokBibit.update(species, (v) => v + jumlah, ifAbsent: () => jumlah);
    jenisUnik.add(species);
    print('Stok $species sekarang: ${stokBibit[species]}');
  }

  // generate id tanaman sederhana
  String _generateId() => 'T${_nextId++}';

  // menanam tanaman (positional nama, named umur & warna)
  void tanam(String species, String namaTanaman,
      {required int umurHari, String? warna}) {
    // cek batas tanaman aktif
    if (tanamanAktif.length >= MAX_ACTIVE_PLANTS) {
      throw Exception('Kebun penuh: maksimal $MAX_ACTIVE_PLANTS tanaman aktif.');
    }

    // cek stok
    final stok = stokBibit[species] ?? 0;
    if (stok <= 0) {
      throw Exception('Stok $species habis.');
    }

    // buat instance sesuai species (simple factory-like)
    Tanaman tanaman;
    if (species.toLowerCase() == 'mawar') {
      tanaman = BungaMawar(namaTanaman, umurHari: umurHari, warna: warna);
    } else if (species.toLowerCase() == 'matahari') {
      tanaman =
          BungaMatahari(namaTanaman, umurHari: umurHari, warna: warna);
    } else {
      // fallback: gunakan mawar jika species tidak dikenal
      tanaman = BungaMawar(namaTanaman, umurHari: umurHari, warna: warna);
    }

    tanaman.plantedAt = DateTime.now();
    tanaman.cekTransisi();

    final id = _generateId();
    tanamanAktif[id] = tanaman;
    stokBibit[species] = stok - 1;

    print('Tanaman ditanam -> id: $id, ${tanaman.deskripsi()}');
  }

  // panen tanaman yang siapPanen == true
  void panen(String id) {
    final t = tanamanAktif[id];
    if (t == null) {
      print('Tanaman id $id tidak ditemukan.');
      return;
    }
    if (!t.siapPanen) {
      print('Tanaman ${t.nama} belum siap panen (fase ${t.fase}).');
      return;
    }
    tanamanAktif.remove(id);
    print('Tanaman ${t.nama} (id $id) telah dipanen.');
  }

  // lihat ringkasan kebun
  void ringkasan() {
    print('\n--- Ringkasan Kebun ---');
    print('Total jenis unik: ${jenisUnik.length}');
    print('Stok bibit: $stokBibit');
    print('Tanaman aktif: ${tanamanAktif.length}');
    tanamanAktif.forEach((id, t) {
      print('- $id : ${t.deskripsi()}');
    });
  }

  // cari tanaman by name (async simulasi fetch)
  Future<Tanaman?> fetchPlantDetails(String id) async {
    // simulasi delay fetch
    await Future.delayed(Duration(seconds: 2));
    return tanamanAktif[id];
  }
}

// =================== CONTOH PENGGUNAAN DI main() ===================
Future<void> main() async {
  print('=== Sistem Manajemen Kebun Bunga ===');

  final kebun = Kebun();

  // tambah stok bibit (Map usage)
  kebun.tambahStok('Mawar', 5);
  kebun.tambahStok('Matahari', 3);

  // pekerja kebun (abstract class usage)
  final pekerja1 = TukangTanam('Pak Joko');
  final pekerja2 = TukangSiram('Bu Siti');
  final pekerja3 = TukangPanen('Mas Rian');

  pekerja1.bekerja();
  pekerja2.bekerja();
  pekerja3.bekerja();

  // menanam beberapa tanaman (positional nama, named umur & warna)
  try {
    kebun.tanam('Mawar', 'MawarMerah1', umurHari: 1, warna: 'Merah');
    kebun.tanam('Mawar', 'MawarPutih', umurHari: 8, warna: 'Putih');
    kebun.tanam('Matahari', 'Sunshine', umurHari: 25, warna: 'Kuning');
    kebun.tanam('Mawar', 'MawarKecil', umurHari: 22, warna: 'Pink');
  } on Exception catch (e) {
    print('Error saat menanam: $e');
  }

  // ringkasan awal
  kebun.ringkasan();

  // simulasi perawatan dan waktu berjalan
  // ambil salah satu id untuk contoh
  final someId = kebun.tanamanAktif.keys.first;
  final somePlant = kebun.tanamanAktif[someId]!;

  print('\n-- Simulasi siram ringan --');
  somePlant.siramRingan();

  print('-- Coba lakukan perawatan penuh (mengikuti aturan 30 hari) --');
  try {
    somePlant.lakukanPerawatan(15); // berhasil (pertama kali)
  } catch (e) {
    print('Perawatan gagal: $e');
  }

  print('-- Maju hari 30 untuk memicu transisi fase dan menurunkan kesehatan --');
  somePlant.majuHari(30); // menaikkan umur, menurunkan kesehatan
  somePlant.cekTransisi();
  print('Status setelah 30 hari: ${somePlant.deskripsi()}');

  // contoh async fetch details
  print('\nMengambil detail tanaman (async) untuk id $someId ...');
  final fetched = await kebun.fetchPlantDetails(someId);
  if (fetched != null) {
    print('Ditemukan: ${fetched.deskripsi()}');
  } else {
    print('Tidak ditemukan.');
  }

  // coba panen (hanya yang siapPanen)
  print('\n-- Mencoba panen semua tanaman aktif --');
  final ids = List<String>.from(kebun.tanamanAktif.keys);
  for (var id in ids) {
    kebun.panen(id);
  }

  // ringkasan akhir
  kebun.ringkasan();

  print('\n=== Program Kebun Selesai ===');
}
