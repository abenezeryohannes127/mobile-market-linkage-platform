
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BuyerHome(),
    );
  }
}

class BuyerHome extends StatefulWidget {
  @override
  _BuyerHomeState createState() => _BuyerHomeState();
}

class _BuyerHomeState extends State<BuyerHome> {

  int currentIndex = 0;

  final List pages = [
    ProductPage(),
    MessagePage(),
    OrderPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.green,
        type: BottomNavigationBarType.fixed,

        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Products"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Messages"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: "Orders"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"
          ),
        ],
      ),
    );
  }
}

class ProductPage extends StatelessWidget {

  final List products = [
    {"name":"Nike Shoes","price":"120"},
    {"name":"iPhone 13","price":"900"},
    {"name":"Headphone","price":"80"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products"), backgroundColor: Colors.green),

      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context,index){

          return Card(
            margin: EdgeInsets.all(10),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),

            child: ListTile(

              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.shopping_cart,color: Colors.white),
              ),

              title: Text(products[index]['name']!),
              subtitle: Text("\$${products[index]['price']}"),

              trailing: Icon(Icons.arrow_forward_ios),

            ),
          );

        },
      ),
    );
  }
}

class MessagePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        backgroundColor: Colors.green,
      ),

      body: ListView(
        children: [

          ListTile(
            leading: CircleAvatar(child: Icon(Icons.store)),
            title: Text("Seller Shop"),
            subtitle: Text("Your order is ready"),
            trailing: Icon(Icons.chat),
          ),

          ListTile(
            leading: CircleAvatar(child: Icon(Icons.store)),
            title: Text("Tech Store"),
            subtitle: Text("Discount available"),
            trailing: Icon(Icons.chat),
          ),

        ],
      ),
    );
  }
}

class OrderPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: Colors.green,
      ),

      body: ListView(

        children: [

          Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text("Nike Shoes"),
              subtitle: Text("Status: Delivered"),
              trailing: Icon(Icons.check_circle,color: Colors.green),
            ),
          ),

          Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text("Headphones"),
              subtitle: Text("Status: On Delivery"),
              trailing: Icon(Icons.local_shipping,color: Colors.orange),
            ),
          ),

        ],

      ),
    );
  }
}

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.green,
      ),

      body: Column(
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

          Text(
            "Buyer Name",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          ),

          SizedBox(height:10),

          Text("buyer@email.com"),

        ],
      ),
    );
  }
}
