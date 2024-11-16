import 'package:flutter/material.dart';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/Package/TextFormField.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/Service/NavigatorKey.dart';
import 'package:sle_seller/provider/Auth/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/widget/no_internet.dart';

class Login extends ConsumerWidget with text_with_button, formField, utils {
  Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctr = ref.read(loginControllerProvider);
    var isObsecure = ref.watch(obsecureTextProvider);
    var isLoading = ref.watch(isLoadingProvider);
    return Column(
      children: [
        Form(
          key: ctr.formKey,
          child: Column(
            children: [
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
                  textInputAction: TextInputAction.done,
                  fieldColor: Colors.green,
                  onClickColor: Colors.green,
                  suffixIcon: InkWell(
                    onTap: () {
                      changeObsecureText(ref);
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
            ],
          ),
        ),
        sizeH(60),
        simpleButton(
            onTap: () async {
              ctr.onSubmit(ref);
            },
            title: text(
              text: isLoading ? "Processing..." : "LOGIN",
              fontSize: 18,
              fontWeight: 5,
              textColor: Colors.white,
            ),
            backgroundColor: Colors.green),
        sizeH10(),
        simpleButton(
            onTap: () async {
              showNoInternetDialog(
                  context: navigatorContext,
                  onPressed: () {
                    Navigation.pop();
                    printDebug(">>>King called");
                  });
            },
            title: text(
              text: "Test it",
              fontSize: 18,
              fontWeight: 5,
              textColor: Colors.white,
            ),
            backgroundColor: Colors.green),
        sizeH10(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(
                text: "Forget your password?",
                fontSize: 14,
                textColor: Colors.grey),
            sizeW(5),
            text(text: "Reset here", fontSize: 14, textColor: Colors.green),
          ],
        ),
      ],
    );
  }
}
