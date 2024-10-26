import 'package:flutter/material.dart';
import 'package:sle_seller/Package/PackageConstants.dart';

class AddProductsController {
  final formKey = GlobalKey<FormState>();
  final productNameCtr = TextEditingController();
  final productDescriptionCtr = TextEditingController();
  final productPiecesCtr = TextEditingController();
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

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      toast("validate");
      toast(category);
    }
  }

  void changeCategory(String val) {
    category = val;
  }

  void onDispose() {
    productNameCtr.dispose();
    productDescriptionCtr.dispose();
    productPiecesCtr.dispose();
    productPriceCtr.dispose();
  }
}
