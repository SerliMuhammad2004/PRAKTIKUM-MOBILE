import 'dart:async';

// ==================== ENUM ====================
enum WaktuMinum { Pagi, Siang, Sore, Malam }

// ==================== MIXIN ====================
mixin Kepatuhan {
  int tingkatKepatuhan = 100;
  DateTime? terakhirUpdate;

  void perbaruiKepatuhan(int nilaiBaru) {
    final sekarang = DateTime.now();
    if (terakhirUpdate == null ||
        sekarang.difference(terakhirUpdate!).inDays >= 1) {
      if (nilaiBaru < 0 || nilaiBaru > 100) {
        throw Exception('Nilai kepatuhan harus antara 0–100.');
      }
      tingkatKepatuhan = nilaiBaru;
      terakhirUpdate = sekarang;
      print('Kepatuhan diperbarui: $tingkatKepatuhan%');
    } else {
      throw Exception('Kepatuhan hanya dapat diperbarui 1x per hari.');
    }
  }
}

// ==================== CLASS OBAT ====================
class Obat {
  String nama;
  double dosisMg;
  String satuan;

  Obat(this.nama, {required this.dosisMg, required this.satuan});

  @override
  String toString() => '$nama (${dosisMg}${satuan})';
}

// ==================== CLASS JADWAL ====================
class Jadwal {
  Obat obat;
  WaktuMinum waktu;
  DateTime dosisBerikutnya;
  bool sudahDiminum;

  Jadwal(this.obat, this.waktu, this.dosisBerikutnya,
      {this.sudahDiminum = false});

  void tandaiSudahDiminum() {
    sudahDiminum = true;
    print('Obat ${obat.nama} telah diminum.');
  }

  @override
  String toString() {
    final status = sudahDiminum ? 'Sudah diminum' : 'Belum diminum';
    return '${obat.nama} (${obat.dosisMg}${obat.satuan}) - ${waktu.name} - $status';
  }
}

// ==================== ABSTRACT CLASS AKUN ====================
abstract class Akun {
  String id;
  String nama;

  Akun(this.id, this.nama);
  void info();
}

// ==================== CLASS PASIEN ====================
class Pasien extends Akun with Kepatuhan {
  List<Jadwal> daftarJadwal = [];
  Pasien(String id, String nama) : super(id, nama);

  @override
  void info() {
    print('Pasien: $nama (ID: $id), Kepatuhan: $tingkatKepatuhan%');
  }

  void tambahJadwal(Jadwal jadwal) {
    daftarJadwal.add(jadwal);
    print('Jadwal obat "${jadwal.obat.nama}" ditambahkan untuk $nama.');
  }

  int hitungSudahDiminum() =>
      daftarJadwal.where((j) => j.sudahDiminum).length;

  int totalJadwal() => daftarJadwal.length;
}

// ==================== CLASS PROFIL ====================
class ProfilPengguna {
  String nama;
  DateTime tanggalLahir;
  String kontak;
  String preferensiNotifikasi;

  ProfilPengguna(
      {required this.nama,
      required this.tanggalLahir,
      required this.kontak,
      required this.preferensiNotifikasi});

  void tampilkanProfil() {
    print('=== Profil Pengguna ===');
    print('Nama: $nama');
    print('Tanggal Lahir: $tanggalLahir');
    print('Kontak: $kontak');
    print('Preferensi Notifikasi: $preferensiNotifikasi\n');
  }
}

// ==================== CLASS FORM TAMBAH OBAT ====================
class FormTambahObat {
  Future<Jadwal> buatJadwalBaru(
      String namaObat, double dosis, String satuan, WaktuMinum waktu) async {
    print('Menambahkan obat baru...');
    await Future.delayed(Duration(seconds: 1)); // simulasi proses input
    final obat = Obat(namaObat, dosisMg: dosis, satuan: satuan);
    final jadwal = Jadwal(obat, waktu, DateTime.now());
    print('Jadwal baru berhasil dibuat: $jadwal');
    return jadwal;
  }
}

