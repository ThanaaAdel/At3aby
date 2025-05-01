
import 'posts_model.dart';

class PostModel {
  AddPostModelData? data;
  String? msg;
  int? status;

  PostModel({
    this.data,
    this.msg,
    this.status,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    data: json["data"] == null ? null : AddPostModelData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class AddPostModelData {
  int? id;
  Author? author;
  String? authorType;
  String? body;
  List<FileElement>? files;
  int? countLike;
  int? countDislike;
  String? createdAt;

  AddPostModelData({
    this.id,
    this.author,
    this.authorType,
    this.body,
    this.files,
    this.countLike,
    this.countDislike,
    this.createdAt,
  });

  factory AddPostModelData.fromJson(Map<String, dynamic> json) => AddPostModelData(
    id: json["id"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    authorType: json["author_type"],
    body: json["body"],
    files: json["files"] == null ? [] : List<FileElement>.from(json["files"]!.map((x) => FileElement.fromJson(x))),
    countLike: json["count_like"],
    countDislike: json["count_dislike"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author?.toJson(),
    "author_type": authorType,
    "body": body,
    "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
    "count_like": countLike,
    "count_dislike": countDislike,
    "created_at": createdAt,
  };
}


class LawyerTime {
  int? id;
  String? day;
  String? from;
  String? to;
  String? status;

  LawyerTime({
    this.id,
    this.day,
    this.from,
    this.to,
    this.status,
  });

  factory LawyerTime.fromJson(Map<String, dynamic> json) => LawyerTime(
    id: json["id"],
    day: json["day"],
    from: json["from"],
    to: json["to"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day": day,
    "from": from,
    "to": to,
    "status": status,
  };
}

class FileElement {
  int? id;
  String? file;
  String? type;

  FileElement({
    this.id,
    this.file,
    this.type,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    id: json["id"],
    file: json["file"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file": file,
    "type": type,
  };
}
