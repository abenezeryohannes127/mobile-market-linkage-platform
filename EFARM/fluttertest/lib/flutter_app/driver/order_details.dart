import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final String id;
  final String product;
  final String address;
  final String price;

  OrderDetails({
    required this.id,
    required this.product,
    required this.address,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: Text("Order Details")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order ID: $id", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Product: $product", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Price: $price birr", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Delivery Address:", style: TextStyle(fontSize: 18)),
            Text(address),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Call accept order API
              },
              child: Text("Accept Order"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call delivered order API
              },
              child: Text("Mark Delivered"),
            ),
          ],
        ),
      ),
    );
  }
}