import 'package:flutter/material.dart';
import 'package:sle_seller/Screen/Auth/auth_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/Service/NavigatorKey.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.green),
          fontFamily: "popins"),
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}
