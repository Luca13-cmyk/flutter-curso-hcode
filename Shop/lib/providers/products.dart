import 'dart:convert';
// import 'dart:math';

import 'package:Shop/providers/product.dart';
import 'package:flutter/foundation.dart';
// import '../data/dummy_data.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String _url =
      'https://flutter-curso-1f40e-default-rtdb.firebaseio.com/products.json';
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    final response = await http.get(_url);
    Map<String, dynamic> data = json.decode(response.body);
    _items.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        _items.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ));
      });
      notifyListeners();
    }
    return Future.value(); // Retornando valor vazio
  }

  Future<void> addProduct(Product newProduct) async {
    final response =
        await http // Espera o resultado antes de ir pra proxima linha
            .post(_url,
                body: json.encode({
                  'title': newProduct.title,
                  "description": newProduct.description,
                  "price": newProduct.price,
                  "imageUrl": newProduct.imageUrl,
                  "isFavorite": newProduct.isFavorite,
                }));
    _items.add(Product(
        id: json.decode(response.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl));
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}

// bool _showFavoriteOnly = false;

// List<Product> get items {
//   if (_showFavoriteOnly) {
//     return _items.where((product) => product.isFavorite).toList();
//   }
//  return [ ..._items ];
// }

// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }
// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
