import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> products = [
    Product(
      name: 'Tulip',
      brand: 'S-Bouquet',
      price: 40,
      quantity: 2,
      imagePath: 'assets/images/tulip.jpg', // Gambar produk
    ),
    Product(
      name: 'Lily',
      brand: 'L-Bouquet',
      price: 333,
      quantity: 2,
      imagePath: 'assets/images/rekomen1.jpg', // Gambar produk
    ),
    Product(
      name: 'Baby Breath',
      brand: 'SF-Bouquet',
      price: 50,
      quantity: 2,
      imagePath: 'assets/images/baby.jpg', // Gambar produk
    ),
  ];

  double discount = 4;
  double deliveryCharges = 2;

  void _increaseQuantity(int index) {
    setState(() {
      products[index].quantity++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (products[index].quantity > 1) {
        products[index].quantity--;
      }
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  double getSubtotal() {
    return products.fold(
      0,
      (sum, product) => sum + (product.price * product.quantity),
    );
  }

  double getTotal() {
    double subtotal = getSubtotal();
    return subtotal - discount + deliveryCharges;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar Produk
                        Image.asset(
                          product.imagePath, // Menggunakan path gambar produk
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                        // Nama Produk, Brand, dan Harga
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(product.brand),
                              SizedBox(height: 4),
                              Text(
                                '\$${product.price}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        // Tombol Hapus, Menambah dan Mengurangi Jumlah Produk
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteProduct(index),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => _decreaseQuantity(index),
                                ),
                                Text(
                                  '${product.quantity}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => _increaseQuantity(index),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Summary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Items'), Text('${products.length}')],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Subtotal'), Text('\$${getSubtotal()}')],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Discount'), Text('-\$${discount}')],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Charges'),
                    Text('\$${deliveryCharges}'),
                  ],
                ),
                SizedBox(height: 12),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${getTotal()}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement checkout functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Button color
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 150,
                ), // Adjust button padding
              ),
              child: Text(
                'Check Out',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String brand;
  final double price;
  int quantity;
  final String imagePath;

  Product({
    required this.name,
    required this.brand,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });
}
