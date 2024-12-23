import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sle_seller/Package/TextFormField.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/models/Product.dart';
import 'package:sle_seller/provider/edit_product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Package/PackageConstants.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends ConsumerWidget
    with text_with_button, formField, utils {
  EditProductScreen({super.key, required this.product});
  final Product product;
  bool called = false;
  EditProductController ctr = EditProductController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!called) {
      ctr.changeCategory(product.category);
      ctr.changeDetails(product.name, product.description, product.brand,
          product.quantity, product.price);
      called = true;
    }
    final isLoading = ref.watch(editProductProvider);
    final isImageUploading = ref.watch(editProductImageUploadedProvider);
    return Scaffold(
      body: CP(
        h: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            sizeH(70),
            text(
              text: "Edit Product",
              fontSize: 30,
              fontWeight: 7,
              textAlign: TextAlign.center,
            ),
            sizeH(40),
            // company details form
            Expanded(
              child: Form(
                key: ctr.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.fieldRequired(val),
                        controller: ctr.productNameCtr,
                        isborder: false,
                        hintText: "Product name",
                        labelText: "Product name",
                        maxLength: 20,
                        textInputType: TextInputType.text,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text(text: "Select Category", fontSize: 18),
                            sizeH10(),
                            CustomDropdown.search(
                                items: ctr.productCategories,
                                initialItem: ctr.category,
                                overlayHeight: 500,
                                onChanged: (val) {
                                  ctr.changeCategory(val!);
                                })
                          ],
                        ),
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.fieldRequired(val),
                        controller: ctr.productBrandCtr,
                        isborder: false,
                        hintText: "Product brand name",
                        labelText: "Product brand name",
                        maxLength: 200,
                        textInputType: TextInputType.text,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.fieldRequired(val),
                        controller: ctr.productDescriptionCtr,
                        isborder: false,
                        hintText: "Product description",
                        labelText: "Product description",
                        maxLength: 200,
                        textInputType: TextInputType.text,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.onlyNumber(val),
                        controller: ctr.productQuantityCtr,
                        isborder: false,
                        hintText: "Product quantity",
                        labelText: "Product quantity",
                        textInputType: TextInputType.number,
                        maxLength: 10,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.onlyNumber(val),
                        controller: ctr.productPriceCtr,
                        isborder: false,
                        hintText: "Product price per piece",
                        labelText: "Product price per piece",
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 10,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      text(
                          text: "Select only image if you want to change",
                          fontSize: 14,
                          fontWeight: 5),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => null,
                        prefixIcon:
                            const Icon(Icons.image, color: Colors.green),
                        isborder: true,
                        hintText: ctr.image == null
                            ? "Pick profile picture"
                            : "Image is picked",
                        readOnly: true,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                        onTap: () async {
                          final XFile? pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery);

                          if (pickedFile != null) {
                            ctr.image = File(pickedFile.path);
                            printDebug(">>>${ctr.image}");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            sizeH(40),
            CP(
              v: 16,
              child: Visibility(
                visible: visibility(),
                child: simpleButton(
                    onTap: () {
                      ctr.onSubmit(product.id, product.image_url, ref);
                    },
                    title: text(
                      text: isImageUploading
                          ? 'Image being uploaded...'
                          : isLoading
                              ? "Processing..."
                              : "Edit Product Details",
                      fontSize: 18,
                      fontWeight: 5,
                      textColor: Colors.white,
                    ),
                    backgroundColor: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
