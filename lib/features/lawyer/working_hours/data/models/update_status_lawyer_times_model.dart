
class UpdateStatusLawyerTimesModel {
  Data? data;
  String? msg;
  int? status;

  UpdateStatusLawyerTimesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory UpdateStatusLawyerTimesModel.fromJson(Map<String, dynamic> json) => UpdateStatusLawyerTimesModel(
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
  int? lawyerId;
  String? day;
  String? from;
  String? to;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Data({
    this.id,
    this.lawyerId,
    this.day,
    this.from,
    this.to,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    lawyerId: json["lawyer_id"],
    day: json["day"],
    from: json["from"],
    to: json["to"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lawyer_id": lawyerId,
    "day": day,
    "from": from,
    "to": to,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
