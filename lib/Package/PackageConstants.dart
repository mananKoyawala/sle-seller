import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Package/Text_Button.dart';
import '../Package/Utils.dart';
import '../Service/NavigatorKey.dart';

Color white = Colors.white;
Color black = Colors.black;
Color transparent = Colors.transparent;
Color blackO_30 = const Color(0xFF000000).withOpacity(0.30);
Color blackO_50 = const Color(0xFF000000).withOpacity(0.50);
Color rippleColor = Colors.grey.shade500;
Color blackO7 = const Color(0xFF000000).withOpacity(0.7);
Color green = const Color(0xFF5EC401);
Color textColor1 = const Color(0xFF37474F);
Color searchColor = const Color(0xff747b84);
Color searchColor2 = const Color(0xffF4F6F9);

void printDebug(Object? val) {
  if (kDebugMode) {
    print(val);
  }
}

class Validator {
  // check for the empty fields
  static String? fieldRequired(String? val) {
    if (val == null || val.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  // email verification
  static String? validateEmail(String? val) {
    const emailPattern =
        r'^[^@\s]+@[^@\s]+\.[^@\s]+$'; // A simple regex pattern for email
    final regExp = RegExp(emailPattern);

    if (val == null || val.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(val)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // validate password
  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return 'Password is required';
    }
    // Check if length is between 6 and 10 characters
    if (val.length < 6 || val.length > 10) {
      return 'Password must be 6 to 10 characters long';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(val)) {
      return 'Required at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'^(?=.*[a-z])').hasMatch(val)) {
      return 'Required at least one lowercase letter';
    }

    // Check for at least one number
    if (!RegExp(r'^(?=.*\d)').hasMatch(val)) {
      return 'Required at least one number';
    }

    // Check for at least one special character (@, %, *, ^)
    if (!RegExp(r'^(?=.*[@%*^])').hasMatch(val)) {
      return 'Required one special character (@, %, *, ^)';
    }

    // If all conditions are met, return null (indicating the password is valid)
    return null;
  }

  static String? validatePhoneNumber(String? val) {
    const phonePattern = r'^[0-9]{10}$';
    final regExp = RegExp(phonePattern);
    if (val == null || val.isEmpty) {
      return 'Phoen number is required';
    } else if (!regExp.hasMatch(val)) {
      return 'Enter 10 digits of valid phone number';
    }
    return null;
  }

  static String? onlyNumber(String? val) {
    const phonePattern = r'^[0-9]+$';
    final regExp = RegExp(phonePattern);
    if (val == null || val.isEmpty) {
      return 'Field is required';
    } else if (!regExp.hasMatch(val)) {
      return 'Field accepts only numbers';
    }
    return null;
  }

  static String? comparePassword(String? val, String? val2) {
    if (val != val2) {
      return "Password does not match";
    }
    return null;
  }

  static String? validatePanCard(String? val) {
    const panCardPattern =
        r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$'; // A simple regex pattern for pancard
    final regExp = RegExp(panCardPattern);

    if (val == null || val.isEmpty) {
      return 'Pancard is required';
    } else if (!regExp.hasMatch(val)) {
      return 'Enter a valid pancard';
    }
    return null;
  }

  static String? validateGSTNumber(String? val) {
    const panCardPattern =
        r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1}$'; // A simple regex pattern for GST number
    final regExp = RegExp(panCardPattern);

    if (val == null) {
      return null;
    }

    if (val.isNotEmpty && !regExp.hasMatch(val)) {
      return 'Enter a valid GST number';
    }
    return null;
  }
}

class Margin extends StatelessWidget {
  const Margin({super.key, required this.margin, required this.child});
  final EdgeInsetsGeometry margin;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: margin,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: child,
    );
  }
}

class RemoveScrollViewColor extends StatelessWidget {
  const RemoveScrollViewColor({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: child,
    );
  }
}

