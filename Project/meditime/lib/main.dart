import 'package:flutter/material.dart';
import 'home/beranda_page.dart';
import 'widget/kalender_page.dart';
import 'widget/profil_page.dart';

void main() {
  runApp(const MediTimeApp());
}

class MediTimeApp extends StatelessWidget {
  const MediTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediTime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  // Untuk mengatur halaman yang aktif
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan sesuai dengan pilihan BottomNavigationBar
  final List<Widget> _pages = [
    // Halaman pertama: Beranda
    const BerandaPage(),
    // Halaman kedua: Kalender
    const KalenderPage(),
    // Halaman ketiga: Profil
    const ProfilPage(),
  ];

  // Fungsi untuk mengganti halaman sesuai dengan pilihan BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MediTime"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: _pages[_selectedIndex], // Menampilkan halaman sesuai dengan index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Menandakan tab yang aktif
        onTap: _onItemTapped, // Fungsi untuk mengganti halaman
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ikon beranda
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), // Ikon kalender
            label: 'Kalender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Ikon profil
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
