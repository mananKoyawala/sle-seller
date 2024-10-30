import 'package:flutter/material.dart';
import 'package:sle_seller/Package/PackageConstants.dart';
import 'package:sle_seller/Package/RippleEffect/RippleEffectContainer.dart';
import 'package:sle_seller/Package/Text_Button.dart';
import 'package:sle_seller/Package/Utils.dart';
import 'package:sle_seller/Screen/edit_product_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sle_seller/helper/product_api_helper.dart';
import 'package:sle_seller/models/Product.dart';
import 'package:sle_seller/provider/home_provider.dart';

class HomeScreen extends ConsumerWidget with text_with_button, utils {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productsProvider);
    return SafeArea(
      child: Scaffold(
        body: CP(
            h: 16,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizeH(50),
                    text(text: "Your Products", fontSize: 22, fontWeight: 5),
                    sizeH25(),
                    productList.isLoading
                        ? text(text: "Loading...", fontSize: 18)
                        : productList.products.isEmpty
                            ? Center(
                                child: text(text: "No Products", fontSize: 18),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: productList.products.length,
                                itemBuilder: (context, index) {
                                  return ProductContainer(
                                    ref: ref,
                                    product: productList.products[index],
                                  );
                                }),
                    sizeH(40),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class ProductContainer extends StatelessWidget with text_with_button, utils {
  ProductContainer({super.key, required this.product, required this.ref});
  final Product product;
  final WidgetRef ref;
  ProductApiHelper helper = ProductApiHelper();
  @override
  Widget build(BuildContext context) {
    return Margin(
      margin: const EdgeInsets.only(bottom: 20),
      child: ClickEffect(
        onTap: () {
          // show products details
        },
        borderRadius: radius(20),
        child: Container(
          height: 170,
          width: getScreenWidth(context),
          decoration:
              BoxDecoration(color: Colors.green[100], borderRadius: radius(20)),
          child: Row(
            children: [
              Container(
                width: getScreenWidth(context) * .35,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: radius(20)),
                child: ClipRRect(
                  borderRadius: radius(20),
                  child: Image.network(
                    product.image_url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                          child: text(text: "No Image", fontSize: 16));
                    },
                  ),
                ),
              ),
              sizeW10(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sizeH10(),
                  text(text: product.name, fontSize: 18, fontWeight: 5),
                  sizeH(5),
                  overFlowText(
                      h: 20,
                      w: getScreenWidth(context) / 2,
                      maxLines: 1,
                      text: product.brand,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis),
                  sizeH(10),
                  text(
                      text: "${product.price}₹ / Piece",
                      fontSize: 16,
                      textColor: Colors.green),
                  sizeH(10),
                  Row(
                    children: [
                      simpleButton(
                          height: 45,
                          width: 65,
                          onTap: () {
                            Navigation.pushMaterial(
                                EditProductScreen(product: product));
                          },
                          title: text(
                              text: "Edit",
                              fontSize: 16,
                              textColor: Colors.white)),
                      sizeW(5),
                      iconButton(
                        onTap: () async {
                          var isStatusChanged =
                              await helper.changeProductStatus(product.id);
                          if (isStatusChanged) {
                            // it will fetch data if product status change
                            ref.read(productsProvider.notifier).fetchData();
                          }
                        },
                        icon: product.status
                            ? const Icon(Icons.visibility_off,
                                color: Colors.red)
                            : const Icon(Icons.visibility, color: Colors.green),
                      ),
                      iconButton(
                          onTap: () async {
                            var isDeleted =
                                await helper.deleteProduct(product.id);
                            if (isDeleted) {
                              // it will fetch data if product wiil be delete
                              ref.read(productsProvider.notifier).fetchData();
                            }
                          },
                          icon: const Icon(Icons.delete, color: Colors.red))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
