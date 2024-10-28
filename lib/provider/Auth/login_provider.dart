import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/helper/seller_api_helper.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final pwdCtr = TextEditingController();
  bool onClicked = false; // to prevent from multiple clicks
  // Dispose method to be called when this controller is no longer needed
  void resetAll() {
    emailCtr.clear();
    pwdCtr.clear();
  }

  void onSubmit(WidgetRef ref) async {
    if (formKey.currentState!.validate() && !onClicked) {
      onClicked = true;
      changeIsLoading(ref, true);
      // calling seller login
      final apiHelper = SellerApiHelper();
      await apiHelper.sellerLogin(emailCtr.text, pwdCtr.text);
      changeIsLoading(ref, false);
      resetAll();
      onClicked = false;
    }
  }
}

// gives a riverpod instance of logincontroller
final loginControllerProvider = Provider((ref) => LoginController());

// obsecure text provider
final obsecureTextProvider = StateProvider<bool>((ref) => true);

void changeObsecureText(WidgetRef ref) {
  ref.read(obsecureTextProvider.notifier).state =
      !ref.read(obsecureTextProvider);
}

// obsecure text provider
final isLoadingProvider = StateProvider<bool>((ref) => false);

void changeIsLoading(WidgetRef ref, bool val) {
  ref.read(isLoadingProvider.notifier).state = val;
}
