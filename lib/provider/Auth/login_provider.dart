import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/Package/PackageConstants.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final pwdCtr = TextEditingController();

  // Dispose method to be called when this controller is no longer needed
  void dispose() {
    emailCtr.dispose();
    pwdCtr.dispose();
  }

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      toast("validation completed");
    }
  }
}

// obsecure text provider
final obsecureTextProvider = StateProvider<bool>((ref) => true);

void changeObsecureText(WidgetRef ref) {
  ref.read(obsecureTextProvider.notifier).state =
      !ref.read(obsecureTextProvider);
}
