import 'dart:convert';
import 'package:sle_seller/Screen/Auth/auth_screen.dart';
import 'package:sle_seller/Screen/dashboard.dart';
import 'package:sle_seller/provider/Auth/signup_provider.dart';
import 'package:sle_seller/provider/shared_preference.dart';
import 'package:sle_seller/utils/constants.dart';

import '../Package/PackageConstants.dart';
import '../api/api_service.dart';
import '../models/seller.dart';

class SellerApiHelper {
  SharedPreference pref = SharedPreference();
  final apiService = ApiService();
  SignupController signupController = SignupController();

  Future<void> sellerLogin(String email, password) async {
    // send request to server
    var response = await apiService.performRequest(
      method: 'POST',
      endpoint: '/sellers/login',
      headers: {'Content-Type': 'application/json'},
      body: {'s_email': email, 's_password': password},
    );

    try {
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final data = responseBody['data'] ?? 'null';
        Seller seller = Seller.fromJson(data);
        // add data in shareprefernce
        pref.setIsLoggedIn(true);
        pref.setSellerData(
            seller.id,
            seller.first_name,
            seller.last_name,
            seller.email,
            seller.phone,
            seller.image_url,
            seller.pan_card,
            seller.dob,
            seller.company_name,
            seller.address,
            seller.description,
            seller.gst_number);
        await pref.getUserData();
        await Future.delayed(const Duration(
            milliseconds: 150)); // ensures data get from sharedpreference
        toast("User login successful.");
        Navigation.pushMaterialAndRemoveUntil(const Dashboard());
      } else {
        final responseBody = jsonDecode(response.body);
        final data = responseBody['error'] ?? 'Failed to login';
        printDebug(">>>$data");
        showToast(response, 'Invalid email or password');
      }
    } catch (e) {
      showSomeThingWrongSnackBar();
    }
  }

  Future<bool> sellerSignup(
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
    var response = await apiService.performRequest(
      method: 'POST',
      endpoint: '/sellers/signup',
      body: {
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
    );

    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final data = responseBody['data'] ?? 'null';
      Seller seller = Seller.fromJson(data);
      // add data in shareprefernce
      pref.setIsLoggedIn(true);
      pref.setSellerData(
          seller.id,
          seller.first_name,
          seller.last_name,
          seller.email,
          seller.phone,
          seller.image_url,
          seller.pan_card,
          seller.dob,
          seller.company_name,
          seller.address,
          seller.description,
          seller.gst_number);
      await pref.getUserData();
      await Future.delayed(const Duration(milliseconds: 150));
      toast("Registration completed");
      return true;
    } else {
      final data = responseBody['error'] ?? 'Failed to register seller';
      printDebug(">>>$data");
      if (data.toString().contains("duplicate key")) {
        toast("Email address already exist");
        return false;
      }
      toast('Failed to register seller');
      return false;
    }
  }

  Future<void> sellerUpdatePassword(
      String email, password, confirmPassword) async {
    final response = await apiService.performRequest(
      method: 'PATCH',
      endpoint: '/sellers',
      body: {
        's_email': email,
        's_password': password,
        's_confirm_password': confirmPassword
      },
    );
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final data = responseBody['message'] ?? 'null';
      toast(data.toString());
      Navigation.pop();
    } else {
      final data = responseBody['error'] ?? 'Failed to update pasword';
      printDebug(">>>$data");
      toast('Failed to update password');
    }
  }
}
