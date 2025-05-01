
class GetRepliesModel {
  List<GetRepliesModelData>? data;
  String? msg;
  int? status;

  GetRepliesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetRepliesModel.fromJson(Map<String, dynamic> json) => GetRepliesModel(
    data: json["data"] == null ? [] : List<GetRepliesModelData>.from(json["data"]!.map((x) => GetRepliesModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class GetRepliesModelData {
  int? id;
  Author? author;
  String? reply;
  String? userType;
  DateTime? createdAt;

  GetRepliesModelData({
    this.id,
    this.author,
    this.reply,
    this.userType,
    this.createdAt,
  });

  factory GetRepliesModelData.fromJson(Map<String, dynamic> json) => GetRepliesModelData(
    id: json["id"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    reply: json["reply"],
    userType: json["user_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author?.toJson(),
    "reply": reply,
    "user_type": userType,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Author {
  int? id;
  String? name;
  String? image;

  Author({
    this.id,
    this.name,
    this.image,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
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
