import 'package:flutter/material.dart';
import '../../Package/PackageConstants.dart';

void showNoInternetDialog(
    {required BuildContext context, VoidCallback? onPressed}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('No Internet'),
      content: const Text('Please check your internet connection.'),
      actions: [
        TextButton(
          onPressed: onPressed ??
              () async {
                Navigation.pop();
              },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
