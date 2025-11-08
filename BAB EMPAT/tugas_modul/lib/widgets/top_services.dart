import 'package:flutter/material.dart';

class TopServicesSection extends StatelessWidget {
  final List<Map<String, String>> services = [
    {
      "image": "assets/images/custom1.jpg",
      "name": "Fresh Bloom",
      "role": "Ternate",
      "desc":
          "Buket segar dengan pilihan bunga terbaik, dirangkai khusus untuk setiap kesempatan.",
    },
    {
      "image": "assets/images/custom2.jpg",
      "name": "Petal Gift Corner",
      "role": "Ambon",
      "desc":
          "Rangkai buket sesuai gaya dan warna favoritmu. Pilih sendiri bunganya, kami wujudkan idemu.",
    },
    {
      "image": "assets/images/custom3.jpg",
      "name": "Liliy Custom Bouquet",
      "role": "Manado",
      "desc":
          "Hadiahkan senyum dengan buket dan hampers cantik yang siap dikirim ke orang tersayang.",
    },
    {
      "image": "assets/images/rekomen3.jpg",
      "name": "Bloom Class Studio",
      "role": "Makassar",
      "desc":
          "Ikuti kelas merangkai buket bersama florist profesional dan pelajari teknik dasar hingga dekoratif.",
    },
  ];

  TopServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Top Services",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // List of Services
        Column(
          children: services.map((service) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === Gambar di kiri ===
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      service["image"]!,
                      width: 120, // 🔹 ubah ukuran gambar di sini
                      height: 120, // 🔹 1:1 ratio
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // === Card putih di kanan ===
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service["name"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service["role"]!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            service["desc"]!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Rating + Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 63, 83, 255),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.star,
                                      color: Color.fromARGB(255, 212, 255, 0),
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "4.9",
                                      style: TextStyle(
                                        color: Color.fromARGB(
                                          255,
                                          255,
                                          255,
                                          255,
                                        ),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    60,
                                    70,
                                    255,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  "Book Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
