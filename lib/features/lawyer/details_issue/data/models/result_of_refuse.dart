class ActionCourtCaseModel {
  ActionCourtCaseModelData? data;
  String? msg;
  int? status;

  ActionCourtCaseModel({
    this.data,
    this.msg,
    this.status,
  });

  factory ActionCourtCaseModel.fromJson(Map<String, dynamic> json) =>
      ActionCourtCaseModel(
        data: json["data"] == null
            ? null
            : ActionCourtCaseModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class ActionCourtCaseModelData {
  int? id;
  String? status;
  int? price;
  RefuseReason? refuseReason;
  String? refuseNote;
  List<dynamic>? dues;
  DateTime? createdAt;

  ActionCourtCaseModelData({
    this.id,
    this.status,
    this.price,
    this.refuseReason,
    this.refuseNote,
    this.dues,
    this.createdAt,
  });

  factory ActionCourtCaseModelData.fromJson(Map<String, dynamic> json) =>
      ActionCourtCaseModelData(
        id: json["id"],
        status: json["status"],
        price: json["price"],
        refuseReason: json["refuse_reason"] == null
            ? null
            : RefuseReason.fromJson(json["refuse_reason"]),
        refuseNote: json["refuse_note"],
        dues: json["dues"] == null
            ? []
            : List<dynamic>.from(json["dues"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "price": price,
        "refuse_reason": refuseReason?.toJson(),
        "refuse_note": refuseNote,
        "dues": dues == null ? [] : List<dynamic>.from(dues!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
      };
}

class RefuseReason {
  int? id;
  String? name;

  RefuseReason({
    this.id,
    this.name,
  });

  factory RefuseReason.fromJson(Map<String, dynamic> json) => RefuseReason(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
