import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/helper/seller_api_helper.dart';

import '../../Package/PackageConstants.dart';
import '../../Screen/Auth/company_details.dart';

class SignupController {
  // for accessing data of every stage
  static final SignupController _instance = SignupController._internal();

  factory SignupController() {
    return _instance;
  }

  SignupController._internal();
  bool onClicked = false; // to prevent from multiple clicks
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // stage 1
  final firstNameCtr = TextEditingController();
  final lastNameCtr = TextEditingController();
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

    if (formKey1.currentState!.validate() && !onClicked) {
      onClicked = true;
      if (!isTermsAccepted) {
        toast("Please accept Terms and Conditons!");
        return;
      }
      Navigation.pushMaterial(CompanyDetails());
    }
    onClicked = false;
  }

  void onSubmit2(WidgetRef ref) async {
    if (formKey2.currentState!.validate() && !onClicked) {
      onClicked = true;
      changeIsLoadingSingup(ref, true);

      //  call signup seller api
      final apiHelper = SellerApiHelper();
      await apiHelper.sellerSignup(
          firstNameCtr.text,
          lastNameCtr.text,
          emailCtr.text,
          pwdCtr.text,
          "https://img.freepik.com/premium-vector/minimalist-type-creative-business-logo-template_1283348-59417.jpg?semt=ais_hybrid",
          companyAddCtr.text,
          phoneNumberCtr.text,
          pancardNumberCtr.text,
          "2002-02-02",
          companyNameCtr.text,
          companyDescriptionCtr.text,
          gstNumberCtr.text);
      changeIsLoadingSingup(ref, false);
      onClicked = false;
    }
  }

  // called when controller no longer neeed
  void resetAll() {
    firstNameCtr.clear();
    lastNameCtr.clear();
    emailCtr.clear();
    pwdCtr.clear();
    confirmPwdCtr.clear();
    companyNameCtr.clear();
    companyAddCtr.clear();
    companyDescriptionCtr.clear();
    phoneNumberCtr.clear();
    pancardNumberCtr.clear();
    gstNumberCtr.clear();
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

// obsecure text provider
final isLoadingSignupProvider = StateProvider<bool>((ref) => false);

void changeIsLoadingSingup(WidgetRef ref, bool val) {
  ref.read(isLoadingSignupProvider.notifier).state = val;
}
