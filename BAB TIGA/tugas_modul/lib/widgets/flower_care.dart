import 'package:flutter/material.dart';

class FlowerCareWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5, // Memberikan efek kedalaman
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Membuat sudut melengkung
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul dengan teks yang menarik
              Text(
                'Cara Merawat Bunga Buket',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple, // Warna teks
                ),
              ),
              SizedBox(height: 10),

              // Deskripsi tentang merawat bunga
              Text(
                'Berikut adalah beberapa tips merawat bunga dari buket yang Anda beli:',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 10),

              // Tips 1
              _buildFlowerCareStep(
                icon: Icons.water_drop,
                stepTitle: 'Ganti air bunga setiap 2-3 hari sekali.',
                description:
                    'Pastikan bunga selalu mendapatkan air bersih untuk kesegaran yang lebih lama.',
              ),
              SizedBox(height: 10),

              // Tips 2
              _buildFlowerCareStep(
                icon: Icons.cut,
                stepTitle: 'Potong ujung batang bunga dengan sudut 45 derajat.',
                description:
                    'Potongan ini membantu bunga menyerap lebih banyak air dan bertahan lebih lama.',
              ),
              SizedBox(height: 10),

              // Tips 3
              _buildFlowerCareStep(
                icon: Icons.sunny,
                stepTitle:
                    'Simpan bunga di tempat yang tidak terpapar sinar matahari langsung.',
                description:
                    'Jauhkan bunga dari paparan sinar matahari langsung agar tidak cepat layu.',
              ),
              SizedBox(height: 10),

              // Tips 4
              _buildFlowerCareStep(
                icon: Icons.fastfood,
                stepTitle:
                    'Gunakan makanan bunga untuk memperpanjang kesegaran bunga.',
                description:
                    'Makanan bunga mengandung nutrisi yang diperlukan bunga untuk tetap segar.',
              ),
              SizedBox(height: 10),

              // Tips 5
              _buildFlowerCareStep(
                icon: Icons.no_food,
                stepTitle: 'Jauhkan bunga dari buah-buahan.',
                description:
                    'Buah-buahan dapat menghasilkan gas etilen yang mempercepat pembusukan bunga.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Membuat widget untuk setiap langkah perawatan bunga
  Widget _buildFlowerCareStep({
    required IconData icon,
    required String stepTitle,
    required String description,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.deepPurple, size: 30),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stepTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
