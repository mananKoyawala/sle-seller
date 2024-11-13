import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/Package/TextFormField.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/provider/Auth/signup_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends ConsumerWidget with text_with_button, formField, utils {
  Signup({super.key});

  SignupController ctr = SignupController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isObsecure = ref.watch(obsecureSingupTextProvider);
    var isTermsAccepted = ref.watch(termsAndConditionProvider);
    Future<void> datePicker(BuildContext context) async {
      DateTime? picked = await showDatePicker(
          context: context,
          firstDate: DateTime(1960),
          lastDate: DateTime(2019));

      if (picked != null) {
        ctr.changeDate(picked.toString().split(" ")[0]);
      }
    }

    return Column(
      children: [
        Column(
          children: [
            Form(
              key: ctr.formKey1,
              child: Column(
                children: [
                  textFormField(
                    context: context,
                    funValidate: (val) => Validator.fieldRequired(val),
                    controller: ctr.firstNameCtr,
                    isborder: true,
                    hintText: "First name",
                    textInputType: TextInputType.text,
                    fieldColor: Colors.green,
                    onClickColor: Colors.green,
                  ),
                  sizeH25(),
                  textFormField(
                    context: context,
                    funValidate: (val) => Validator.fieldRequired(val),
                    controller: ctr.lastNameCtr,
                    isborder: true,
                    hintText: "Last name",
                    textInputType: TextInputType.text,
                    fieldColor: Colors.green,
                    onClickColor: Colors.green,
                  ),
                  sizeH25(),
                  textFormField(
                    context: context,
                    funValidate: (val) => Validator.validateEmail(val),
                    controller: ctr.emailCtr,
                    isborder: true,
                    hintText: "Email",
                    textInputType: TextInputType.emailAddress,
                    fieldColor: Colors.green,
                    onClickColor: Colors.green,
                  ),
                  sizeH25(),
                  textFormField(
                      context: context,
                      funValidate: (val) => Validator.validatePassword(val),
                      controller: ctr.pwdCtr,
                      isborder: true,
                      obsecureText: isObsecure,
                      maxLines: 1,
                      hintText: "Password",
                      textInputType: TextInputType.text,
                      fieldColor: Colors.green,
                      onClickColor: Colors.green,
                      suffixIcon: InkWell(
                        onTap: () {
                          changeObsecureSingupText(ref);
                        },
                        child: isObsecure
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.green,
                              ),
                      )),
                  sizeH25(),
                  textFormField(
                    context: context,
                    funValidate: (val) =>
                        Validator.comparePassword(val, ctr.pwdCtr.text),
                    controller: ctr.confirmPwdCtr,
                    isborder: true,
                    obsecureText: isObsecure,
                    maxLines: 1,
                    hintText: "Confirm password",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    fieldColor: Colors.green,
                    onClickColor: Colors.green,
                  ),
                  sizeH25(),
                  textFormField(
                    context: context,
                    funValidate: (val) => Validator.fieldRequired(val),
                    controller: ctr.dateCtr,
                    prefixIcon:
                        const Icon(Icons.date_range, color: Colors.green),
                    isborder: true,
                    hintText: "Date of Birth",
                    readOnly: true,
                    fieldColor: Colors.green,
                    onClickColor: Colors.green,
                    onTap: () {
                      datePicker(context);
                    },
                  ),
                  sizeH25(),
                  textFormField(
                    context: context,
                    funValidate: (val) => null,
                    prefixIcon: const Icon(Icons.image, color: Colors.green),
                    isborder: true,
                    hintText: ctr.image == null
                        ? "Pick profile picture"
                        : "Image is picked",
                    readOnly: true,
                    fieldColor: Colors.green,
                    onClickColor: Colors.green,
                    onTap: () async {
                      final XFile? pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);

                      if (pickedFile != null) {
                        ctr.image = File(pickedFile.path);
                        printDebug(">>>${ctr.image}");
                      }
                    },
                  ),
                ],
              ),
            ),
            sizeH25(),
            Row(
              children: [
                Checkbox(
                  value: isTermsAccepted,
                  onChanged: (val) {
                    changeTermsAndCondition(ref);
                  },
                  activeColor: Colors.green,
                ),
                text(
                    text: "I am accepting ",
                    fontSize: 14,
                    textColor: Colors.grey),
                InkWell(
                    onTap: () {
                      final Uri url = Uri.parse(
                          "https://seamless-linkage-for-enterprises.github.io/terms-and-conditons/");
                      launchURL(url);
                    },
                    child: text(
                        text: "Terms and Conditions",
                        fontSize: 14,
                        textColor: Colors.green,
                        fontWeight: 7))
              ],
            ),
            sizeH(40),
            CP(
              v: 16,
              child: simpleButton(
                  onTap: () {
                    ctr.onSubmit(ref);
                  },
                  title: text(
                    text: "NEXT",
                    fontSize: 18,
                    fontWeight: 5,
                    textColor: Colors.white,
                  ),
                  backgroundColor: Colors.green),
            ),
            sizeH10(),
          ],
        )
      ],
    );
  }
}