class CP extends StatelessWidget {
  const CP({super.key, required this.child, this.h, this.v});
  final Widget child;
  final double? h; // Height
  final double? v; // Width
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h ?? 0, vertical: v ?? 0),
      child: child,
    );
  }
}

class RadioButton extends StatelessWidget with text_with_button {
  const RadioButton(
      {super.key,
      required this.label,
      this.activeColor,
      required this.onChanged,
      required this.value,
      this.groupValue});
  final String label;
  final Color? activeColor;
  final Function(String?) onChanged;
  final String value;
  final String? groupValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: activeColor ?? Colors.blue,
        ),
        text(text: label, fontSize: 16)
      ],
    );
  }
}

class Navigation {
  static pushNamed(String routeName) {
    return Navigator.pushNamed(navigatorContext, routeName);
  }

  static pushReplacementNamed(String routeName) {
    return Navigator.pushReplacementNamed(navigatorContext, routeName);
  }

  static pushNamedAndRemoveUntil(String routeName) {
    return Navigator.pushNamedAndRemoveUntil(
        navigatorContext, routeName, (Route<dynamic> route) => false);
  }

  static pushMaterial(Widget widget) {
    return Navigator.push(
        navigatorContext, MaterialPageRoute(builder: (_) => widget));
  }

  static pushMaterialReplacement(Widget widget) {
    return Navigator.pushReplacement(
        navigatorContext, MaterialPageRoute(builder: (_) => widget));
  }

  static pushMaterialAndRemoveUntil(Widget widget) {
    return Navigator.pushAndRemoveUntil(
        navigatorContext,
        MaterialPageRoute(builder: (_) => widget),
        (Route<dynamic> route) => false);
  }

  static visibility(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }

  static pop() {
    Navigator.pop(navigatorContext);
  }

  static closeDrawer() {
    Scaffold.of(navigatorContext).closeDrawer();
  }
}

toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}

class Dialogs with text_with_button, utils {
  Future<dynamic> dialogSuccess() {
    return showDialog(
        context: navigatorContext,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: radius(10)),
              backgroundColor: white,
              icon: Icon(
                Icons.check_circle,
                color: green,
                size: 65,
              ),
              content: text(
                text: 'Product Added',
                fontSize: 25,
                textColor: textColor1,
                fontWeight: 5,
                textAlign: TextAlign.center,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              actions: [
                Center(
                    child: simpleButton(
                  onTap: () {
                    Navigation.pop();
                  },
                  borderRadius: radius(10),
                  height: 45,
                  width: 175,
                  backgroundColor: green,
                  title: Text("OK",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: white)),
                )),
                const SizedBox(height: 20)
              ],
            ));
  }

  Future<dynamic> dialogEdit() {
    return showDialog(
        context: navigatorContext,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: radius(10)),
              backgroundColor: white,
              icon: const Icon(
                Icons.upcoming_rounded,
                color: Colors.blue,
                size: 65,
              ),
              content: text(
                text: 'Details are Edited!!!',
                fontSize: 25,
                textColor: textColor1,
                fontWeight: 5,
                textAlign: TextAlign.center,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              actions: [
                Center(
                    child: simpleButton(
                  onTap: () {
                    Navigation.pop();
                  },
                  borderRadius: radius(10),
                  height: 45,
                  width: 175,
                  backgroundColor: Colors.blue,
                  title: Text("OK",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: white)),
                )),
                const SizedBox(height: 20)
              ],
            ));
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}

Future<void> decisionDialog(String title, String subtitle, String negative,
    String positive, VoidCallback onNegative, VoidCallback onPositive) async {
  return showDialog<void>(
    context: navigatorContext,
    barrierDismissible: false, // user must tap button!
    builder: (navigatorContext) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AlertDialog(
          // <-- SEE HERE
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(subtitle),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onNegative,
              child: Text(negative),
            ),
            TextButton(
              onPressed: onPositive,
              child: Text(positive),
            ),
          ],
        ),
      );
    },
  );
}

showBottomSheets(Widget widget) {
  showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: navigatorContext,
      builder: (context) => widget);
}
