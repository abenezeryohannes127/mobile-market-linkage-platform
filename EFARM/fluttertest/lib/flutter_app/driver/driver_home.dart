
import 'package:flutter/material.dart';
import 'package:fluttertest/flutter_app/driver/order_details.dart';

class DriverHome extends StatelessWidget {

  final List orders = [
    {"id":"1","product":"Wheat","address":"Addis Ababa"},
    {"id":"2","product":"Corn","address":"Bole"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.green,
      appBar: AppBar(title: Text("Driver Orders",style: TextStyle(
        fontSize: 16,
        color: Colors.black,

      ),)),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context,index){
          return Card(
            child: ListTile(
              title: Text(orders[index]['product']),
              subtitle: Text(orders[index]['address']),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>OrderDetails(id: orders[index]['id'], product: '', address: '', price: '',)
                  )
                );
              },
            ),
          );
        }
      ),
    );
  }
}
