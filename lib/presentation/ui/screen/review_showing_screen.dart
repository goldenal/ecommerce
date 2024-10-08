import 'package:commerce/data/models/product/productModel.dart';
import 'package:commerce/data/models/review_list_model.dart';
import 'package:commerce/presentation/state_holders/review_list_controller.dart';
import 'package:commerce/presentation/ui/screen/create_review_screen.dart';
import 'package:commerce/presentation/ui/utils/app_color.dart';
import 'package:commerce/presentation/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  final NewProduct product;

  const ReviewsScreen({super.key, required this.product});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Reviews", true),
      body: GetBuilder<ReviewListController>(builder: (reviewController) {
        return Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: widget.product.ratings?.reviews?.length,
                  itemBuilder: (context, int index) {
                    return reviewCard(
                        widget.product.ratings?.reviews![index] ?? Review());
                  },
                ),
              ),
            ),
            bottomReviewAndFAB(
              reviewController.reviewData,
            ),
          ],
        );
      }),
    );
  }

  Container bottomReviewAndFAB(ReviewListModel model) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 70,
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
            Text(
              "Reviews (${widget.product.ratings?.reviews?.length ?? 0})",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            FloatingActionButton(
              backgroundColor: AppColor.primaryColor,
              onPressed: () {
                Get.to(
                  () => CreateReviewScreen(
                    product: widget.product,
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }

  Card reviewCard(Review data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade100,
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Text(
                    data.fullname ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              data.comment ??
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                overflow: TextOverflow.clip,
              ),
            )
          ],
        ),
      ),
    );
  }
}
