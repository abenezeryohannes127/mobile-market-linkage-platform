import 'package:flutter/material.dart';
import 'package:fluttertest/flutter_app/buyer/chat_page.dart';
import 'package:fluttertest/flutter_app/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_detail.dart';
import 'package:fluttertest/generated/l10n.dart';
//import 'message.dart';

//void main() {
  //runApp(MyApp());
//}

//class MyApp extends StatelessWidget {
  //const MyApp({super.key});

 // @override
  //Widget build(BuildContext context) {
    //return MaterialApp(
      //debugShowCheckedModeBanner: false,
      //home: HomePage(),
    //);
  //}
//}


class HomePage extends StatefulWidget {
  final String userName;
  final String userEmail;
  final int userId;
  //final String userRole;


  const HomePage({super.key, required this.userId,required this.userName, required this.userEmail, });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ProductPage(userId: widget.userId),
      MessageList(userId: widget.userId),
      BuyerOrders(userId: widget.userId),
      ProfilePage(userName: widget.userName,userEmail: widget.userEmail),
    ];
    final s=S.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(s.efarm,style: TextStyle(
        fontSize: 16,
        color: Colors.green,
      ),)),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.store,color: Colors.white70), label: s.home),
          BottomNavigationBarItem(icon: Icon(Icons.message,color: Colors.white70), label: s.message),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,color: Colors.white70), label: s.orders),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.white70), label: s.profile),
        ],
      ),
    );
  }
}
////========================================================================
//class ProductPage extends StatelessWidget {
//@override
// Widget build(BuildContext context) {
// return Center(child: Text("Products Page"));
// }
//}
//=================================================================
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//@override
//Widget build(BuildContext context) {
  //return MaterialApp(
    //home: ProductPage(),
  //);
//}
//class Product extends StatelessWidget {
  //const Product({super.key});

  //@override
 // Widget build(BuildContext context) {
   // return MaterialApp(
     // home: ProductPage(),
    //);
  //}
//}
class ProductPage extends StatefulWidget {
  final int userId;
  const ProductPage({super.key, required this.userId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

//  TextEditingController nameController = TextEditingController();
//  TextEditingController emailController = TextEditingController();

  List Products = [];

  String baseUrl = "http://10.0.2.2/backend";
  String apip = "http://10.0.2.2/apip/";


  Future fetchProducts() async {
    final response =
    await http.get(Uri.parse("$baseUrl/get_productso2.php"));

    setState(() {
      Products = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final s=S.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(s.product)),

      body:Column(
          children: [
            //          TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
            //        TextField(controller: emailController, decoration: InputDecoration(labelText: "Price")),
            //    ElevatedButton(
            //    onPressed: insertProduct,
            //  child: Text("Add Product"),
            //),
            Expanded(
              child:ListView.builder(
                itemCount: Products.length,
                itemBuilder: (context, i){
                  var p = Products[i];
                  return InkWell(


                            child: ListTile(

                              leading: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.green,
                                backgroundImage: NetworkImage("${apip}uploads/"+Products[i]['image']),                  //Icon(Icons.shopping_cart,color: Colors.white),
                              ),
                              title: Text(p['name']),
                              subtitle: Text("${s.price}: ${p['price']}"),
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

                                              // trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
              ),

            ),

          ]

      ),

    );
  }
}


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class MessageList extends StatefulWidget {
  final int userId;

  MessageList({required this.userId,});

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List data = [];

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  fetchMessages() async {
    var res = await http.get(Uri.parse(
        "http://10.0.2.2/backend/get_messages.php?receiver_id=${widget.userId}"));

    setState(() {
      data = json.decode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s=S.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(s.message)),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (c, i) {
          return Card(
            child: ListTile(
              title: Text(data[i]['sender_name']),
              subtitle: Text(data[i]['message']),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      myId: widget.userId,
                      otherId: int.parse(data[i]['sender_id']),
                      name: data[i]['sender_name'],
                    ),
                  ),
                );
              },

            ),

          );
        },
      ),
    );
  }
}
//===============================================================
class BuyerOrders extends StatefulWidget {
  final int userId;
  BuyerOrders({required this.userId});

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
      body: jsonEncode({"buyer_id": widget.userId}),
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
//==================================================================
class ProfilePage extends StatelessWidget {
  final String userName;
  final String userEmail;
//  final String role;


  const ProfilePage({super.key, required this.userName, required this.userEmail, });

  Null get trailing => null;

  @override
  Widget build(BuildContext context) {
    final s=S.of(context)!;
    return Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(25),
            width: 320,
            decoration: BoxDecoration(
              color:
              Colors.grey.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white70),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.person,size: 50,color: Colors.white),
                  ),
                ),

                SizedBox(height:20),

                Text("${s.name}: $userName", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height:10),
                Text("${s.email}: $userEmail"),
                //        Text("Role: $role"),


                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                  },
                  child: Text(s.logout),
                )


              ],
            ),


          ),
        )
    );
  }
}
