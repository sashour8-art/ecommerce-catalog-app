import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/category_model.dart';
import '../../models/product_model.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<CategoryModel>> getCategories() async {
    final uri = Uri.parse('$_baseUrl/products/categories');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load categories (${response.statusCode})');
    }

    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<List<ProductModel>> getProductsByCategory(String slug) async {
    final uri = Uri.parse('$_baseUrl/products/category/$slug');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load products (${response.statusCode})');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> productsJson = data['products'] ?? [];
    return productsJson.map((json) => ProductModel.fromJson(json)).toList();
  }
}