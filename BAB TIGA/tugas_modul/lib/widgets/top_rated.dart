import 'package:flutter/material.dart';
import 'section_title.dart';

class TopRatedSection extends StatelessWidget {
  final List<Map<String, dynamic>> flowers = [
    {"name": "Bouquet S", "rating": 4.8, "image": "assets/images/rate1.jpg"},
    {"name": "Bouquet E", "rating": 4.7, "image": "assets/images/rate2.jpg"},
    {"name": "Bouquet R", "rating": 4.6, "image": "assets/images/rate3.jpg"},
    {"name": "Bouquet L", "rating": 4.5, "image": "assets/images/rate4.jpg"},
    {"name": "Bouquet Y", "rating": 4.8, "image": "assets/images/rate5.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle("Top Rated Bouquets"),
        const SizedBox(height: 10),
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: flowers.length,
            itemBuilder: (context, i) {
              final item = flowers[i];
              return Container(
                width: 145,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        item["image"],
                        height: 100,
                        width: 100, // Membuat gambar berbentuk lingkaran
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        item["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          Text(
                            item["rating"].toStringAsFixed(1),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
