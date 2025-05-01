
class GetCommentsModel {
  List<Datum>? data;
  String? msg;
  int? status;

  GetCommentsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetCommentsModel.fromJson(Map<String, dynamic> json) => GetCommentsModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class Datum {
  int? id;
  Author? author;
  String? comment;
  String? userType;
  String? createdAt;

  Datum({
    this.id,
    this.author,
    this.comment,
    this.userType,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    comment: json["comment"],
    userType: json["user_type"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author?.toJson(),
    "comment": comment,
    "user_type": userType,
    "created_at": createdAt,
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
