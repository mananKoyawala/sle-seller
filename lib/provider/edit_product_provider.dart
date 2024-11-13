import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/helper/product_api_helper.dart';
import 'package:sle_seller/provider/home_provider.dart';
import 'package:sle_seller/provider/shared_preference.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Package/PackageConstants.dart';

class EditProductController {
  bool isClicked = false;
  final formKey = GlobalKey<FormState>();
  final productNameCtr = TextEditingController();
  final productDescriptionCtr = TextEditingController();
  final productBrandCtr = TextEditingController();
  final productQuantityCtr = TextEditingController();
  final productPriceCtr = TextEditingController();
  File? image;
  String image_url = "";
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

  void onSubmit(String productId, String old_image_url, WidgetRef ref) async {
    ProductApiHelper helper = ProductApiHelper();
    SharedPreference pref = SharedPreference();
    if (formKey.currentState!.validate() && !isClicked) {
      isClicked = true;
      image_url = old_image_url;
      editProductImageUploaded(ref, true);

      if (image != null) {
        // delete current image
        bool isDeleted = await _deleteImage(old_image_url);
        if (!isDeleted) {
          toast("Failed to update image, Try again later");
          isClicked = false;
          editProductImageUploaded(ref, false);
          return;
        }

        // upload new image
        bool isImageUploaded = await _uploadImage();
        if (!isImageUploaded) {
          toast("Failed to upload image");
          isClicked = false;
          editProductImageUploaded(ref, false);
          return;
        }
      }

      editProductImageUploaded(ref, false);

      changeEditProductProvider(ref, true);
      final isUpdated = await helper.updateProductDetails(
          productId,
          productNameCtr.text,
          category,
          productBrandCtr.text,
          productDescriptionCtr.text,
          image_url,
          pref.id,
          int.parse(productQuantityCtr.text),
          int.parse(productPriceCtr.text));
      if (isUpdated) {
        // if product updated fetch the products
        ref.read(productsProvider.notifier).fetchData();
      }
      changeEditProductProvider(ref, false);
      isClicked = false;
    }
  }

  void changeDetails(
      String name, String description, String brand, int quantity, int price) {
    productNameCtr.text = name;
    productDescriptionCtr.text = description;
    productBrandCtr.text = brand;
    productQuantityCtr.text = quantity.toString();
    productPriceCtr.text = price.toString();
  }

  void changeCategory(String val) {
    category = val;
  }

  Future<bool> _deleteImage(String imageUrl) async {
    try {
      // Delete the image at the given URL
      await FirebaseStorage.instance.refFromURL(imageUrl).delete();
      printDebug(">>>Image deleted successfully.");
      return true;
    } catch (e) {
      printDebug(">>>Error deleting image: $e");
      return false;
    }
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

  void resetAll() {
    productNameCtr.clear();
    productBrandCtr.clear();
    productDescriptionCtr.clear();
    productQuantityCtr.clear();
    productPriceCtr.clear();
    image = null;
    image_url = "";
  }
}

final editProductProvider = StateProvider<bool>((ref) {
  return false;
});

void changeEditProductProvider(WidgetRef ref, bool val) {
  ref.read(editProductProvider.notifier).state = val;
}

// to show image being uploaded
final editProductImageUploadedProvider = StateProvider<bool>((ref) => false);

void editProductImageUploaded(WidgetRef ref, bool val) {
  ref.read(editProductImageUploadedProvider.notifier).state = val;
}
