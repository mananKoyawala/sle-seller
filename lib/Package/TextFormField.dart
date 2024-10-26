import 'package:flutter/material.dart';
import 'PackageConstants.dart';

mixin formField {
  Widget textFormField({
    required BuildContext context,
    bool? readOnly,
    bool? autofocus,
    TextInputAction? textInputAction,
    InputBorder? border,
    TextEditingController? controller,
    bool? showCursor,
    required String? Function(String?) funValidate,
    Color? cursorColor,
    bool? obsecureText,
    TextInputType? textInputType,
    Function(String)? onChanged,
    int? maxLines,
    int? maxLength,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    Widget? prefixIcon,
    Widget? suffixIcon,
    EdgeInsetsGeometry? contentPadding,
    String? labelText,
    String? hintText,
    double? borderRadius,
    Color? fieldColor,
    required bool isborder,
    Color? onClickColor,
    double? borderWidth,
    VoidCallback? onTap,
  }) {
    double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return TextFormField(
        readOnly: readOnly ?? false,
        autofocus: autofocus ?? false,
        textInputAction: textInputAction ?? TextInputAction.next,
        showCursor: showCursor,
        controller: controller,
        validator: funValidate,
        onTap: onTap,
        cursorColor: cursorColor ?? black,
        obscureText: obsecureText ?? false,
        keyboardType: textInputType ?? TextInputType.text,
        scrollPadding: EdgeInsets.only(bottom: bottomInsets + 65.0),
        onChanged: onChanged,
        maxLines: maxLines,
        style: textStyle ??
            TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey[500]),
        maxLength: maxLength,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          counterText: "",
          labelText: labelText,
          prefixIcon: prefixIcon,
          errorStyle: const TextStyle(fontSize: 14),
          labelStyle: labelStyle ??
              TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[500]),
          enabledBorder: isborder == false
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 10))),
          errorBorder: isborder == false
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                )
              : OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 10))),
          focusedErrorBorder: isborder == false
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 10))),
          focusedBorder: isborder == false
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: onClickColor ?? black, width: borderWidth ?? 1.5),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(
                      color: onClickColor ?? black, width: borderWidth ?? 1.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 10))),
          border: isborder == false
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 10))),
        ));
  }
}
