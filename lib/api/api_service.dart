import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String baseURL = dotenv.env['API_URL'] ?? '';

  Future<http.Response> sellerLogin(String email, password) async {
    return await http.post(
      Uri.parse('$baseURL/sellers/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {'s_email': email, 's_password': password},
      ),
    );
  }

  Future<http.Response> sellerSignup(
      String first_name,
      last_name,
      email,
      password,
      image_url,
      address,
      phone,
      pan_card,
      dob,
      company_name,
      description,
      gst_number) async {
    return await http.post(
      Uri.parse('$baseURL/sellers/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          's_first_name': first_name,
          's_last_name': last_name,
          's_email': email,
          's_password': password,
          's_image_url': image_url,
          's_address': address,
          's_phone': phone,
          's_pan_card': pan_card,
          's_dob': dob,
          's_company_name': company_name,
          's_description': description,
          's_gst_number': gst_number,
        },
      ),
    );
  }

  Future<http.Response> sellerUpdatePassword(
      String email, password, confirmPassword) async {
    return await http.patch(
      Uri.parse('$baseURL/sellers'),
      body: jsonEncode(
        {
          's_email': email,
          's_password': password,
          's_confirm_password': confirmPassword
        },
      ),
      headers: {"Content-Type": "application/json"},
    );
  }

  Future<http.Response> sellerDeleteAccount(String id) async {
    return await http.delete(
      Uri.parse('$baseURL/sellers/$id'),
    );
  }

  Future<http.Response> addProduct(String name, category, brand, description,
      image, seller_id, int quantity, price) async {
    return await http.post(Uri.parse('$baseURL/products'),
        body: jsonEncode({
          'p_name': name,
          'p_category': category,
          'p_brand': brand,
          'p_description': description,
          'p_image': image,
          'p_price': price,
          'p_quantity': quantity,
          's_id': seller_id,
        }),
        headers: {"Content-Type": "application/json"});
  }

  Future<http.Response> getProductByID(String product_id) async {
    return await http.get(Uri.parse('$baseURL/products/$product_id'));
  }

  Future<http.Response> deleteProduct(String product_id) async {
    return await http.delete(Uri.parse('$baseURL/products/$product_id'));
  }

  Future<http.Response> getAllProductsBySeller(String seller_id) async {
    return await http
        .get(Uri.parse('$baseURL/products/category?s_id=$seller_id'));
  }

  Future<http.Response> updateProductDetails(String product_id, name, category,
      brand, description, image, seller_id, int quantity, price) async {
    return await http.put(Uri.parse('$baseURL/products/$product_id'),
        body: jsonEncode({
          'p_name': name,
          'p_category': category,
          'p_brand': brand,
          'p_description': description,
          'p_image': image,
          'p_price': price,
          'p_quantity': quantity,
          's_id': seller_id,
        }),
        headers: {"Content-Type": "application/json"});
  }

  Future<http.Response> changeProductStatus(String product_id) async {
    return await http.patch(Uri.parse('$baseURL/products/$product_id'));
  }
}
