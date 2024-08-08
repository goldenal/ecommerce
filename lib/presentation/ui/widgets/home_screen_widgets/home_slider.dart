import 'package:carousel_slider/carousel_slider.dart';
import 'package:commerce/data/models/product/productModel.dart';
import 'package:commerce/presentation/state_holders/add_to_cart_controller.dart';
import 'package:commerce/presentation/state_holders/checkoutController.dart';
import 'package:commerce/presentation/ui/screen/products_details_screen.dart';
import 'package:commerce/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSlider extends StatefulWidget {
  final List<NewProduct> sliders;

  const HomeSlider({super.key, required this.sliders});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final ValueNotifier<int> _selectedSlider = ValueNotifier(0);
  final addtoCaart = Get.put(AddToCartController());
  final chkout = Get.put(Checkoutcontroller());

  @override
  Widget build(BuildContext context) {
    List<NewProduct> sld = [...widget.sliders];
    sld.shuffle();
    List<NewProduct> items = sld.sublist(0, 4);

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 180,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              onPageChanged: (int page, _) {
                _selectedSlider.value = page;
              }),
          items: items.map((sliderData) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductsDetailsScreen(product: sliderData));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Image.network(
                            '${sliderData.images![0]}',
                            scale: 1.2,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Enjoy trending\nSummers deals\n${sliderData.name}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 35,
                              width: 120,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () async {
                                  await addtoCaart.addToCart(sliderData);
                                  chkout.pay(
                                      double.parse(sliderData.price ?? "0"),
                                      false,
                                      false);
                                },
                                child: const Text(
                                  "Buy Now",
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 8,
        ),
        ValueListenableBuilder(
          valueListenable: _selectedSlider,
          builder: (context, value, _) {
            List<Widget> list = [];
            for (int i = 0; i < items.length; i++) {
              list.add(
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          value == i ? AppColor.primaryColor : Colors.black54),
                ),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: list,
            );
          },
        ),
      ],
    );
  }
}
