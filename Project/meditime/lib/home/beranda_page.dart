import 'package:flutter/material.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  // Status checkbox untuk masing-masing obat
  List<bool> _isCheckedList = [
    true,
    false,
  ]; // Updated based on the image (Vitamin D is checked)

  // Fungsi untuk menghitung berapa banyak obat yang sudah diminum
  int get _totalChecked {
    return _isCheckedList.where((isChecked) => isChecked).toList().length;
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    final DateTime now = DateTime.now();
    final String formattedDate =
        "${now.day} ${_getMonthName(now.month)} ${now.year}";
    final String formattedTime =
        "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      body: SingleChildScrollView(
        // Membuat halaman bisa digulir
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Today
              Center(
                child: Column(
                  children: [
                    // Waktu
                    Text(
                      '$formattedTime', // Jam
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    // Tanggal
                    Text(
                      '$formattedDate', // Tanggal
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Daftar Obat Hari Ini
              Text(
                'Daftar Obat Hari Ini:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Obat Pertama (Vitamin D)
              MedicationItem(
                name: 'Vitamin D',
                dose: '1 Capsule, 1000mg',
                time: '09:41',
                isChecked: _isCheckedList[0],
                onChanged: (value) {
                  setState(() {
                    _isCheckedList[0] = value!;
                  });
                },
              ),

              // Obat Kedua (Paracetamol)
              MedicationItem(
                name: 'Paracetamol',
                dose: '1 Capsule, 500mg',
                time: '16:00',
                isChecked: _isCheckedList[1],
                onChanged: (value) {
                  setState(() {
                    _isCheckedList[1] = value!;
                  });
                },
              ),

              // Progress
              SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    // Circle for the progress number
                    Container(
                      width: 80, // Width of the circle
                      height: 80, // Height of the circle
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Make it a circle
                        color: const Color.fromARGB(
                          255,
                          123,
                          213,
                          126,
                        ), // Background color of the circle
                      ),
                      child: Center(
                        child: Text(
                          '$_totalChecked/2',
                          style: TextStyle(
                            fontSize:
                                24, // Adjust the size of the progress number
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color inside the circle
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Day of the week text
                    Text(
                      'Jumat', // Day of the week
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    SizedBox(height: 10),
                    Text(
                      'Total obat yang diminum hari ini adalah $_totalChecked/2. Jangan lupa minum obat!', // Day of the week
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ), // Tambahkan jarak kosong untuk menyeimbangkan tampilan
              // Floating Action Button
              BottomFab(),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan nama bulan
  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}

class MedicationItem extends StatelessWidget {
  final String name;
  final String dose;
  final String time;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const MedicationItem({
    required this.name,
    required this.dose,
    required this.time,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Menyusun elemen-elemen di kiri dan kanan
          children: [
            // Deskripsi Obat
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(dose, style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 33, 243, 131),
                  ),
                ),
              ],
            ),
            // Checkbox
            Checkbox(value: isChecked, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

class BottomFab extends StatelessWidget {
  const BottomFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: () {
          // Logika untuk menambahkan obat baru
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
