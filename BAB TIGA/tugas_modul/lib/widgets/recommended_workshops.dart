import 'package:flutter/material.dart';
import 'section_title.dart';

class RecommendedWorkshopsSection extends StatelessWidget {
  final List<Map<String, dynamic>> workshops = [
    {
      "title": "Lily Bouquet Studio",
      "category": "Florist & Gift Specialist",
      "image": "assets/images/rekomen1.jpg",
      "rating": 4.9,
      "description":
          "Temukan buket cantik yang dirangkai dengan penuh cinta untuk setiap momen spesialmu.",
    },
    {
      "title": "Bloom Workshop",
      "category": "Florist Class",
      "image": "assets/images/rekomen2.jpg",
      "rating": 4.9,
      "description":
          "Belajar membuat buket profesional bersama florist berpengalaman. Cocok untuk pemula maupun pengusaha buket.",
    },
    {
      "title": "Rose & Charm",
      "category": "Romantic Bouquet",
      "image": "assets/images/rekomen3.jpg",
      "rating": 4.8,
      "description":
          "Buket mawar elegan yang siap membuat momen spesialmu semakin berkesan.",
    },
    {
      "title": "Sunny Petals",
      "category": "Graduation Bouquet",
      "image": "assets/images/sun.png",
      "rating": 4.9,
      "description":
          "Rayakan kelulusan dengan buket ceria penuh warna yang melambangkan semangat dan kebanggaan.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle("Recommended Workshops"),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: workshops.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final workshop = workshops[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              shadowColor: Colors.redAccent.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.asset(
                          workshop["image"],
                          height: 110,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                workshop["rating"].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workshop["title"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          workshop["category"],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 82, 111, 255),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          workshop["description"],
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                100,
                                100,
                                255,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Book Service",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
