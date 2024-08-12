import 'package:commerce/data/models/product/productModel.dart';
import 'package:commerce/data/models/products_details.dart';
import 'package:commerce/presentation/state_holders/add_to_cart_controller.dart';
import 'package:commerce/presentation/state_holders/create_wish_list.dart';
import 'package:commerce/presentation/state_holders/products_details_controller.dart';
import 'package:commerce/presentation/ui/screen/review_showing_screen.dart';
import 'package:commerce/presentation/ui/utils/app_color.dart';
import 'package:commerce/presentation/ui/widgets/custom_app_bar.dart';
import 'package:commerce/presentation/ui/widgets/custom_stepper.dart';
import 'package:commerce/presentation/ui/widgets/love_icon_button.dart';
import 'package:commerce/presentation/ui/widgets/products_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsDetailsScreen extends StatefulWidget {
  final NewProduct product;

  const ProductsDetailsScreen({super.key, required this.product});

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get.find<ProductsDetailsController>()
      //     .getProductsDetails(widget.productsId);
      // Get.find<ProductsDetailsController>().availableColor.clear();
    });
  }

  // ignore: unused_field
  int _selectedSizeIndex = 0;
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Products Details", true),
      body: GetBuilder<ProductsDetailsController>(
        builder: (productsDetailsController) {
          if (productsDetailsController.getProductsDetailsInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              ProductsDetailsCarouselSlider(
                imageList: widget.product.images!,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: productsDetails(
                        productsDetailsController.productsDetails,
                        productsDetailsController.availableColor),
                  ),
                ),
              ),
              cartBottomContainer(
                productsDetailsController.productsDetails,
                productsDetailsController.availableColor,
                productsDetailsController.availableSizes,
              ),
            ],
          );
        },
      ),
    );
  }

  Column productsDetails(ProductsDetails productsDetails, List<String> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.product.name ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                ),
              ),
            ),
            CustomStepper(
              stepValue: 1,
              lowerLimit: 1,
              upperLimit: 20,
              value: 1,
              onChanged: (value) {},
            ),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.star,
              size: 18,
              color: Colors.amber,
            ),
            Text(
              '${widget.product.ratings?.average}',
              style: const TextStyle(
                fontSize: 15,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(
                  () => ReviewsScreen(
                    product: widget.product,
                  ),
                );
              },
              child: const Text(
                "Review",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.find<CreateWishListController>()
                    .createWishList(widget.product.id ?? "", widget.product);
              },
              child: const FavoriteLoveIconButton(),
            ),
          ],
        ),
        // const Text(
        //   "Color",
        //   style: TextStyle(
        //       fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
        // ),
        // const SizedBox(
        //   height: 16,
        // ),
        // ProductsDetailsColorSelector(
        //     colors: colors,
        //     selectedColor: _selectedColorIndex,
        //     onSelected: (int index) {
        //       _selectedColorIndex = index;
        //     }),

        const SizedBox(
          height: 16,
        ),
        // const Text(
        //   "Sizes",
        //   style: TextStyle(
        //       fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
        // ),
        // const SizedBox(
        //   height: 16,
        // ),
        // ProductsDetailsSizeSelector(
        //   sizes: productsDetails.size?.split(',') ?? [],
        //   onSelect: (int index) {
        //     _selectedSizeIndex = index;
        //   },
        //   initialSelected: 0,
        // ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Description",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        Text(
          widget.product.description ?? "",
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  // SizedBox productsDetailsColorSelector(List<String> colors) {
  //   return SizedBox(
  //     height: 30,
  //     child: ListView.separated(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: colors.length,
  //       itemBuilder: (context, int index) {
  //         return InkWell(
  //           borderRadius: BorderRadius.circular(20),
  //           onTap: () {
  //             _selectedColorIndex = index;
  //             if (mounted) {
  //               setState(() {});
  //             }
  //           },
  //           child: CircleAvatar(
  //             radius: 18,
  //             backgroundColor: HexColor.fromHex(colors[index]),
  //             child: _selectedColorIndex == index
  //                 ? const Icon(
  //                     Icons.done,
  //                     color: Colors.white,
  //                   )
  //                 : null,
  //           ),
  //         );
  //       },
  //       separatorBuilder: (context, int index) {
  //         return const SizedBox(
  //           width: 8,
  //         );
  //       },
  //     ),
  //   );
  // }

  Container cartBottomContainer(
      ProductsDetails productsDetails, List<String> color, List<String> size) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        color: AppColor.primaryColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Price",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'N${widget.product.price ?? 0}',
                  style: const TextStyle(
                      fontSize: 18,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              width: 120,
              child: GetBuilder<AddToCartController>(
                builder: (addToCartController) {
                  if (addToCartController.addToCartInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      final results = await addToCartController
                          .addToCart(widget.product);

                      //  addToCartController.addMoreItems();
                      if (results) {
                        Get.snackbar("Success", "Added to cart ");
                      }
                    
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(fontSize: 13),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
