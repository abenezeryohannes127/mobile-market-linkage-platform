import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product_detail.dart';

class ProductListPage extends StatefulWidget {
  final int userId=1;

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List products = [];


  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    var res = await http.get(Uri.parse("http://10.0.2.2/php_backend/get_productso.php"));
    setState(() {
      products = jsonDecode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, i) {
          var p = products[i];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(
                    productId: int.parse(p['id'].toString()),
                    userId: widget.userId,
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text(p['name']),
              subtitle: Text("Price: ${p['price']}"),
            ),
          );
        },
      ),
    );
  }
}
