
class GetCommunityServiceDetailsFromCategoriesModel {
  List<Datum>? data;
  String? msg;
  int? status;

  GetCommunityServiceDetailsFromCategoriesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetCommunityServiceDetailsFromCategoriesModel.fromJson(Map<String, dynamic> json) => GetCommunityServiceDetailsFromCategoriesModel(
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
  String? body;

  Datum({
    this.id,
    this.body,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": body,
  };
}
