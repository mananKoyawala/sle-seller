import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/helper/product_api_helper.dart';
import 'package:sle_seller/provider/shared_preference.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Package/PackageConstants.dart';
import 'home_provider.dart';

class AddProductsController {
  var onClicked = false;
  File? image;
  String image_url = "";
  final formKey = GlobalKey<FormState>();
  final productNameCtr = TextEditingController();
  final productDescriptionCtr = TextEditingController();
  final productBrandCtr = TextEditingController();
  final productQuantityCtr = TextEditingController();
  final productPriceCtr = TextEditingController();
  List<String> productCategories = [
    "Footwear",
    "Grocery",
    "Food & Beverages",
    "Electronics",
    "Home & Kitchen",
    "Fashion & Clothing",
    "Health & Beauty",
    "Sports & Outdoors",
    "Toys & Games",
    "Books & Stationery",
    "Automotive",
    "Furniture",
    "Jewelry & Accessories",
    "Baby & Kids",
    "Pet Supplies",
    "Office Supplies",
    "Travel & Luggage",
    "Musical Instruments",
    "Gardening",
    "Hardware & Tools",
    "Art & Craft",
    "Software & Apps",
    "Smartphones & Tablets",
    "Computers & Laptops",
    "Cameras & Photography",
    "Gaming",
    "Hobbies & Collections",
    "Industrial & Equipments",
  ];
  String category = "Footwear";
  ProductApiHelper helper = ProductApiHelper();
  SharedPreference pref = SharedPreference();
  void onSubmit(WidgetRef ref) async {
    if (formKey.currentState!.validate() && !onClicked) {
      onClicked = true;
      if (image == null) {
        toast("Please select image");
        onClicked = false;
        return;
      }

      int quantity = int.parse(productQuantityCtr.text);
      int price = int.parse(productPriceCtr.text);

      addProductImageUploaded(ref, true);

      bool isImageUploaded = await _uploadImage();
      if (!isImageUploaded) {
        toast("Failed to upload image");
        onClicked = false;
        addProductImageUploaded(ref, false);
        return;
      }

      addProductImageUploaded(ref, false);
      onChangeAddProductProvider(ref, true);
      var isAdded = await helper.addProduct(
          productNameCtr.text,
          category,
          productBrandCtr.text,
          productDescriptionCtr.text,
          image_url,
          pref.id,
          quantity,
          price);
      if (isAdded) {
        // it will fetch data if product wiil be delete
        ref.read(productsProvider.notifier).fetchData();
      }

      onChangeAddProductProvider(ref, false);
      onClicked = false;
      category = "Footwear";
      resetAll();
    }
  }

  void changeCategory(String val) {
    category = val;
  }

  void resetAll() {
    productNameCtr.clear();
    productDescriptionCtr.clear();
    productQuantityCtr.clear();
    productPriceCtr.clear();
    productBrandCtr.clear();
    image_url = "";
  }

  Future<bool> _uploadImage() async {
    if (image == null) return false;

    try {
      // Define a unique path for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('sle/products/$fileName');

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
}

final isAddProductLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

void onChangeAddProductProvider(WidgetRef ref, bool val) {
  ref.read(isAddProductLoadingProvider.notifier).state = val;
}

// to show image being uploaded
final addProductImageUploadedProvider = StateProvider<bool>((ref) => false);

void addProductImageUploaded(WidgetRef ref, bool val) {
  ref.read(addProductImageUploadedProvider.notifier).state = val;
}
