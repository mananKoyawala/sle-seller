import 'package:flutter/material.dart';
import 'package:sle_seller/Package/TextFormField.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/provider/Auth/signup_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Package/PackageConstants.dart';

class CompanyDetails extends ConsumerWidget
    with text_with_button, formField, utils {
  CompanyDetails({super.key});
  SignupController ctr = SignupController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isLoading = ref.watch(isLoadingSignupProvider);

    return Scaffold(
      body: CP(
        h: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            sizeH(70),
            text(
                text: "Company Details",
                fontSize: 40,
                fontWeight: 7,
                textAlign: TextAlign.center,
                fontFamily: "great-vibes"),
            sizeH(40),
            // company details form
            Expanded(
              child: Form(
                key: ctr.formKey2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.fieldRequired(val),
                        controller: ctr.companyNameCtr,
                        isborder: false,
                        hintText: "Company name",
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
                        maxLength: 10,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.validatePanCard(val),
                        controller: ctr.pancardNumberCtr,
                        isborder: false,
                        hintText: "Pancard number",
                        textInputType: TextInputType.text,
                        maxLength: 10,
                        fieldColor: Colors.green,
                        onClickColor: Colors.green,
                      ),
                      sizeH25(),
                      textFormField(
                        context: context,
                        funValidate: (val) => Validator.validateGSTNumber(val),
                        controller: ctr.gstNumberCtr,
                        isborder: false,
                        hintText: "GST number (optional)",
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        maxLength: 14,
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
                      ctr.onSubmit2(ref);
                    },
                    title: text(
                      text: isLoading ? "Processing..." : "SING UP",
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
