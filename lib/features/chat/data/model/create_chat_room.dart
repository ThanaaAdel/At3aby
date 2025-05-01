// To parse this JSON data, do
//
//     final mainCreateChatRoomModel = mainCreateChatRoomModelFromJson(jsonString);

import 'dart:convert';

MainCreateChatRoomModel mainCreateChatRoomModelFromJson(String str) =>
    MainCreateChatRoomModel.fromJson(json.decode(str));

String mainCreateChatRoomModelToJson(MainCreateChatRoomModel data) =>
    json.encode(data.toJson());

class MainCreateChatRoomModel {
  Data? data;
  String? msg;
  int? status;

  MainCreateChatRoomModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainCreateChatRoomModel.fromJson(Map<String, dynamic> json) =>
      MainCreateChatRoomModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class Data {
  int? id;
  String? uuid;
  User? user;

  Data({
    this.id,
    this.uuid,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uuid: json["uuid"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? image;

  User({
    this.id,
    this.name,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
