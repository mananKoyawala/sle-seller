import 'package:flutter/material.dart';
import 'package:sle_seller/Package/PackageConstants.dart';

class EditProfileController {
  final formKey = GlobalKey<FormState>();
  final firstNameCtr = TextEditingController();
  final lastNameCtr = TextEditingController();
  final companyAddCtr = TextEditingController();
  final companyDescriptionCtr = TextEditingController();
  final phoneNumberCtr = TextEditingController();

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      toast("validated");
    }
  }

  void onDispose() {
    firstNameCtr.dispose();
    lastNameCtr.dispose();
    companyAddCtr.dispose();
    companyDescriptionCtr.dispose();
    phoneNumberCtr.dispose();
  }
}
