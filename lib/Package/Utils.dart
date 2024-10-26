import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Service/NavigatorKey.dart';
import 'PackageConstants.dart';
import 'package:url_launcher/url_launcher.dart';

mixin utils {
  Widget dropDownMenu({
    required BuildContext context,
    required List<String> items,
    required Function(String) onSelected,
    Color? color,
    Color? textColor,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(color: color ?? Colors.green),
      ),
      child: PopupMenuButton<String>(
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return items.map((String item) {
            return PopupMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                    color: textColor ?? white, fontWeight: FontWeight.w400),
              ),
            );
          }).toList();
        },
      ),
    );
  }

  radius(double d) {
    return BorderRadius.circular(d);
  }

  unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  infinity() {
    return double.infinity;
  }

  visibility() {
    return MediaQuery.of(navigatorContext).viewInsets.bottom == 0;
  }

  // H -> Height , W - Width
  sizeH10() {
    return const SizedBox(height: 10);
  }

  sizeW10() {
    return const SizedBox(width: 10);
  }

  sizeH25() {
    return const SizedBox(height: 25);
  }

  sizeW25() {
    return const SizedBox(width: 25);
  }

  sizeH(double h) {
    return SizedBox(height: h);
  }

  sizeW(double w) {
    return SizedBox(width: w);
  }

  printD(Object? s) {
    if (kDebugMode) {
      print(s);
    }
  }

  launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      toast("Failed to lauch url");
    }
  }
}

class CustomScroll extends StatelessWidget {
  const CustomScroll({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        )
      ],
    );
  }
}
