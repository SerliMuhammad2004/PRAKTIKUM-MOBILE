//Membuat enum untuk membedakan jenis atau peran pengguna
//admin -> bisa menambah dan menghapus produk milik customer
//customer -> hanya bisa melihat produk
enum Role { admin, customer }

//Membuat kelas Produk
class Product {
  final String productName; //nama produk
  double price; //Harga
  bool inStock; //Apakah produk tersedia(Stok)

  //Konstruktor
  Product({
    required this.productName, //required memastikan bahwa parameter (atribut) harus diisi saat memanggil fungsi atau objek
    required this.price,
    required this.inStock,
  });

  //Mengatur cara sebuah objek ditampilkan
  @override
  String toString () =>
      '$productName (Rp${price.toStringAsFixed(0)} - ${inStock ? 'In Stock' : 'Out of Stock'})';

  //Override untuk membandingkan 2 produk dengan nama yang sama maka dianggap satu produk.
  @override
  bool operator ==(Object other) =>
      other is Product && productName == other.productName;

  @override
  int get hashCode => productName.hashCode;
}
class User {
  final String name;
  final int age;

  late List<Product>? products; // diinisialisasi setelah objek dibuat
  Role? role; // nullable

  User({
    required this.name,
    required this.age,
    this.role,
  });

  void viewProducts() {
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

class AdminUser extends User {
  AdminUser({required String name, required int age})
      : super(name: name, age: age, role: Role.admin);

  void addProductToUser(User targetUser, Product productToAdd) {
    try {
      if (!productToAdd.inStock) {
        throw OutOfStockException('${productToAdd.productName} tidak tersedia.');
      }

      targetUser.products ??= <Product>[];

      final uniqueSet = Set<Product>.from(targetUser.products!);
      if (uniqueSet.add(productToAdd)) {
        targetUser.products = uniqueSet.toList();
        print('Admin $name menambahkan ${productToAdd.productName} ke ${targetUser.name}.');
      } else {
        print('Produk ${productToAdd.productName} sudah ada di daftar ${targetUser.name}.');
      }
    } on OutOfStockException catch (e) {
      print('Gagal menambahkan produk: $e');
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  void removeProductFromUser(User targetUser, String productName) {
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
      : super(name: name, age: age, role: Role.customer);
}
class OutOfStockException implements Exception {
  final String message;
  OutOfStockException(this.message);

  @override
  String toString() => "OutOfStockException: $message";
}
class ProductCatalog {
  final Map<String, Product> _catalog = {};

  void addProduct(Product p) {
    _catalog[p.productName] = p;
  }

  Product? getByName(String name) => _catalog[name];

  void printCatalog() {
    print('--- Katalog Produk ---');
    if (_catalog.isEmpty) {
      print('(kosong)');
      return;
    }
    _catalog.forEach((k, v) => print(' - $v'));
  }
}

Future<Product> fetchProductDetails(ProductCatalog catalog, String productName) async {
  await Future.delayed(Duration(seconds: 1)); // simulasi delay
  final product = catalog.getByName(productName);
  if (product == null) throw Exception('Produk "$productName" tidak ditemukan.');
  return product;
}

Future<void> main() async {
  // Buat katalog
  final catalog = ProductCatalog();
  catalog.addProduct(Product(productName: 'ES Cendol', price: 12000, inStock: true));
  catalog.addProduct(Product(productName: 'MacHot', price: 8000, inStock: true));
  catalog.addProduct(Product(productName: 'Kripik Amo', price: 10000, inStock: false));

  catalog.printCatalog();

  // Buat pengguna
  final admin = AdminUser(name: 'Serly', age: 21);
  final customer = CustomerUser(name: 'Arya', age: 22);
  customer.products = [];

  // Admin menambah produk
  final cendol = catalog.getByName('Es Cendol')!;
  admin.addProductToUser(customer, cendol);

  final kripik = catalog.getByName('Kripik Amo')!;
  admin.addProductToUser(customer, kripik); // stok habis -> exception

  customer.viewProducts();

  // Hapus produk
  admin.removeProductFromUser(customer, 'Es Cendol');
  customer.viewProducts();

  // Tes fungsi async
  try {
    print('\nMengambil detail produk MacHot...');
    final macHot = await fetchProductDetails(catalog, 'MacHot');
    print('Detail produk: $macHot');
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

