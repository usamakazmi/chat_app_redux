import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app_redux/Models/conversations_model.dart';
import 'package:chat_app_redux/Models/login_model.dart';
import 'package:chat_app_redux/Models/sharedPref.dart';

import 'package:chat_app_redux/Screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


String xyz =
    "https://www.comingsoon.net/anime/news/1172796-dragon-ball-super-movie-2-leak";


Future<ConversationsModel> createConversationsAlbum(String email) async {
  final response = await http
      .post(Uri.parse('https://test.zab.ee/api/getMessageList?user_id=$email'));
    print('called');
  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    print(response.body);
    return ConversationsModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  HomePage({this.userId});
  final userId;

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  Future<ConversationsModel>? _futureConversationsData;

  String? email;
  String? password;
  String? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Conversations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('email');
                  prefs.remove('password');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                }),
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: buildFutureBuilder(),
        ),
      ),
    );
  }

  load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    password = prefs.getString('password');
    id = prefs.getString('id');
    setState(() {
      _futureConversationsData = createConversationsAlbum(id!);
      print(id!);
    });
  }

  FutureBuilder<ConversationsModel> buildFutureBuilder() {
    return FutureBuilder<ConversationsModel>(
      future: _futureConversationsData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          return Container(
            child: ListView.builder(
                itemCount: snapshot.data!.rows,
                padding: const EdgeInsets.all(2.0),
                itemBuilder: (context, position) {
                  String img = "https://dev1.bitneuron.com/kp_service/assets/dams/img/user/no-user.png";

                  return GestureDetector(
                    key: Key('$position'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Text("data");
                        // return ChatPage(
                        //   userId: snapshot.data!.result[position].buyerId,
                        //   // user_pic: snapshot.data!.result[position]
                        //   //     .userPic,
                        //   user_pic:
                        //   "https://dev1.bitneuron.com/kp_service/assets/dams/img/user/no-user.png",
                        //   sender_name:
                        //   snapshot.data!.result[position].senderName,
                        //   loginId: xyz.toString(),
                        //   sender_id: snapshot.data!.result[position].sellerId,
                        //   product_variant_id:
                        //   snapshot.data!.result[position].productVariantId,
                        //   item_type: snapshot.data!.result[position].itemType,
                        //   loadLimit: 0,
                        //   length: 100,
                        // );
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(img),
                                  maxRadius: 40,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data!.result![position].senderName ?? "default",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text('${ snapshot.data!.result![position].productVariantId}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
