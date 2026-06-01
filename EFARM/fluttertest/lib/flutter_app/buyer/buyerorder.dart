import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertest/flutter_app/driver/order_detail.dart';
import 'package:fluttertest/generated/l10n.dart';

class BuyerOrders extends StatefulWidget {
  final int buyerId;
  BuyerOrders({required this.buyerId});

  @override
  _BuyerOrdersState createState() => _BuyerOrdersState();
}

class _BuyerOrdersState extends State<BuyerOrders> {
  List orders = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  fetchOrders() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2/backend/get_buyer_orders.php"),
      body: jsonEncode({"buyer_id": widget.buyerId}),
    );
    if (response.statusCode == 200) {
      setState(() {
        orders = jsonDecode(response.body);
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s=S.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(s.myOrders)),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          var order = orders[index];
          return ListTile(
            title: Text(order['product_name']),
            subtitle: Text("${s.status}: ${order['status']}"),
            onTap: () {
              //Navigator.push(
                //context,
               // MaterialPageRoute(
                 // builder: (_) => OrderDetailPage(
                  //  orderId: order['id'],
                   // buyerId: order['buyer_id'],
                  //),
                //),
              //);
            },
          );
        },
      ),
    );
  }
}