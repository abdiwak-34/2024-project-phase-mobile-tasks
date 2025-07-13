import 'dart:io';

class Product {
  String name;
  String description;
  double price;
  Product({
    required this.name,
    required this.description,
    required this.price,
  });
}

class Product_Manager {
  List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
  }

  void listProducts() {
    for (var product in products) {
      print('Name: ${product.name}');
      print('Description: ${product.description}');
      print('Price: \$${product.price}');
      print('-------------------');
    }
  }

  void singleProduct(String name) {
    for (var product in products) {
      if (product.name == name) {
        print('Name: ${product.name}');
        print('Description: ${product.description}');
        print('Price: \$${product.price}');
        return;
      }
    }
    print('Product not found');
  }

  void updateProduct(String name, {String? newName, String? newDescription, double? newPrice}) {
    for (var product in products) {
      if (product.name == name) {
        if (newName != null && newName.isNotEmpty) product.name = newName;
        if (newDescription != null && newDescription.isNotEmpty) product.description = newDescription;
        if (newPrice != null) product.price = newPrice;
        print('Product updated successfully');
        return;
      }
    }
    print('Product not found');
  }

  void deleteProduct(String name) {
    products.removeWhere((product) => product.name == name);
    print('Product deleted successfully');
  }
}

void main() {
  Product_Manager manager = Product_Manager();

  print("welcome to the shop");
  while (true) {
    print("1. Add Product");
    print("2. List Products");
    print("3. View Single Product");
    print("4. Update Product");
    print("5. Delete Product");
    print("6. Exit");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        print('Enter product name:');
        String? name = stdin.readLineSync();
        if (name == null || name.trim().isEmpty) {
          print('Invalid input for name');
          break;
        }
        print('Enter product description:');
        String? description = stdin.readLineSync();
        if (description == null || description.trim().isEmpty) {
          print('Invalid input for description');
          break;
        }
        print('Enter product price:');
        String? priceInput = stdin.readLineSync();
        double? price = double.tryParse(priceInput ?? '');
        if (price == null) {
          print('Invalid input for price');
          break;
        }
        manager.addProduct(Product(name: name, description: description, price: price));
        print('Product added successfully');
        break;
      case '2':
        manager.listProducts();
        break;
      case '3':
        print('Enter product name to view:');
        String? viewName = stdin.readLineSync();
        if (viewName != null && viewName.trim().isNotEmpty) {
          manager.singleProduct(viewName);
        } else {
          print('Invalid input');
        }
        break;
      case '4':
        print('Enter product name to update:');
        String? updateName = stdin.readLineSync();
        if (updateName != null && updateName.trim().isNotEmpty) {
          print('Enter new name (or press Enter to skip):');
          String? newName = stdin.readLineSync();
          if (newName != null && newName.trim().isEmpty) newName = null;
          print('Enter new description (or press Enter to skip):');
          String? newDescription = stdin.readLineSync();
          if (newDescription != null && newDescription.trim().isEmpty) newDescription = null;
          print('Enter new price (or press Enter to skip):');
          String? newPriceInput = stdin.readLineSync();
          double? newPrice = (newPriceInput != null && newPriceInput.trim().isNotEmpty)
              ? double.tryParse(newPriceInput)
              : null;
          manager.updateProduct(updateName, newName: newName, newDescription: newDescription, newPrice: newPrice);
        } else {
          print('Invalid input');
        }
        break;
      case '5':
        print('Enter product name to delete:');
        String? deleteName = stdin.readLineSync();
        if (deleteName != null && deleteName.trim().isNotEmpty) {
          manager.deleteProduct(deleteName);
        } else {
          print('Invalid input');
        }
        break;
      case '6':
        exit(0);
      default:
        print('Invalid choice, please try again.');
    }
  }
}
