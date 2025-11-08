import 'package:flutter/material.dart';
import '../widgets/todays_deal.dart';
import '../widgets/top_rated.dart';
import '../widgets/top_services.dart';
import '../widgets/best_bookings.dart';
import '../widgets/recommended_workshops.dart';
import '../widgets/flower_care.dart';
import 'cart_screen.dart'; // Mengimpor halaman keranjang

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloomora"),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          const Icon(Icons.notifications_none),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Arahkan ke halaman keranjang
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Cari buket kesukaanmu...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TodaysDeal(),
            const SizedBox(height: 20),
            TopRatedSection(),
            const SizedBox(height: 20),
            TopServicesSection(),
            const SizedBox(height: 20),
            BestBookingsSection(),
            const SizedBox(height: 20),
            RecommendedWorkshopsSection(),
            const SizedBox(height: 20),
            FlowerCareWidget(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
