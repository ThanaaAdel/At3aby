
import 'package:ataaby/features/society/data/models/posts_model.dart';

class AddCommentFromPostModel {
  List<AddCommentFromPostModelData>? data;
  String? msg;
  int? status;

  AddCommentFromPostModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AddCommentFromPostModel.fromJson(Map<String, dynamic> json) => AddCommentFromPostModel(
    data: json["data"] == null ? [] : List<AddCommentFromPostModelData>.from(json["data"]!.map((x) => AddCommentFromPostModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class AddCommentFromPostModelData {
  int? id;
  Author? author;
  String? comment;
  List<Reply>? replies;

  AddCommentFromPostModelData({
    this.id,
    this.author,
    this.comment,
    this.replies,
  });

  factory AddCommentFromPostModelData.fromJson(Map<String, dynamic> json) => AddCommentFromPostModelData(
    id: json["id"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    comment: json["comment"],
    replies: json["replies"] == null ? [] : List<Reply>.from(json["replies"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author?.toJson(),
    "comment": comment,
    "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x)),
  };
}

class Reply {
  int? id;
  Author? author;
  String? reply;
  List<dynamic>? replies;

  Reply({
    this.id,
    this.author,
    this.reply,
    this.replies,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    id: json["id"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    reply: json["reply"],
    replies: json["replies"] == null ? [] : List<dynamic>.from(json["replies"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author?.toJson(),
    "reply": reply,
    "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x)),
  };
}

