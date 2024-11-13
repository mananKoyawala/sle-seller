import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/helper/seller_api_helper.dart';

import '../../Package/PackageConstants.dart';
import '../../Screen/Auth/company_details.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../Screen/dashboard.dart';

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
  File? image;
  String image_url = "";
  bool isSignedup = false;
  // stage 1
  final firstNameCtr = TextEditingController();
  final lastNameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final pwdCtr = TextEditingController();
  final confirmPwdCtr = TextEditingController();
  final dateCtr = TextEditingController();
  // stage 2
  final companyNameCtr = TextEditingController();
  final companyAddCtr = TextEditingController();
  final companyDescriptionCtr = TextEditingController();
  final phoneNumberCtr = TextEditingController();
  final pancardNumberCtr = TextEditingController();
  final gstNumberCtr = TextEditingController();

  changeDate(String val) {
    dateCtr.text = val;
  }

  void onSubmit(WidgetRef ref) {
    var isTermsAccepted = ref.watch(termsAndConditionProvider);

    if (formKey1.currentState!.validate() && !onClicked) {
      onClicked = true;
      // check image picked
      if (image == null) {
        toast("Please select image");
        return;
      }
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
      // changeIsLoadingSingup(ref, true);

      //  call signup seller api
      final apiHelper = SellerApiHelper();
      //  add image to firebase
      // changeIsLoadingSingup(ref, false);

      changeSignupImageUploaded(ref, true);
      bool isImageUploaded = await _uploadImage();
      if (!isImageUploaded) {
        toast("Failed to upload image");
        onClicked = false;
        changeSignupImageUploaded(ref, false);
        return;
      }
      changeSignupImageUploaded(ref, false);

      changeIsLoadingSingup(ref, true);

      isSignedup = await apiHelper.sellerSignup(
          firstNameCtr.text,
          lastNameCtr.text,
          emailCtr.text.toLowerCase(),
          pwdCtr.text,
          image_url,
          companyAddCtr.text,
          phoneNumberCtr.text,
          pancardNumberCtr.text,
          dateCtr.text,
          companyNameCtr.text,
          companyDescriptionCtr.text,
          gstNumberCtr.text);
      if (isSignedup) {
        // move to home page
        Navigation.pushMaterialAndRemoveUntil(Dashboard());
      }
      changeIsLoadingSingup(ref, false);
      onClicked = false;
    }
    // reset all controller with caution
    if (isSignedup) {
      await Future.delayed(const Duration(milliseconds: 600));
      resetAll();
    }
  }

  Future<bool> _uploadImage() async {
    if (image == null) return false;

    try {
      // Define a unique path for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('sle/seller/$fileName');

      // Upload the file
      await firebaseStorageRef.putFile(image!);

      // Get the download URL
      image_url = await firebaseStorageRef.getDownloadURL();
      printDebug(">>>Image uploaded successfully. Download URL: $image_url");
      return true;
    } catch (e) {
      printDebug(">>>Error uploading image: $e");
      return false;
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
    dateCtr.clear();
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

final isSignupImageUploadedProvider = StateProvider<bool>((ref) => false);

void changeSignupImageUploaded(WidgetRef ref, bool val) {
  ref.read(isSignupImageUploadedProvider.notifier).state = val;
}
