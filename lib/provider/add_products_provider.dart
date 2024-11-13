import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/helper/product_api_helper.dart';
import 'package:sle_seller/provider/shared_preference.dart';

import 'home_provider.dart';

class AddProductsController {
  var onClicked = false;
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
      onChangeAddProductProvider(ref, true);
      int quantity = int.parse(productQuantityCtr.text);
      int price = int.parse(productPriceCtr.text);
      var isAdded = await helper.addProduct(
          productNameCtr.text,
          category,
          productBrandCtr.text,
          productDescriptionCtr.text,
          "https://i.pinimg.com/564x/e1/6f/15/e16f154f2942e0f840c522a1af9566f1.jpg",
          pref.id,
          quantity,
          price);
      if (isAdded) {
        // it will fetch data if product wiil be delete
        ref.read(productsProvider.notifier).fetchData();
      }
      onChangeAddProductProvider(ref, false);
      onClicked = false;
      category = "Electronics";
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
  }
}

final isAddProductLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

void onChangeAddProductProvider(WidgetRef ref, bool val) {
  ref.read(isAddProductLoadingProvider.notifier).state = val;
}

// static const List<String> categories = [
   
//   ];