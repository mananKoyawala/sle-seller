import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/helper/product_api_helper.dart';
import 'package:sle_seller/provider/shared_preference.dart';

class AddProductsController {
  var onClicked = false;
  final formKey = GlobalKey<FormState>();
  final productNameCtr = TextEditingController();
  final productDescriptionCtr = TextEditingController();
  final productBrandCtr = TextEditingController();
  final productQuantityCtr = TextEditingController();
  final productPriceCtr = TextEditingController();
  List<String> productCategories = [
    "Electronics",
    "Computers and laptops",
    "Smartphones and tablets",
    "Gaming consoles and accessories",
    "Audio and video equipment",
    "Cameras and photography gear",
    "Home appliances",
    "Smart home devices",
    "Fashion and Apparel",
    "Clothing for men, women, and children",
    "Footwear",
    "Accessories (bags, hats, jewelry)",
    "Beauty and personal care products",
    "Watches and eyewear",
    "Home and Garden",
    "Furniture",
    "Home decor",
    "Kitchenware",
    "Bedding and linens",
    "Appliances",
    "Gardening tools and supplies",
    "Outdoor furniture and equipment",
  ];
  String category = "Electronics";
  ProductApiHelper helper = ProductApiHelper();
  SharedPreference pref = SharedPreference();
  void onSubmit(WidgetRef ref) async {
    if (formKey.currentState!.validate() && !onClicked) {
      onClicked = true;
      onChangeAddProductProvider(ref, true);
      int quantity = int.parse(productQuantityCtr.text);
      int price = int.parse(productPriceCtr.text);
      await helper.addProduct(
          productNameCtr.text,
          category,
          productBrandCtr.text,
          productDescriptionCtr.text,
          "https://i.pinimg.com/564x/e1/6f/15/e16f154f2942e0f840c522a1af9566f1.jpg",
          pref.id,
          quantity,
          price);
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
