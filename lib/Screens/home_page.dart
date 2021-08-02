import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app_redux/Models/conversations_model.dart';
import 'package:chat_app_redux/Models/login_model.dart';

import 'package:chat_app_redux/Models/sharedPref.dart';

String xyz =
    "https://www.comingsoon.net/anime/news/1172796-dragon-ball-super-movie-2-leak";

Future<LoginModel> createLoginAlbum(String email, String password) async {
  //print(email + password);

  final response = await http.post(
    Uri.parse('https://test.zab.ee/api/login'),
    body: {'email': '$email', 'password': '$password'},
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return LoginModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<ConversationsModel> createConversationsAlbum(String email) async {
  final response = await http
      .post(Uri.parse('https://test.zab.ee/api/getMessageList?user_id=$email'));

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    //print(response.body);
    return ConversationsModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  HomePage({this.userId});
  //HomePage({this.name, this.password});
  final userId;
  //final name;
  //final password;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  Future<LoginModel>? _futureLoginData;

  SharedPref sharedPref = SharedPref();
  Future<LoginModel>? sharedPrefLoginData;

  Future<ConversationsModel>? _futureConversationsData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefLoginData = loadSharedPrefs2();
    print(sharedPrefLoginData.toString().length);
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
                onPressed: () {
                  //Implement logout functionality
                  setState(() {
                    sharedPref.clear();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                }),
          ],
          //title: Center(child: Text('Conversations')),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureLoginData == null) ? (sharedPrefLoginData.toString().length ==32 ) ? buildColumn() : buildFutureBuilder2() : buildFutureBuilder1(),
          //child: gdet(),
        ),
      ),
    );
  }
  Future<LoginModel> loadSharedPrefs2() async {
    LoginModel user =
    LoginModel.fromJson(await sharedPref.read("user"));
    return user;
  }

  Future<Result> loadSharedPrefs() async {

    Result convo = Result.fromJson(await sharedPref.read("user"));
    print('i AM ${convo}');
    return convo;
  }
  FutureBuilder<Result> gdet() {

    Future<Result> userSave  = loadSharedPrefs();
    print(userSave.asStream().length);

    return FutureBuilder<Result>(
      future: userSave,
      builder: (context, snapshot) {
        if (snapshot.hasData) {


          return Container(
            child: ListView.builder(
                itemCount: 2,
                padding: const EdgeInsets.all(2.0),
                itemBuilder: (context, position) {
                  String img =
                    "https://dev1.bitneuron.com/kp_service/assets/dams/img/user/no-user.png";

                  return GestureDetector(
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
                                         //'${snapshot.data!.result!.length}',
                                          '${snapshot.data!.senderName}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        //Text('${ snapshot.data!.result!.length}'),
                                        Text('${ snapshot.data!.productVariantId}'),
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
          return Text('I am Error: ${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );

  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Enter Title'),
          key: const Key('email'),
        ),
        TextField(
          controller: _controller2,
          decoration: InputDecoration(hintText: 'Enter password'),
          key: const Key('password'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              //_futureAlbum = createAlbum(_controller.text);
              _futureLoginData =
                  createLoginAlbum(_controller.text, _controller2.text);
            });
          },
          child: Text(
            'Login',
            key: const Key('increment'),
          ),
        ),
      ],
    );
  }

  FutureBuilder<LoginModel> buildFutureBuilder2() {

    //sharedPref.clear();
    return FutureBuilder<LoginModel>(
      future: sharedPrefLoginData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          xyz = snapshot.data!.userid!;
          print(snapshot.data!.userid!);
          //print(xyz);


          _futureConversationsData = createConversationsAlbum(xyz);
          //print(snapshot.data!.userid);
          return buildFutureBuilder(snapshot.data!.userid.toString());
          // return Image.network(
          //   xyz,
          //   fit: BoxFit.cover,
          // );
          return Text(snapshot.data!.email!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }

  FutureBuilder<LoginModel> buildFutureBuilder1() {
    //SharedPref sharedPref = SharedPref();
    //sharedPref.clear();
    return FutureBuilder<LoginModel>(
      future: _futureLoginData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          xyz = snapshot.data!.userid!;
          print(snapshot.data);
          //print(xyz);
          LoginModel userSave = LoginModel();
          userSave.email = snapshot.data!.email;
          userSave.firstname = snapshot.data!.firstname;
          userSave.lastname = snapshot.data!.lastname;
          userSave.user_type = snapshot.data!.user_type;
          userSave.userid = snapshot.data!.userid;
          userSave.user_pic = snapshot.data!.user_pic;
          userSave.password = snapshot.data!.password;
          userSave.status = snapshot.data!.status;
          userSave.msg = snapshot.data!.msg;

          sharedPref.save("user", userSave);

          _futureConversationsData = createConversationsAlbum(xyz);
          //print(snapshot.data!.userid);
          return buildFutureBuilder(snapshot.data!.userid.toString());
          // return Image.network(
          //   xyz,
          //   fit: BoxFit.cover,
          // );
          return Text(snapshot.data!.email!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }

  FutureBuilder<ConversationsModel> buildFutureBuilder(String uid) {
    return FutureBuilder<ConversationsModel>(
      future: _futureConversationsData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Result> users = snapshot.data!.result!.toList();
          print(users);
          List<String> sName = [];
          List<int> index = [];

          //List<String> uId = [];
          List<String> uPic = [];


          for (int i = 0; i < snapshot.data!.rows!; i++) {
            print(snapshot.data!.result![i]);
          }

          return Container(
            child: ListView.builder(
                itemCount: snapshot.data!.rows,
                padding: const EdgeInsets.all(2.0),
                itemBuilder: (context, position) {
                  String img;
                  if (snapshot.data!.result![position].userPic == null) {
                    img =
                        "https://dev1.bitneuron.com/kp_service/assets/dams/img/user/no-user.png";
                  } else {
                    img = snapshot.data!.result![position].userPic ?? "https://dev1.bitneuron.com/kp_service/assets/dams/img/user/no-user.png";
                    img =
                        "https://dev1.bitneuron.com/kp_service/assets/dams/img/user/no-user.png";
                  }

                  //TODO:Save data in shared prefences
                  // SharedPref sharedPref = SharedPref();
                  // sharedPref.clear();
                  // //ConversationsModel userSave = ConversationsModel(rows: snapshot.data!.rows!,result: snapshot.data!.result!);
                  // // Result userSave = Result(
                  // //     messageId: snapshot.data!.result![position].messageId,
                  // //     userid: snapshot.data!.result![position].userid,
                  // //     senderName: snapshot.data!.result![position].senderName,
                  // //     userPic: snapshot.data!.result![position].userPic,
                  // //     subject: snapshot.data!.result![position].subject,
                  // //     message: snapshot.data!.result![position].message,
                  // //     productVariantId: snapshot.data!.result![position].productVariantId,
                  // //     itemType: snapshot.data!.result![position].itemType,
                  // //     sellerId: snapshot.data!.result![position].sellerId,
                  // //     buyerId: snapshot.data!.result![position].buyerId,
                  // //     itemId: snapshot.data!.result![position].itemId,
                  // //     seenDatetime: snapshot.data!.result![position].seenDatetime,
                  // //     sentDatetime: snapshot.data!.result![position].sentDatetime,
                  // //     picCheck: snapshot.data!.result![position].picCheck,
                  // //     productLink: snapshot.data!.result![position].productLink,
                  // //     productId: snapshot.data!.result![position].productId,
                  // //     productName: snapshot.data!.result![position].productName,
                  // //     storeName: snapshot.data!.result![position].storeName);
                  // Result userSave = Result();
                  //
                  // userSave.messageId = snapshot.data!.result![position].messageId;
                  // userSave.userid = snapshot.data!.result![position].userid;
                  // userSave.senderName = snapshot.data!.result![position].senderName;
                  // userSave.userPic = snapshot.data!.result![position].userPic;
                  // userSave.subject = snapshot.data!.result![position].subject;
                  // userSave.message = snapshot.data!.result![position].message;
                  // userSave.productVariantId = snapshot.data!.result![position].productVariantId;
                  // userSave.itemType = snapshot.data!.result![position].itemType;
                  // userSave.sellerId = snapshot.data!.result![position].sellerId;
                  // userSave.buyerId = snapshot.data!.result![position].buyerId;
                  // userSave.itemId = snapshot.data!.result![position].itemId;
                  // userSave.seenDatetime = snapshot.data!.result![position].seenDatetime;
                  // userSave.sentDatetime = snapshot.data!.result![position].sentDatetime;
                  // userSave.picCheck = snapshot.data!.result![position].picCheck;
                  // userSave.productLink = snapshot.data!.result![position].productLink;
                  // userSave.productId = snapshot.data!.result![position].productId;
                  // userSave.productName = snapshot.data!.result![position].productName;
                  // userSave.storeName = snapshot.data!.result![position].storeName;
                  //
                  // sharedPref.save("user", userSave.toJson());
                  //
                  // loadSharedPrefs() async {
                  //   Result user =
                  //   Result.fromJson(await sharedPref.read("user"));
                  //   userSave = user;
                  // }
                  //
                  // loadSharedPrefs();
                  // print('This ${userSave.toJson().toString()}');

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
                                          snapshot.data!.result![position].senderName ?? "efault",
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
