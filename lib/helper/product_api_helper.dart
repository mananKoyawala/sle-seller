import 'dart:convert';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/api/api_service.dart';
import 'package:sle_seller/models/Product.dart';
import 'package:sle_seller/provider/shared_preference.dart';

class ProductApiHelper {
  ApiService apiService = ApiService();
  SharedPreference pref = SharedPreference();

  Future<void> addProduct(String name, category, brand, description, image,
      seller_id, int quantity, int price) async {
    final response = await apiService.addProduct(
        name, category, brand, description, image, seller_id, quantity, price);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // final data = responseBody["data"] ?? '';
      // final Product product = Product.fromJson(data);
      // printDebug(">>>${product.name}");
      toast("Product added.");
      Navigation.pop();
    } else {
      final data = responseBody["error"] ?? '';
      printDebug(">>>$data");
      toast("Failed to add product");
    }
  }

  Future<List<Product>> getAllSellerProducts() async {
    await Future.delayed(const Duration(milliseconds: 150));
    printDebug(">>>seller_id ${pref.id}");

    final response = await apiService.getAllProductsBySeller(pref.id);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final dataList = responseBody["data"] as List<dynamic>? ?? [];
      final List<Product> products =
          dataList.map((data) => Product.fromJson(data)).toList();

      printDebug(">>>${products.length}");
      return products;
    } else {
      final data = responseBody["error"] ?? '';
      printDebug(">>>$data");
      return [];
    }
  }
}