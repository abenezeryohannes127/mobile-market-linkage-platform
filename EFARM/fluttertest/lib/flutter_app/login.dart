import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertest/generated/l10n.dart';
import 'package:fluttertest/l10n/l10n.dart';

import 'buyer/button_nav.dart';
import 'seller/seller_home.dart';
import 'driver/driver.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state =
    context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,

      supportedLocales: L10n.all,

      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      home: LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  login() async{

    var res=await http.post(
        Uri.parse("http://10.0.2.2/backend/login.php"),
        body:{
          "email":email.text,
          "password":password.text
        }
    );

    var data=jsonDecode(res.body);

    if(data["role"]=="buyer"){
      int userId =int.parse(data['id'].toString());
      String userName = (data["name"].toString());
      String userEmail= (data["email"].toString());
      Navigator.push(context,MaterialPageRoute(builder:(_)=>HomePage(userId: userId,userName: userName,userEmail: userEmail,)));
    }

    if(data["role"]=="seller"){
      int userId =int.parse(data['id'].toString());
      String userName = (data["name"].toString());
    String userEmail= (data["email"].toString());
      Navigator.push(context,MaterialPageRoute(builder:(_)=>SellerHome(userId: userId,userName: userName,userEmail: userEmail, )));
    }

    if(data["role"]=="driver"){
      int userId =int.parse(data['id'].toString());
      Navigator.push(context,MaterialPageRoute(builder:(_)=>DriverOrders(driverId: userId)));
    }

  }

  @override
  Widget build(BuildContext context){
  final s=S.of(context)!;
    return Scaffold(

        appBar: AppBar(title: Text(s.login)),
        body:
        Padding(
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

                  child:


              Column(
                      mainAxisSize:
                      MainAxisSize.min,



                  children:[
                        TextField(
                            controller:email,decoration:
                        InputDecoration(labelText:s.email)),
                        TextField(
                            controller:password,decoration:
                        InputDecoration(labelText:s.password)),
                        SizedBox(height:20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding:
                              EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),
                            onPressed:login, child:Text(s.login,style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),)),
                        TextButton(

                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => RegisterPage()));
                          },
                          child: Text(s.createAccount,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                            ),),

                        ),

                //padding: EdgeInsets.all(20),
                //child:
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text(S.of(context)!.login),),

                    SizedBox(height: 20),

                    DropdownButton<Locale>(
                      value: Localizations.localeOf(context),
                      items: const [
                        DropdownMenuItem(value: Locale('en'), child: Text("English")),
                        DropdownMenuItem(value: Locale('am'), child: Text("አማርኛ")),
                        DropdownMenuItem(value: Locale('om'), child: Text("Afaan Oromo"),),
                      ],
                      onChanged: (Locale? locale) {
                        MyApp.setLocale(context, locale!);
                      },
                    ),
                  ],
                ),


            ]
                  ),
                )
            )
        )
    );
  }
}
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String selectedRole = "buyer";

  Future<void> register() async {
    var response = await http.post(
      Uri.parse("http://10.0.2.2/backend/register.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name.text,
        "email": email.text,
        "password": password.text,
        "role": selectedRole
      }),
    );

    var data = jsonDecode(response.body);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(data["message"])));
  }

  @override
  Widget build(BuildContext context) {
    final s=S.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(s.register,

        style: TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
      )),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(25),
            width: 320,
            decoration: BoxDecoration(
              color:
              Colors.green.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white70),
            ),
            child: Column(
              mainAxisSize:
              MainAxisSize.min,

//        child: Column(
              children: [
                TextField(controller: name,
                    decoration: InputDecoration(labelText: s.name)),
                TextField(controller: email,
                    decoration: InputDecoration(labelText: s.email)),
                TextField(controller: password,
                    decoration: InputDecoration(labelText: s.password),
                    obscureText: true),
                SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: selectedRole,decoration:
                InputDecoration(labelText: "Select Role"),
                  items: ["buyer","seller","driver"].map((role){
                    return DropdownMenuItem(
                      value: role,
                      child:
                      Text(role.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedRole=value!;
                    });
                  },

                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                      EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: register, child: Text(s.register
                  ,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
