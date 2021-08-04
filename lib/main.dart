import 'package:flutter/material.dart';

import 'package:chat_app_redux/Models/login_model.dart';
import 'package:chat_app_redux/Screens/home_page.dart';
import 'package:chat_app_redux/Screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

var email;
var password;
var id;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  email = prefs.getString('email');
  password = prefs.getString('password');
  id = prefs.getString('id');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: (email == null) ? LoginPage.id : HomePage.id,
        routes: {
          //LoginPage.id: (context) => LoginPage(),
          HomePage.id: (context) => HomePage(),
          LoginPage.id: (context) => LoginPage(),
          //ChatPage.id: (context) => ChatPage(),

        }
    );
  }
}