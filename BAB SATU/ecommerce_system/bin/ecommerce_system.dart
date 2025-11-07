// membuat model data kelas user beserta atributnya
class User {
  final String name;
  final int age;

  // Null Safety & Late Initialization:
  late List<Product>? products;
  Role? role;

  User({
    required this.name,
    required this.age,
    this.role,
  });

  void viewProducts() {
    // menampilkan daftar produk
    final p = products;
    if (p == null || p.isEmpty) {
      print('$name belum memiliki produk.');
      return;
    }
    print('Produk milik $name:');
    for (var prod in p) {
      print(' - $prod');
    }
  }
}

// Membuat kelas Produk dengan atributnya
class Product {
  final String productName;
  double price;
  bool inStock;

  Product({
    required this.productName,
    required this.price,
    required this.inStock,
  });

  @override
  String toString() =>
      // mengubah tampilaan objek menjadi teks
      "$productName (Rp${price.toStringAsFixed(0)} - ${inStock ? 'In Stock' : 'Out of Stock'})";

  // Override untuk membandingkan 2 objek produk berdasarkan nama produk
  @override
  bool operator ==(Object other) =>
      other is Product && productName == other.productName;

  @override
  // membuat kode unik agar produk dengan nama sama tidak dianggap duplikat
  int get hashCode => productName.hashCode;
}

enum Role { Admin, Customer } // membuat tipe data tetap bernama role

class AdminUser extends User {
  AdminUser({required String name, required int age})
      : super(name: name, age: age, role: Role.Admin);

  void addProductToUser(User targetUser, Product productToAdd) {
    // tambah produk
    try {
      if (!productToAdd.inStock) {
        throw OutOfStockException('${productToAdd.productName} tidak tersedia.');
      }

      targetUser.products ??= <Product>[];

      final uniqueSet = Set<Product>.from(targetUser.products!);
      if (uniqueSet.add(productToAdd)) {
        targetUser.products = uniqueSet.toList();
        print(
            'Admin $name menambahkan ${productToAdd.productName} ke ${targetUser.name}.');
      } else {
        print(
            'Produk ${productToAdd.productName} sudah ada di daftar ${targetUser.name}.');
      }
    } on OutOfStockException catch (e) {
      print('Gagal menambahkan produk: $e');
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  void removeProductFromUser(User targetUser, String productName) {
    // hapus produk
    if (targetUser.products == null || targetUser.products!.isEmpty) {
      print('Tidak ada produk untuk dihapus.');
      return;
    }
    targetUser.products!.removeWhere((p) => p.productName == productName);
    print('Admin $name menghapus $productName dari ${targetUser.name}.');
  }
}

class CustomerUser extends User {
  CustomerUser({required String name, required int age})
      : super(name: name, age: age, role: Role.Customer);
}

class OutOfStockException implements Exception {
  // menandai produk yg stoknya kosong
  final String message;
  OutOfStockException(this.message);

  @override
  String toString() => "OutOfStockException: $message";
}

class ProductCatalog {
  // tempat menyimpan semua produk
  final Map<String, Product> _catalog = {};

  void addProduct(Product p) {
    // tambah produk ke katalog
    _catalog[p.productName] = p;
  }

  Product? getByName(String name) => _catalog[name]; // mencari produk berdasarkan nama

  void printCatalog() {
    // mencetak isi katalog ke layar
    print('--- Katalog Produk ---');
    if (_catalog.isEmpty) {
      print('(kosong)');
      return;
    }
    _catalog.forEach((k, v) => print(' - $v'));
  }
}

Future<Product> fetchProductDetails(ProductCatalog catalog, String productName) async {
  await Future.delayed(Duration(seconds: 1)); // mensimulasikan penundaan
  final product = catalog.getByName(productName);
  if (product == null) throw Exception('Produk "$productName" tidak ditemukan.');
  return product;
}

Future<void> main() async {
  // Buat katalog
  final catalog = ProductCatalog();
  catalog.addProduct(Product(productName: 'Es Cendol', price: 12000, inStock: true));
  catalog.addProduct(Product(productName: 'Bakso', price: 8000, inStock: true));
  catalog.addProduct(Product(productName: 'Kripik Amo', price: 10000, inStock: false));

  catalog.printCatalog();

  // Buat pengguna
  final admin = AdminUser(name: 'Arya', age: 30);
  final customer = CustomerUser(name: 'Serly', age: 22);
  customer.products = [];

  // Admin menambah produk
  final esCendol = catalog.getByName('Es Cendol')!;
  admin.addProductToUser(customer, esCendol);

  final kripik = catalog.getByName('Kripik Amo')!;
  admin.addProductToUser(customer, kripik);

  customer.viewProducts();

  // Hapus produk
  admin.removeProductFromUser(customer, 'Es Cendol');
  customer.viewProducts();

  // Tes fungsi async
  try {
    print('\nMengambil detail produk Bakso...');
    final bakso = await fetchProductDetails(catalog, 'Bakso');
    print('Detail produk: $bakso');
  } catch (e) {
    print('Error: $e');
  }

  // Produk tidak ada
  try {
    print('\nMengambil detail produk TidakAda...');
    await fetchProductDetails(catalog, 'TidakAda');
  } catch (e) {
    print('Error: $e');
  }
}
