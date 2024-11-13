import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/helper/product_api_helper.dart';
import 'package:sle_seller/provider/home_provider.dart';
import 'package:sle_seller/provider/shared_preference.dart';

class EditProductController {
  bool isClicked = false;
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

  void onSubmit(String productId, String image_url, WidgetRef ref) async {
    ProductApiHelper helper = ProductApiHelper();
    SharedPreference pref = SharedPreference();
    if (formKey.currentState!.validate() && !isClicked) {
      isClicked = true;
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

  void resetAll() {
    productNameCtr.clear();
    productBrandCtr.clear();
    productDescriptionCtr.clear();
    productQuantityCtr.clear();
    productPriceCtr.clear();
  }
}

final editProductProvider = StateProvider<bool>((ref) {
  return false;
});

void changeEditProductProvider(WidgetRef ref, bool val) {
  ref.read(editProductProvider.notifier).state = val;
}