// ==================== CLASS FORM HAPUS OBAT ====================
class FormHapusObat {
  void hapusJadwal(Pasien pasien, String namaObat) {
    bool ditemukan = false;
    pasien.daftarJadwal.removeWhere((jadwal) {
      if (jadwal.obat.nama == namaObat) {
        ditemukan = true;
        return true;
      }
      return false;
    });

    if (ditemukan) {
      print('Obat "$namaObat" berhasil dihapus dari daftar jadwal ${pasien.nama}.');
    } else {
      print('Obat "$namaObat" tidak ditemukan di daftar jadwal ${pasien.nama}.');
    }
  }
}

// ==================== CLASS HALAMAN UTAMA ====================
class HalamanUtama {
  Pasien pasien;

  HalamanUtama(this.pasien);

  void tampilkanDaftarObat() {
    print('\n=== Halaman Utama MediTime ===');
    print('Waktu saat ini: ${DateTime.now()}');
    print('Daftar Obat Harian untuk ${pasien.nama}:');
    if (pasien.daftarJadwal.isEmpty) {
      print('Belum ada jadwal obat.');
      return;
    }

    int sudah = pasien.hitungSudahDiminum();
    int total = pasien.totalJadwal();
    for (var j in pasien.daftarJadwal) {
      print('- ${j}');
    }
    print('\nTotal obat diminum: $sudah/$total');
    if (sudah < total) {
      print('Masih ada ${total - sudah} obat yang belum diminum!');
    } else {
      print('Semua obat hari ini sudah diminum!');
    }
  }
}

// ==================== KELAS UTAMA APLIKASI ====================
class MediTimeApp {
  Pasien pasien;
  ProfilPengguna profil;
  FormTambahObat formTambahObat;
  FormHapusObat formHapusObat;
  HalamanUtama halamanUtama;

  MediTimeApp(this.pasien, this.profil)
      : formTambahObat = FormTambahObat(),
        formHapusObat = FormHapusObat(),
        halamanUtama = HalamanUtama(pasien);

  Future<void> mulai() async {
    print('=== MEDITIME - Pemantau Jadwal Minum Obat Harian ===');
    profil.tampilkanProfil();
    pasien.info();

    // Tambahkan jadwal awal
    final j1 = await formTambahObat.buatJadwalBaru(
        'Paracetamol', 500, 'mg', WaktuMinum.Pagi);
    final j2 = await formTambahObat.buatJadwalBaru(
        'Amoxicillin', 250, 'mg', WaktuMinum.Siang);
    final j3 = await formTambahObat.buatJadwalBaru(
        'Vitamin C', 1000, 'mg', WaktuMinum.Sore);

    pasien.tambahJadwal(j1);
    pasien.tambahJadwal(j2);
    pasien.tambahJadwal(j3);

    halamanUtama.tampilkanDaftarObat();

    // Simulasi minum obat
    print('\nSimulasi pasien minum obat...');
    pasien.daftarJadwal[0].tandaiSudahDiminum();
    pasien.daftarJadwal[1].tandaiSudahDiminum();

    halamanUtama.tampilkanDaftarObat();

    // Hapus obat
    print('\nSimulasi hapus obat...');
    formHapusObat.hapusJadwal(pasien, 'Amoxicillin');
    halamanUtama.tampilkanDaftarObat();

    // Update kepatuhan pasien
    try {
      pasien.perbaruiKepatuhan(95);
    } catch (e) {
      print('Error: $e');
    }
  }
}

// ==================== MAIN PROGRAM ====================
Future<void> main() async {
  final profil = ProfilPengguna(
      nama: 'Serly',
      tanggalLahir: DateTime(2004, 4, 3),
      kontak: 'serly@gmail.com',
      preferensiNotifikasi: 'Getar');

  final pasien = Pasien('P001', profil.nama);
  final app = MediTimeApp(pasien, profil);
  await app.mulai();
}
