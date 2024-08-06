import 'package:commerce/data/models/product/productModel.dart';
import 'package:commerce/presentation/state_holders/create_review_controller.dart';
import 'package:commerce/presentation/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  final NewProduct product;

  const CreateReviewScreen({
    super.key,
    required this.product,
  });

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _reviewTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Create Review", true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (String? text) {
                    if (text?.isEmpty ?? true) {
                      return "Review field cannot be empty";
                    }
                    return null;
                  },
                  controller: _reviewTEController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Write Reviews",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CreateReviewController>(
                    builder: (controller) {
                      if (controller.createReviewInProgress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.addReview(
                              widget.product,
                              _reviewTEController.text.trim(),
                            );
                          }
                        },
                        child: const Text("Submit"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
