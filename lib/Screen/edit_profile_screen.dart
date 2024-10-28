import 'package:flutter/material.dart';
import 'package:sle_seller/Package/TextFormField.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/provider/edit_profile.dart';

import '../../Package/PackageConstants.dart';

class EditProfile extends StatelessWidget
    with text_with_button, formField, utils {
  EditProfile(
      {super.key,
      required this.first_name,
      required this.last_name,
      required this.company_address,
      required this.company_description,
      required this.phone});
  EditProfileController ctr = EditProfileController();
  final String first_name,
      last_name,
      company_address,
      company_description,
      phone;
  @override
  Widget build(BuildContext context) {
    ctr.firstNameCtr.text = first_name;
    ctr.lastNameCtr.text = last_name;
    ctr.companyAddCtr.text = company_address;
    ctr.companyDescriptionCtr.text = company_description;
    ctr.phoneNumberCtr.text = phone;
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
                        controller: ctr.firstNameCtr,
                        isborder: false,
                        hintText: "First name",
                        maxLength: 20,
                        textInputType: TextInputType.text,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.fieldRequired(val),
                        controller: ctr.lastNameCtr,
                        isborder: false,
                        hintText: "Last name",
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
                        labelText: "Phone number",
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
