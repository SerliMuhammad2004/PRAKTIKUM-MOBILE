import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'edit_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  // Data berita statis
  final List<Map<String, String>> news = [
    {
      "imageUrl":
          "https://cdn.pixabay.com/photo/2018/01/19/14/40/nature-3092555_1280.jpg",
      "title": "dandelions",
      "author": "muda",
      "description":
          "Bunga dandelion yang tertiup angin di padang rumput hijau. Foto ini diambil saat musim semi dan menggambarkan keindahan alam yang menenangkan.",
      "time": "4h ago",
    },
    {
      "imageUrl":
          "https://cdn.pixabay.com/photo/2014/04/10/11/24/rose-320868_1280.jpg",
      "title":
          "Bunga adalah lambang keindahan",
      "author": "Muda",
      "description":
          "Bunga mawar dikenal sebagai simbol cinta dan keindahan. Warnanya yang cerah dan bentuknya yang anggun menjadikannya bunga favorit di seluruh dunia.",
      "time": "14m ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Daftar halaman yang akan ditampilkan di IndexedStack
    final List<Widget> pages = [
      // Halaman Home
      ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3,
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: news[index]['title']!,
                      description: news[index]['description']!,
                      imageUrl: news[index]['imageUrl']!,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar Berita
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        news[index]['imageUrl']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        news[index]['title']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${news[index]['author']} • ${news[index]['time']}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // Halaman Explore
      const Center(child: Text("Explore Page")),

      // Halaman Bookmark
      const Center(child: Text("Bookmark Page")),

      // Halaman Profil
      EditProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text(
              "HMTI ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "News",
              style: TextStyle(
                color: Color(0xFF1877F2),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      // Drawer menu samping
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1877F2),
              ),
              child: Text(
                "Pengaturan",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profil"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Pengaturan"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // Isi utama layar
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      // Navigasi bawah
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF1877F2),
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
