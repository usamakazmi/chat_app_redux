import 'package:flutter/material.dart';

import 'package:chat_app_redux/Models/login_model.dart';
import 'package:chat_app_redux/Screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        initialRoute: HomePage.id,
        routes: {
          //LoginPage.id: (context) => LoginPage(),
          HomePage.id: (context) => HomePage(),
          //ChatPage.id: (context) => ChatPage(),

        }
    );
  }
}