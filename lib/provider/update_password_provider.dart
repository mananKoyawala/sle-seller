import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/Package/PackageConstants.dart';

class UpdatePasswordController {
  final formKey = GlobalKey<FormState>();
  final pwdCtr = TextEditingController();
  final confirmPwdCtr = TextEditingController();

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      toast("Validate successfull");
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
