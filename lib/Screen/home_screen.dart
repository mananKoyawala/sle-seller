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
import 'package:shimmer/shimmer.dart';

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
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const ProductShimmerContainer();
                            })
                        : productList.products.isEmpty
                            ? SizedBox(
                                height: 250,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      sizeH(50),
                                      text(
                                          text: productList.retryMessage!,
                                          textAlign: TextAlign.center,
                                          fontSize: 18),
                                      sizeH(60),
                                      simpleButton(
                                          width: getScreenWidth(context) / 2,
                                          borderRadius: 30,
                                          onTap: () async {
                                            await ref
                                                .read(productsProvider.notifier)
                                                .fetchData();
                                          },
                                          title: text(
                                              text: "Retry",
                                              fontSize: 18,
                                              textColor: Colors.white,
                                              fontWeight: 5))
                                    ],
                                  ),
                                ),
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
                  child: SizedBox(
                    height: 170,
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

class ProductShimmerContainer extends StatelessWidget {
  const ProductShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light background
        borderRadius: BorderRadius.circular(20),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400]!, // Darker base color for shimmer elements
        highlightColor: Colors.grey[300]!, // Slightly lighter highlight color
        child: Row(
          children: [
            // Image Placeholder
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[400], // Darker shimmer color for image
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(width: 10),
            // Text and Buttons Placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Product Name Placeholder
                  Container(
                    height: 16,
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: Colors.grey[400],
                  ),
                  // Product Brand Placeholder
                  Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.grey[400],
                  ),
                  // Product Price Placeholder
                  Container(
                    height: 16,
                    width: MediaQuery.of(context).size.width * 0.25,
                    color: Colors.grey[400],
                  ),
                  // Buttons Row Placeholder
                  Row(
                    children: [
                      // Edit Button Placeholder
                      Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 5),
                      // Visibility Icon Placeholder
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      // Delete Icon Placeholder
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
