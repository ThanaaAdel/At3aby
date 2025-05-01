
class GetOfficeRequestModel {
  List<Datum>? data;
  String? msg;
  int? status;

  GetOfficeRequestModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetOfficeRequestModel.fromJson(Map<String, dynamic> json) => GetOfficeRequestModel(
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
  String? image;
  dynamic name;
  String? type;
  dynamic level;
  int? officeId;

  Datum({
    this.id,
    this.image,
    this.name,
    this.type,
    this.level,
    this.officeId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    type: json["type"],
    level: json["level"],
    officeId: json["office_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "type": type,
    "level": level,
    "office_id": officeId,
  };
}
