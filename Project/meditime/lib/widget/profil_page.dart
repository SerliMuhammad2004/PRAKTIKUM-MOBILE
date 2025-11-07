import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  // Variabel penyimpanan data
  final TextEditingController _namaController = TextEditingController(
    text: 'Serly',
  );
  final TextEditingController _tanggalController = TextEditingController(
    text: 'mm / dd / yyyy',
  );
  String _preferensi = 'Getar';

  // Widget input teks
  Widget buildTextField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green),
          labelText: label,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.green,
          ),
          filled: true,
          fillColor: Colors.green[50],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
      ),
    );
  }

  // Widget dropdown preferensi
  Widget buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.notifications_active,
            color: Colors.green,
          ),
          labelText: 'Preferensi Notifikasi',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.green,
          ),
          filled: true,
          fillColor: Colors.green[50],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _preferensi,
            isExpanded: true,
            borderRadius: BorderRadius.circular(15),
            items: const [
              DropdownMenuItem(value: 'Bunyi', child: Text('Bunyi')),
              DropdownMenuItem(value: 'Getar', child: Text('Getar')),
              DropdownMenuItem(value: 'Senyap', child: Text('Senyap')),
            ],
            onChanged: (value) {
              setState(() {
                _preferensi = value!;
              });
            },
          ),
        ),
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 20),
                buildTextField('Nama', _namaController, Icons.person_outline),
                buildTextField(
                  'Tanggal Lahir',
                  _tanggalController,
                  Icons.cake_outlined,
                ),
                const SizedBox(height: 10),
                buildDropdownField(),
                const SizedBox(height: 25),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Data disimpan:\nNama: ${_namaController.text}\nTanggal: ${_tanggalController.text}\nPreferensi: $_preferensi',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
