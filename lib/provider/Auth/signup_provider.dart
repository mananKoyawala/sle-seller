import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/Screen/dashboard.dart';

import '../../Package/PackageConstants.dart';
import '../../Screen/Auth/company_details.dart';

class SignupController {
  // for accessing data of every stage
  static final SignupController _instance = SignupController._internal();

  factory SignupController() {
    return _instance;
  }

  SignupController._internal();

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // stage 1
  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final pwdCtr = TextEditingController();
  final confirmPwdCtr = TextEditingController();
  // stage 2
  final companyNameCtr = TextEditingController();
  final companyAddCtr = TextEditingController();
  final companyDescriptionCtr = TextEditingController();
  final phoneNumberCtr = TextEditingController();
  final pancardNumberCtr = TextEditingController();
  final gstNumberCtr = TextEditingController();

  void onSubmit(WidgetRef ref) {
    var isTermsAccepted = ref.watch(termsAndConditionProvider);

    if (formKey1.currentState!.validate()) {
      if (!isTermsAccepted) {
        toast("Please accept Terms and Conditons!");
        return;
      }
      Navigation.pushMaterial(CompanyDetails());
    }
  }

  void onSubmit2() {
    if (formKey2.currentState!.validate()) {
      Navigation.pushMaterial(Dashboard());
      toast("GG");
      printDebug(">>>Name ${nameCtr.text} Company name ${companyNameCtr.text}");
    }
  }

  // called when controller no longer neeed
  void dispose() {
    nameCtr.dispose();
    emailCtr.dispose();
    pwdCtr.dispose();
    confirmPwdCtr.dispose();
    companyNameCtr.dispose();
    companyAddCtr.dispose();
    companyDescriptionCtr.dispose();
    phoneNumberCtr.dispose();
    pancardNumberCtr.dispose();
    gstNumberCtr.dispose();
  }
}

// check the terms and conditons
final termsAndConditionProvider = StateProvider<bool>((ref) => false);

void changeTermsAndCondition(WidgetRef ref) {
  ref.read(termsAndConditionProvider.notifier).state =
      !ref.read(termsAndConditionProvider);
}

// obsecure text
final obsecureSingupTextProvider = StateProvider<bool>((ref) => true);

void changeObsecureSingupText(WidgetRef ref) {
  ref.read(obsecureSingupTextProvider.notifier).state =
      !ref.read(obsecureSingupTextProvider);
}
