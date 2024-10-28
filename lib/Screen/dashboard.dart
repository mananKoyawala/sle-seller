import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/Screen/add_products_screen.dart';
import 'package:sle_seller/Screen/home_screen.dart';
import 'package:sle_seller/Screen/profile_screen.dart';
import 'package:sle_seller/provider/dashboard_provider.dart';
import 'package:sle_seller/provider/shared_preference.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  _getSharedPreference() async {
    SharedPreference pref = SharedPreference();
    await pref.getUserData();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _getSharedPreference();
    var isHomePage = ref.watch(dashboardProvider);
    return Scaffold(
      // floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          shape: const CircleBorder(),
          onPressed: () {
            Navigation.pushMaterial(AddProductScreen());
          },
          child: const Icon(
            Icons.add,
            size: 28,
          ),
        ),
      ),

      // bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(CupertinoIcons.home,
                    size: 30,
                    color: isHomePage ? Colors.white : Colors.white54),
                onPressed: () {
                  onChangeDashboardProvider(ref, true);
                },
              ),
              IconButton(
                icon: Icon(CupertinoIcons.person,
                    size: 30,
                    color: isHomePage ? Colors.white54 : Colors.white),
                onPressed: () {
                  onChangeDashboardProvider(ref, false);
                },
              )
            ],
          ),
        ),
      ),
      body: isHomePage ? HomeScreen() : ProfileScreen(),
    );
  }
}
