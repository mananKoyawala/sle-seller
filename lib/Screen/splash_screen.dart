import 'package:flutter/material.dart';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/Screen/dashboard.dart';
import 'package:sle_seller/Service/NavigatorKey.dart';
import 'package:sle_seller/connection/connectivity_helper.dart';
import 'package:sle_seller/provider/shared_preference.dart';
import 'package:sle_seller/utils/widget/no_internet.dart';

import 'Auth/auth_screen.dart';

class SplashScreen extends StatelessWidget with text_with_button, utils {
  const SplashScreen({super.key});

  void _navigateAfterDelay() async {
    final hasInternetConnection =
        await ConnectivityHelper.hasInternetConnection();
    if (!hasInternetConnection) {
      showNoInternetDialog(
          context: navigatorContext,
          onPressed: () {
            Navigation.pop();
            _navigateAfterDelay();
          });
      return;
    }
    await Future.delayed(const Duration(milliseconds: 1500));
    SharedPreference pref = SharedPreference();
    bool isLoggedIn = await pref.getIsLoggedIn();

    isLoggedIn
        ? Navigation.pushMaterialAndRemoveUntil(const Dashboard())
        : Navigation.pushMaterialAndRemoveUntil(const AuthScreen());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateAfterDelay();
    });
    return Scaffold(
      body: Center(
          child: text(
              text: "Splash Screen",
              fontSize: 55,
              fontFamily: "great-vibes",
              textColor: Colors.green)),
    );
  }
}
