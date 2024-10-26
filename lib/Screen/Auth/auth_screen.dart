import 'package:flutter/material.dart';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/Package/RippleEffect/RippleEffectContainer.dart';
import 'package:sle_seller/Package/TextFormField.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/Screen/Auth/login.dart';
import 'package:sle_seller/Screen/Auth/signup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/provider/Auth/auth_provider.dart';

class AuthScreen extends ConsumerWidget
    with text_with_button, formField, utils {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider helps in navigate between login and signup
    var isLoginOpen = ref.watch(isLoginOpenProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: CP(
          h: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              sizeH(70),
              text(
                  text: "SLE",
                  fontSize: 40,
                  fontWeight: 7,
                  textAlign: TextAlign.center,
                  fontFamily: "great-vibes"),
              sizeH(40),
              // login and signup buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClickEffect(
                    onTap: () {
                      changeIsLoginOpen(ref);
                    },
                    borderRadius: radius(10),
                    child: CP(
                        h: 10,
                        v: 10,
                        child: text(
                            text: "LOGIN",
                            fontSize: 20,
                            fontWeight: 5,
                            textColor: isLoginOpen
                                ? Colors.green
                                : Colors.green[200])),
                  ),
                  ClickEffect(
                    onTap: () {
                      changeIsLoginOpen(ref);
                    },
                    borderRadius: radius(10),
                    child: CP(
                        h: 10,
                        v: 10,
                        child: text(
                            text: "SIGNUP",
                            fontSize: 20,
                            fontWeight: 5,
                            textColor: isLoginOpen
                                ? Colors.green[200]
                                : Colors.green)),
                  )
                ],
              ),
              sizeH(40),
              // form
              isLoginOpen ? Login() : Signup(),
            ],
          ),
        ),
      ),
    );
  }
}
