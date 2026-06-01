import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertest/flutter_app/driver/order_detail.dart';
import 'package:fluttertest/generated/l10n.dart';

class DriverOrders extends StatefulWidget {
  final int driverId;
  DriverOrders({required this.driverId});

  @override
  _DriverOrdersState createState() => _DriverOrdersState();
}

class _DriverOrdersState extends State<DriverOrders> {
  List orders = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  fetchOrders() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2/backend/get_driver_orders.php"),
      body: jsonEncode({"driver_id": widget.driverId}),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderDetailPage(
                          orderId: order['id'],
                          buyerId: order['buyer_id'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}