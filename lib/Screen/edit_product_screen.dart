import 'package:flutter/material.dart';
import 'package:sle_seller/Package/TextFormField.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/provider/edit_product_provider.dart';

import '../../Package/PackageConstants.dart';

class EditProductScreen extends StatelessWidget
    with text_with_button, formField, utils {
  EditProductScreen({super.key});
  EditProductController ctr = EditProductController();
  @override
  Widget build(BuildContext context) {
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
                    children: [
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.fieldRequired(val),
                        controller: ctr.productNameCtr,
                        isborder: false,
                        hintText: "Product name",
                        maxLength: 20,
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
                        maxLength: 200,
                        textInputType: TextInputType.text,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.onlyNumber(val),
                        controller: ctr.productPiecesCtr,
                        isborder: false,
                        hintText: "Product pieces",
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
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 10,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
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
                      ctr.onSubmit();
                    },
                    title: text(
                      text: "Edit Product Details",
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
