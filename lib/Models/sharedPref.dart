import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//https://betterprogramming.pub/flutter-how-to-save-objects-in-sharedpreferences-b7880d0ee2e4
class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key) ?? '');
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    //print(json.encode(value));
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  clear() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}