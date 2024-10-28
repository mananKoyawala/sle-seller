import 'package:flutter/material.dart';
import 'package:sle_seller/Package/TextFormField.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/provider/Auth/login_provider.dart';
import 'package:sle_seller/provider/update_password_provider.dart';
import '../../Package/PackageConstants.dart';

class UpdatePasswordScreen extends ConsumerWidget
    with text_with_button, formField, utils {
  UpdatePasswordScreen({super.key});
  UpdatePasswordController ctr = UpdatePasswordController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isObsecure = ref.watch(editPasswordObseureTextProvider);
    var isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
      body: CP(
        h: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            sizeH(70),
            text(
              text: "Update Password",
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
                          funValidate: (val) => Validator.validatePassword(val),
                          controller: ctr.pwdCtr,
                          isborder: false,
                          obsecureText: isObsecure,
                          maxLines: 1,
                          hintText: "Password",
                          textInputType: TextInputType.text,
                          fieldColor: Colors.green,
                          onClickColor: Colors.green,
                          suffixIcon: InkWell(
                            onTap: () {
                              changeeditPasswordObseureText(ref);
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
                        isborder: false,
                        obsecureText: isObsecure,
                        maxLines: 1,
                        hintText: "Confirm password",
                        textInputType: TextInputType.text,
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
                      ctr.onSubmit(ref);
                    },
                    title: text(
                      text: isLoading ? "Processing..." : "Update",
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
