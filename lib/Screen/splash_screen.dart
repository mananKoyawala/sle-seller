import 'package:flutter/material.dart';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/Screen/dashboard.dart';
import 'package:sle_seller/Service/NavigatorKey.dart';
import 'package:sle_seller/connection/connectivity_helper.dart';
import 'package:sle_seller/provider/shared_preference.dart';
import 'package:sle_seller/utils/widget/no_internet.dart';
import 'package:lottie/lottie.dart';
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
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation.json', // Replace with your file path
              height: 300,
              width: 300,
              repeat: true,
            ),
            const SizedBox(height: 20),
            text(
                text: "Seamless",
                fontSize: 55,
                textAlign: TextAlign.center,
                textColor: Colors.green),
            text(
                text: "Linkage for Enterprises",
                fontSize: 25,
                textAlign: TextAlign.center,
                textColor: Colors.green)
          ]),
    ));
  }
}
