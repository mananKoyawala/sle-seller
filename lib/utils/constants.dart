import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Package/PackageConstants.dart';
import '../Service/NavigatorKey.dart';

void showToast(http.Response response, String text) {
  if (response.statusCode != 503) {
    toast(text);
  }
}

void showSomeThingWrongSnackBar() {
  ScaffoldMessenger.of(navigatorContext).showSnackBar(const SnackBar(
    content: Text("Something went wrong, please try again later."),
  ));
}
