import 'dart:convert';

import 'package:show_product_app/models/products.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Products>> fetchProducts() async {
    const String url = 'https://fakestoreapi.com/products';

    try {
      final responce = await http.get(Uri.parse(url));

      if (responce.statusCode == 200) {
        List<dynamic> responseDate = jsonDecode(responce.body);
        List<Products> products = responseDate.map((json) {
          return Products.fromJson(json);
        }).toList();
        return products;
      } else {
        throw Exception('faill to fetch products');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Products> feathchSingleProduct(int id) async {
    String url = 'https://fakestoreapi.com/products/$id';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Products product = Products.fromJson(jsonDecode(response.body));
        return product;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Products> addNewProduct(Products product) async {
    String url = 'https://fakestoreapi.com/products';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 200) {
        print(response.body);
        Products newProduct = Products.fromJson(json.decode(response.body));
        return newProduct;
      } else {
        print('faill add product');
        throw Exception('faill add product ');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  
}
