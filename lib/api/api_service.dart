import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/Service/NavigatorKey.dart';
import 'package:sle_seller/utils/constants.dart';

import '../connection/connectivity_helper.dart';
import '../utils/widget/no_internet.dart';

class ApiService {
  final String baseURL = dotenv.env['API_URL'] ?? '';

  Future<http.Response> sellerDeleteAccount(String id) async {
    return await http.delete(
      Uri.parse('$baseURL/sellers/$id'),
    );
  }

  Future<http.Response> getProductByID(String product_id) async {
    return await http.get(Uri.parse('$baseURL/products/$product_id'));
  }

  // * common function that performs final api calls which handles connectivity checks and potential exceptions
  Future<http.Response> performRequest({
    required String method,
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Function? onNoInternet, // call back for handling no internet
  }) async {
    // * check here internet connectivity
    final hasInternet = await ConnectivityHelper.hasInternetConnection();
    printDebug(">>>*$hasInternet");
    if (!hasInternet) {
      if (onNoInternet != null) {
        onNoInternet();
      } else {
        showNoInternetDialog(context: navigatorContext);
      }
      return http.Response('{"error":"No Internet Connection"}', 503);
    }
    // * prepare request
    final uri = Uri.parse('$baseURL$endpoint');
    headers ??= {'Content-Type': 'application/json'};

    http.Response response =
        http.Response('{"error":"request is failed"}', 503);
    try {
      switch (method) {
        case 'GET':
          response = await http.get(uri, headers: headers);
        case 'POST':
          response =
              await http.post(uri, headers: headers, body: jsonEncode(body));
        case 'PUT':
          response =
              await http.put(uri, headers: headers, body: jsonEncode(body));
        case 'PATCH':
          response =
              await http.patch(uri, headers: headers, body: jsonEncode(body));
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
        default:
          throw ('Unsupported HTTP method');
      }

      return response;
    } catch (e) {
      printDebug('>>>Error during API call: $e');
      showSomeThingWrongSnackBar();
      return response;
    }
  }
}
