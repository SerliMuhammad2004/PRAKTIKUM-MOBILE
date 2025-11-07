import 'package:flutter/material.dart';

class TodaysDeal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE1E9FF), Color(0xFFB4C7FF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Today's Deal",
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "15% OFF on Sunflower Bouquet",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        "Ceriakan harimu dengan buket bunga matahari yang penuh warna dan energi positif, hadiah manis untuk orang tersayang.",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 10,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("BUY IT NOW"),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 220,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: 
                  Image.asset(
                    'assets/images/sun.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
