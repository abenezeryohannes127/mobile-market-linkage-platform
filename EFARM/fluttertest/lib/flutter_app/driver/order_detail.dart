import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertest/generated/l10n.dart';
class OrderDetailPage extends StatefulWidget {
  final int orderId;
  final int buyerId;

  OrderDetailPage({required this.orderId, required this.buyerId});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  bool loading = true;
  Map order = {};
  String status = "";

  @override
  void initState() {
    super.initState();
    fetchOrderDetail();
  }

  fetchOrderDetail() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2/backend/get_order_detail.php"),
      body: jsonEncode({"order_id": widget.orderId}),
    );

    if (response.statusCode == 200) {
      setState(() {
        order = jsonDecode(response.body);
        status = order['status'];
        loading = false;
      });
    }else{
      print("Server error: ${response.statusCode}");
    }
  }

  updateStatus(String newStatus) async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2/backend/update_order_status.php"),
      body: jsonEncode({"order_id": widget.orderId, "status": newStatus}),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['success']) {
        setState(() {
          status = newStatus;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Status updated!")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s=S.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text("${s.orders} #${widget.orderId}")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${s.buyerId}: ${order['buyer_id']}"),
                  SizedBox(height: 10),
                  Text("${s.product}: ${order['product_name']}"),
                  SizedBox(height: 5),
                  Text("${s.price}: \$${order['price']}"),
                  SizedBox(height: 10),
                  order['image'] != null
                      ? Image.network(
                          "http://10.0.2.2/apip/uploads/${order['image']}",
                          height: 150,
                        )
                      : SizedBox(),
                  SizedBox(height: 20),
                  Text("${s.status}: $status"),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () => updateStatus("on the way"),
                      child: Text(s.markOnTheWay)),
                  ElevatedButton(
                      onPressed: () => updateStatus("delivered"),
                      child: Text(s.markAsDelivered)),
                ],
              ),
            ),
    );
  }
}