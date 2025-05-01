
class LawyerWorkTimesModel {
  List<LawyerWorkTimesModelData>? data;
  String? msg;
  int? status;

  LawyerWorkTimesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory LawyerWorkTimesModel.fromJson(Map<String, dynamic> json) => LawyerWorkTimesModel(
    data: json["data"] == null ? [] : List<LawyerWorkTimesModelData>.from(json["data"]!.map((x) => LawyerWorkTimesModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class LawyerWorkTimesModelData {
  int? id;
  String? day;
  String? from;
  String? to;
  String? status;

  LawyerWorkTimesModelData({
    this.id,
    this.day,
    this.from,
    this.to,
    this.status,
  });

  factory LawyerWorkTimesModelData.fromJson(Map<String, dynamic> json) => LawyerWorkTimesModelData(
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
