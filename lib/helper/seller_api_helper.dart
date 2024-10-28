import 'dart:convert';
import 'package:sle_seller/Screen/Auth/auth_screen.dart';
import 'package:sle_seller/Screen/dashboard.dart';
import 'package:sle_seller/provider/Auth/signup_provider.dart';
import 'package:sle_seller/provider/shared_preference.dart';

import '../Package/PackageConstants.dart';
import '../api/api_service.dart';
import '../models/seller.dart';

class SellerApiHelper {
  SharedPreference pref = SharedPreference();
  final apiService = ApiService();
  SignupController signupController = SignupController();

  Future<void> sellerLogin(String email, password) async {
    var response = await apiService.sellerLogin(email, password);

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
          seller.description,
          seller.gst_number);
      await pref.getUserData();
      await Future.delayed(const Duration(milliseconds: 150));
      toast("User login successful.");
      Navigation.pushMaterialAndRemoveUntil(const Dashboard());
    } else {
      final responseBody = jsonDecode(response.body);
      final data = responseBody['error'] ?? 'Failed to login';
      printDebug(">>>$data");
      toast('Invalid email or password');
    }
  }

  Future<void> sellerSignup(
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
    var response = await apiService.sellerSignup(
        first_name,
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
        gst_number);

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
          seller.description,
          seller.gst_number);
      await pref.getUserData();
      await Future.delayed(const Duration(milliseconds: 150));
      toast("Registration completed");
      Navigation.pushMaterialAndRemoveUntil(const Dashboard());
    } else {
      final data = responseBody['error'] ?? 'Failed to register seller';
      printDebug(">>>$data");
      if (data.toString().contains("duplicate key")) {
        toast("Email address already exist");
        return;
      }
      toast('Failed to register seller');
    }
  }

  Future<void> sellerUpdatePassword(
      String email, password, confirmPassword) async {
    final response =
        await apiService.sellerUpdatePassword(email, password, confirmPassword);
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

  Future<void> sellerDeleteAccount(String id) async {
    final response = await apiService.sellerDeleteAccount(id);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final data = responseBody['message'] ?? 'null';
      toast(data.toString());
      Navigation.pushMaterialAndRemoveUntil(const AuthScreen());
    } else {
      final data = responseBody['error'] ?? 'Failed to delete account';
      printDebug(">>>$data");
      toast('Failed to delete account');
    }
  }
}
