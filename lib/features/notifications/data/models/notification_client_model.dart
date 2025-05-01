
class NotificationClientModel {
  List<NotificationClientModelData>? data;
  String? msg;
  int? status;

  NotificationClientModel({
    this.data,
    this.msg,
    this.status,
  });

  factory NotificationClientModel.fromJson(Map<String, dynamic> json) => NotificationClientModel(
    data: json["data"] == null ? [] : List<NotificationClientModelData>.from(json["data"]!.map((x) => NotificationClientModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class NotificationClientModelData {
  int? id;
  String? title;
  String? body;
  int? courtCaseId;
  int? seen;
  String? createdAt;

  NotificationClientModelData({
    this.id,
    this.title,
    this.body,
    this.courtCaseId,
    this.seen,
    this.createdAt,
  });

  factory NotificationClientModelData.fromJson(Map<String, dynamic> json) => NotificationClientModelData(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    courtCaseId: json["court_case_id"],
    seen: json["seen"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "court_case_id": courtCaseId,
    "seen": seen,
    "created_at": createdAt,
  };
}
