
class NotificationLawyerModel {
  List<NotificationLawyerModelData>? data;
  String? msg;
  int? status;

  NotificationLawyerModel({
    this.data,
    this.msg,
    this.status,
  });

  factory NotificationLawyerModel.fromJson(Map<String, dynamic> json) => NotificationLawyerModel(
    data: json["data"] == null ? [] : List<NotificationLawyerModelData>.from(json["data"]!.map((x) => NotificationLawyerModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class NotificationLawyerModelData {
  int? id;
  String? title;
  String? body;
  int? courtCaseId;
  int? seen;
  String? createdAt;

  NotificationLawyerModelData({
    this.id,
    this.title,
    this.body,
    this.courtCaseId,
    this.seen,
    this.createdAt,
  });

  factory NotificationLawyerModelData.fromJson(Map<String, dynamic> json) => NotificationLawyerModelData(
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
