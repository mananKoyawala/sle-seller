import 'package:flutter/material.dart';
import 'package:sle_seller/Service/NavigatorKey.dart';
import 'PackageConstants.dart';
import 'RippleEffect/RippleEffectContainer.dart';

mixin text_with_button {
  // common text
  Widget text(
      {required String text,
      Color? textColor,
      int? fontWeight,
      required double fontSize,
      TextAlign? textAlign,
      String? fontFamily,
      dynamic decoration,
      TextOverflow? overflow,
      int? maxLines,
      bool? softWrap}) {
    return Text(
      text,
      softWrap: softWrap,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: getfontWeight(fontWeight),
          color: textColor ?? Colors.black,
          fontFamily: fontFamily,
          decoration: decoration),
    );
  }

  Widget overFlowText(
      {required double h,
      required double w,
      required String text,
      Color? textColor,
      int? fontWeight,
      required double fontSize,
      TextAlign? textAlign,
      String? fontFamily,
      dynamic decoration,
      TextOverflow? overflow,
      int? maxLines}) {
    return SizedBox(
      height: h,
      width: w,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: getfontWeight(fontWeight),
            color: textColor ?? Colors.black,
            fontFamily: fontFamily,
            decoration: decoration),
      ),
    );
  }

  Widget simpleButton({
    double? height,
    double? width,
    Color? backgroundColor,
    double? borderRadius,
    Widget? title,
    required VoidCallback onTap,
    BoxBorder? border,
  }) {
    return ClickEffect(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(navigatorContext).primaryColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            border: border),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title ??
                text(
                  text: 'Add to Cart',
                  fontSize: 16,
                  textColor: white,
                  fontWeight: 5,
                ),
          ],
        ),
      ),
    );
  }

  // icon button
  Widget iconButton({
    required void Function()? onTap,
    double? height,
    Icon? icon,
    radius,
  }) {
    return ClickEffect(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius ?? 30),
        child: SizedBox(
            height: height ?? 50,
            width: height ?? 50,
            child: icon ?? const Icon(Icons.settings)));
  }
}

FontWeight getfontWeight(int? i) {
  switch (i) {
    case 2:
      return FontWeight.w200;
    case 3:
      return FontWeight.w300;
    case 4:
      return FontWeight.w400;
    case 5:
      return FontWeight.w500;
    case 6:
      return FontWeight.w600;
    case 7:
      return FontWeight.w700;
    default:
      return FontWeight.normal;
  }
}
