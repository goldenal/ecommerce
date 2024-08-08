import 'package:commerce/data/models/product/orders.dart';
import 'package:commerce/presentation/state_holders/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final _homecontrol = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // _homecontrol.fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
        ),
        body: GetBuilder<HomeController>(builder: (v) {
          if (_homecontrol.allorders.isNotEmpty) {
            return OrderList();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}

class OrderList extends StatelessWidget {
  final _homecontrol = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _homecontrol.allorders.length,
      itemBuilder: (context, index) {
        final order = _homecontrol.allorders[index];
        return OrderTile(order: order);
      },
    );
  }
}

class OrderTile extends StatelessWidget {
  final OrdersModel order;

  OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 4.0),
            //  Text('Quantity: ${order.quantity}'),
            const SizedBox(height: 4.0),
            Text('Price: N${order.amount}'),
            const SizedBox(height: 4.0),
            Text('Date: ${order.time}'),
            const SizedBox(height: 4.0),
            Text('Status: ${order.status}'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }
}
