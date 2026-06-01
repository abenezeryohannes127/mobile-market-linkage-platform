import 'package:fluttertest/flutter_app/seller/add_edit.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

//void main(){
//runApp(MyApp());
//}

//class MyApp extends StatelessWidget{
//const MyApp({super.key});

//@override
//Widget build(BuildContext context){
//return MaterialApp(
// home: AddProductPage(),
// );
// }
//}

class AddProductPage extends StatefulWidget {
  final int userId;
  const AddProductPage({super.key, required this.userId});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final name = TextEditingController();
  final price = TextEditingController();
  File? image;

  String api = "http://10.0.2.2/apip/";

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  Future addProduct() async {
    var request =
        http.MultipartRequest("POST", Uri.parse("${api}add_product.php"));

    request.fields['name'] = name.text;
    request.fields['price'] = price.text;
    request.fields['user_id'] = widget.userId.toString();

    request.files.add(await http.MultipartFile.fromPath('image', image!.path));

    await request.send();

    setState(() {});
  }

  Future getProducts() async {
    var res = await http
        .get(Uri.parse("${api}get_products.php?user_id=${widget.userId}"));
    return jsonDecode(res.body);
  }

  Future deleteProduct(id) async {
    await http.post(Uri.parse("${api}delete_product.php"), body: {"id": id});
    setState(() {});
  }

  Future editProduct(id) async {
    await http.post(Uri.parse("${api}update_product.php"), body: {"id": id});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Products")),
        body: Column(children: [
          TextField(
              controller: name, decoration: InputDecoration(labelText: "Name")),
          TextField(
              controller: price,
              decoration: InputDecoration(labelText: "Price")),
          ElevatedButton(onPressed: pickImage, child: Text("Pick Image")),
          ElevatedButton(onPressed: addProduct, child: Text("Add Product")),
          Expanded(
            child: FutureBuilder(
                future: getProducts(),
                builder: (c, s) {
                  if (!s.hasData) return CircularProgressIndicator();
                  var data = s.data;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (c, i) {
                        return ListTile(
                          leading: Image.network(
                              "${api}uploads/" + data[i]['image'],
                              width: 50),
                          title: Text(data[i]['name']),
                          subtitle: Text("\$${data[i]['price']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProductPage(
                                        id: int.parse(data[i]['id'].toString()),
                                        name: data[i]['name'].toString(),
                                        price: double.parse(
                                            data[i]['price'].toString()),
                                        image: data[i]['image'].toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteProduct(data[i]['id']),
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ),
        ]));
  }
}
