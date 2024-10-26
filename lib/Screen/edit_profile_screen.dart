import 'package:flutter/material.dart';
import 'package:sle_seller/Package/TextFormField.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/provider/edit_profile.dart';

import '../../Package/PackageConstants.dart';

class EditProfile extends StatelessWidget
    with text_with_button, formField, utils {
  EditProfile({super.key});
  EditProfileController ctr = EditProfileController();
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
              text: "Edit Profile",
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
                        controller: ctr.nameCtr,
                        isborder: false,
                        hintText: "Full name",
                        maxLength: 20,
                        textInputType: TextInputType.text,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.fieldRequired(val),
                        controller: ctr.companyAddCtr,
                        isborder: false,
                        hintText: "Company address",
                        maxLength: 200,
                        textInputType: TextInputType.text,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.fieldRequired(val),
                        controller: ctr.companyDescriptionCtr,
                        isborder: false,
                        hintText: "Description about company",
                        textInputType: TextInputType.text,
                        maxLength: 200,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) =>
                            Validator.validatePhoneNumber(val),
                        controller: ctr.phoneNumberCtr,
                        isborder: false,
                        hintText: "Phone number",
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
                      text: "Update",
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
