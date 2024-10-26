import 'package:flutter/material.dart';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/Screen/edit_product_screen.dart';

class HomeScreen extends StatelessWidget with text_with_button, utils {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CP(
          h: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizeH(50),
              text(text: "Your Products", fontSize: 22, fontWeight: 5),
              sizeH25(),
              Container(
                height: 170,
                width: getScreenWidth(context),
                decoration: BoxDecoration(
                    color: Colors.green[100], borderRadius: radius(20)),
                child: Row(
                  children: [
                    Container(
                      width: getScreenWidth(context) * .35,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: radius(20)),
                    ),
                    sizeW10(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        sizeH10(),
                        text(text: "web cam", fontSize: 18, fontWeight: 5),
                        sizeH(5),
                        overFlowText(
                            h: 20,
                            w: getScreenWidth(context) / 2,
                            maxLines: 1,
                            text: "logti desijddjdjgo isdj oidjojif",
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                        sizeH(10),
                        text(
                            text: "999₹ / Piece",
                            fontSize: 16,
                            textColor: Colors.green),
                        sizeH(10),
                        simpleButton(
                            height: 45,
                            width: 65,
                            onTap: () {
                              Navigation.pushMaterial(EditProductScreen());
                            },
                            title: text(
                                text: "Edit",
                                fontSize: 16,
                                textColor: Colors.white))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
