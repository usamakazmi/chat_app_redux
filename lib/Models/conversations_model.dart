// To parse this JSON data, do
//
//     final kaygeesModel = kaygeesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

ConversationsModel conversationssModelFromJson(String str) => ConversationsModel.fromJson(json.decode(str));

String conversationsModelToJson(ConversationsModel data) => json.encode(data.toJson());

class ConversationsModel {
  ConversationsModel({
    required this.rows,
    required this.result,
  });

  int rows;
  List<Result> result;

  factory ConversationsModel.fromJson(Map<String, dynamic> json) => ConversationsModel(
    rows: json["rows"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "rows": rows,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.messageId,
    required this.userid,
    required this.senderName,
    required this.userPic,
    required this.subject,
    required this.message,
    required this.productVariantId,
    required this.itemType,
    required this.sellerId,
    required this.buyerId,
    required this.itemId,
    required this.seenDatetime,
    required this.sentDatetime,
    required this.picCheck,
    required this.productLink,
    required this.productId,
    required this.productName,
    required this.storeName,
  });



  String messageId;
  String userid;
  String senderName;
  dynamic userPic;
  dynamic subject;
  String message;
  String productVariantId;
  String itemType;
  String sellerId;
  String buyerId;
  String itemId;
  dynamic seenDatetime;
  DateTime sentDatetime;
  String picCheck;
  String productLink;
  String productId;
  String productName;
  String storeName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    messageId: json["message_id"],
    userid: json["userid"],
    senderName: json["sender_name"],
    userPic: json["user_pic"],
    subject: json["subject"],
    message: json["message"],
    productVariantId: json["product_variant_id"],
    itemType: json["item_type"],
    sellerId: json["seller_id"],
    buyerId: json["buyer_id"],
    itemId: json["item_id"],
    seenDatetime: json["seen_datetime"],
    sentDatetime: DateTime.parse(json["sent_datetime"]),
    picCheck: json["picCheck"],
    productLink: json["product_link"],
    productId: json["product_id"],
    productName: json["product_name"],
    storeName: json["store_name"],
  );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
    "userid": userid,
    "sender_name": senderName,
    "user_pic": userPic,
    "subject": subject,
    "message": message,
    "product_variant_id": productVariantId,
    "item_type": itemType,
    "seller_id": sellerId,
    "buyer_id": buyerId,
    "item_id": itemId,
    "seen_datetime": seenDatetime,
    "sent_datetime": sentDatetime.toIso8601String(),
    "picCheck": picCheck,
    "product_link": productLink,
    "product_id": productId,
    "product_name": productName,
    "store_name": storeName,
  };
}
