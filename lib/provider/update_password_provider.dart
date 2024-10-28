import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/helper/seller_api_helper.dart';
import 'package:sle_seller/provider/Auth/login_provider.dart';
import 'package:sle_seller/provider/shared_preference.dart';

class UpdatePasswordController {
  final formKey = GlobalKey<FormState>();
  final pwdCtr = TextEditingController();
  final confirmPwdCtr = TextEditingController();
  SharedPreference pref = SharedPreference();

  void onSubmit(WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      changeIsLoading(ref, true);
      SellerApiHelper helper = SellerApiHelper();
      final email = await pref.getUserEmail();
      await helper.sellerUpdatePassword(email, pwdCtr.text, confirmPwdCtr.text);
      changeIsLoading(ref, false);
    }
  }

  void onDispose() {
    pwdCtr.dispose();
    confirmPwdCtr.dispose();
  }
}

final editPasswordObseureTextProvider = StateProvider<bool>((ref) {
  return true;
});

void changeeditPasswordObseureText(WidgetRef ref) {
  ref.read(editPasswordObseureTextProvider.notifier).state =
      !ref.read(editPasswordObseureTextProvider);
}
