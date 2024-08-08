import 'package:commerce/data/models/product/orders.dart';
import 'package:commerce/data/models/product/productModel.dart';
import 'package:commerce/presentation/state_holders/checkoutController.dart';
import 'package:commerce/presentation/state_holders/homecontroller.dart';
import 'package:commerce/presentation/ui/screen/products_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splittedorder extends StatefulWidget {
  const Splittedorder({super.key});

  @override
  State<Splittedorder> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<Splittedorder> {
  final _homecontrol = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _homecontrol.fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
        ),
        body: GetBuilder<HomeController>(builder: (v) {
          if (_homecontrol.myyorders.isNotEmpty) {
            return OrderList();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}

class OrderList extends StatelessWidget {
  final _homecontrol = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _homecontrol.splitedorders.length,
      itemBuilder: (context, index) {
        final order = _homecontrol.splitedorders[index];
        return GestureDetector(
            onTap: () {
              NewProduct np = NewProduct.fromJson(
                  _homecontrol.splitedorders[index].data ?? {});
              Get.to(() => ProductsDetailsScreen(
                    product: np,
                  ));
            },
            child: OrderTile(order: order));
      },
    );
  }
}

class OrderTile extends StatelessWidget {
  final OrdersModel order;

  OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    final checkCtrl = Get.put(Checkoutcontroller());
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          order.items.toString().replaceAll("[", "").replaceAll("]", ""),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Tap to buy',
            //   style: const TextStyle(color: Colors.green),
            // ),
            const SizedBox(height: 4.0),
            Text('Price: N${order.amount}'),
            const SizedBox(height: 4.0),
            Text('Date: ${order.time}'),
            const SizedBox(height: 4.0),
            Text('Status: ${order.status}'),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            checkCtrl.pay(double.parse(order.amount ?? "0"), true, true,
                ref: order.reference);
          },
          child: const Icon(
            Icons.shopping_cart_checkout,
            color: Colors.green,
            size: 50,
          ),
        ),
      ),
    );
  }
}
