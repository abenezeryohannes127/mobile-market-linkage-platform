import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertest/flutter_app/buyer/chat_page.dart';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatefulWidget {
  final int productId;
  final int userId;
  ProductDetailPage({required this.productId, required this.userId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Map product = {};

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  fetchProduct() async {
    var res = await http.get(
      Uri.parse(
          "http://10.0.2.2/backend/get_product.php?id=${widget.productId}"),
    );
    setState(() {
      product = jsonDecode(res.body);
    });
  }

  createOrder() async {
    await http.post(
      Uri.parse("http://10.0.2.2/backend/create_order.php"),
      body: {
        "product_id": widget.productId.toString(),
        "buyer_id": widget.userId.toString(),
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order placed")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail")),
      body: product.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text(product['name'], style: TextStyle(fontSize: 22)),
                Text("Price: ${product['price']}"),
                ElevatedButton(
                  onPressed: createOrder,
                  child: Text("Order Now"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(
                          myId: widget.userId,
                          otherId: int.parse(product['user_id'].toString()),
                          name: product['name'],
                        ),
                      ),
                    );
                  },
                  child: Text("Message Seller"),
                )
              ],
            ),
    );
  }
}
