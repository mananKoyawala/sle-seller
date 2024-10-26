import 'package:flutter/material.dart';

import '../Package/PackageConstants.dart';

class EditProductController {
  final formKey = GlobalKey<FormState>();
  final productNameCtr = TextEditingController();
  final productDescriptionCtr = TextEditingController();
  final productPiecesCtr = TextEditingController();
  final productPriceCtr = TextEditingController();

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      toast("validate");
    }
  }

  void onDispose() {
    productNameCtr.dispose();
    productDescriptionCtr.dispose();
    productPiecesCtr.dispose();
    productPriceCtr.dispose();
  }
}
