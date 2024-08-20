import 'package:commerce/data/models/product/productModel.dart';
import 'package:commerce/presentation/ui/widgets/custom_app_bar.dart';
import 'package:commerce/presentation/ui/widgets/products_card.dart';
import 'package:flutter/material.dart';

class ItemsScreen extends StatefulWidget {
  final String title;
  final List<NewProduct> newp;

  const ItemsScreen({Key? key, required this.title, required this.newp})
      : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    List<NewProduct> temp = widget.newp;
    if (widget.title.toLowerCase() == "electronics") {
      temp = widget.newp.where((v) {
        return v.category ==
            "Electronics"; //Fashion Furniture  Electronics  Food
      }).toList();
    }

    if (widget.title.toLowerCase() == "food") {
      temp = widget.newp.where((v) {
        return v.category == "Food"; //Fashion Furniture  Electronics  Food
      }).toList();
    }

    if (widget.title.toLowerCase() == "furniture") {
      temp = widget.newp.where((v) {
        return v.category == "Furniture"; //Fashion Furniture  Electronics  Food
      }).toList();
    }

    if (widget.title.toLowerCase() == "fashion") {
      temp = widget.newp.where((v) {
        return v.category == "Fashion"; //Fashion Furniture  Electronics  Food
      }).toList();
    }

    


    return Scaffold(
      appBar: customAppBar(widget.title, true),
      body:
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          itemCount: temp.length ?? 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, int index) {
            return FittedBox(
              child: ProductsCard(
                product: temp[index],
                isShowDeleteButton: false,
              ),
            );
          },
        ),
      ),
   
    );
  }
}
