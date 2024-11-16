import 'dart:convert';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/api/api_service.dart';
import 'package:sle_seller/models/Product.dart';
import 'package:sle_seller/provider/shared_preference.dart';

class ProductApiHelper {
  ApiService apiService = ApiService();
  SharedPreference pref = SharedPreference();

  Future<bool> addProduct(String name, category, brand, description, image,
      seller_id, int quantity, int price) async {
    try {
      final response = await apiService.performRequest(
        method: 'POST',
        endpoint: '/products',
        body: {
          'p_name': name,
          'p_category': category,
          'p_brand': brand,
          'p_description': description,
          'p_image': image,
          'p_price': price,
          'p_quantity': quantity,
          's_id': seller_id,
        },
      );
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        toast("Product added.");
        Navigation.pop();
        return true;
      } else {
        final error = responseBody["error"] ?? 'Unknown error occurred.';
        printDebug(">>>$error");
        toast("Failed to add product");
        return false;
      }
    } catch (e) {
      printDebug(">>> Exception: $e");
      toast("An error occurred while adding the product.");
      return false;
    }
  }

  Future<List<Product>> getAllSellerProducts() async {
    try {
      await Future.delayed(const Duration(milliseconds: 150));
      printDebug(">>>seller_id ${pref.id}");

      final response = await apiService.performRequest(
        method: 'GET',
        endpoint: '/products/category?s_id=${pref.id}',
      );
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final dataList = responseBody["data"] as List<dynamic>? ?? [];
        final products =
            dataList.map((data) => Product.fromJson(data)).toList();
        printDebug(">>>${products.length}");
        return products;
      } else {
        final error = responseBody["error"] ?? 'Unknown error occurred.';
        printDebug(">>>$error");
        return [];
      }
    } catch (e) {
      printDebug(">>> Exception: $e");
      toast("An error occurred while fetching products.");
      return [];
    }
  }

  Future<bool> deleteProduct(productId) async {
    try {
      final response = await apiService.performRequest(
        method: 'DELETE',
        endpoint: '/products/$productId',
      );
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final message = responseBody["message"] ?? 'Product deleted.';
        toast(message);
        return true;
      } else {
        final error = responseBody["error"] ?? 'Unknown error occurred.';
        toast("Failed to delete product");
        printDebug(">>>$error");
        return false;
      }
    } catch (e) {
      printDebug(">>> Exception: $e");
      toast("An error occurred while deleting the product.");
      return false;
    }
  }

  Future<bool> changeProductStatus(productId) async {
    try {
      final response = await apiService.performRequest(
        method: 'PATCH',
        endpoint: '/products/$productId',
      );
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final message = responseBody["message"] ?? 'Product status changed.';
        toast(message);
        return true;
      } else {
        final error = responseBody["error"] ?? 'Unknown error occurred.';
        toast(error);
        printDebug(">>>$error");
        return false;
      }
    } catch (e) {
      printDebug(">>> Exception: $e");
      toast("An error occurred while changing product status.");
      return false;
    }
  }

  Future<bool> updateProductDetails(String product_id, name, category, brand,
      description, image, seller_id, int quantity, price) async {
    try {
      final response = await apiService.performRequest(
        method: 'PUT',
        endpoint: '/products/$product_id',
        body: {
          'p_name': name,
          'p_category': category,
          'p_brand': brand,
          'p_description': description,
          'p_image': image,
          'p_price': price,
          'p_quantity': quantity,
          's_id': seller_id,
        },
      );
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        toast("Product details updated.");
        Navigation.pop();
        return true;
      } else {
        final error = responseBody["error"] ?? 'Unknown error occurred.';
        printDebug(">>>$error");
        toast("Failed to update product details");
        return false;
      }
    } catch (e) {
      printDebug(">>> Exception: $e");
      toast("An error occurred while updating product details.");
      return false;
    }
  }
}
