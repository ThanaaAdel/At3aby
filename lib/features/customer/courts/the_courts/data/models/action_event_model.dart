
class ActionEventModel {
  Data? data;
  String? msg;
  int? status;

  ActionEventModel({
    this.data,
    this.msg,
    this.status,
  });

  factory ActionEventModel.fromJson(Map<String, dynamic> json) => ActionEventModel(
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
  String? lawyerName;
  String? lawyerLevel;
  String? lawyerImage;
  int? rateCount;
  dynamic avgRate;
  String? status;
  int? price;
  dynamic refuseReason;
  dynamic refuseNote;
  List<dynamic>? dues;
  DateTime? createdAt;

  Data({
    this.id,
    this.lawyerName,
    this.lawyerLevel,
    this.lawyerImage,
    this.rateCount,
    this.avgRate,
    this.status,
    this.price,
    this.refuseReason,
    this.refuseNote,
    this.dues,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    lawyerName: json["lawyer_name"],
    lawyerLevel: json["lawyer_level"],
    lawyerImage: json["lawyer_image"],
    rateCount: json["rate_count"],
    avgRate: json["avg_rate"],
    status: json["status"],
    price: json["price"],
    refuseReason: json["refuse_reason"],
    refuseNote: json["refuse_note"],
    dues: json["dues"] == null ? [] : List<dynamic>.from(json["dues"]!.map((x) => x)),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lawyer_name": lawyerName,
    "lawyer_level": lawyerLevel,
    "lawyer_image": lawyerImage,
    "rate_count": rateCount,
    "avg_rate": avgRate,
    "status": status,
    "price": price,
    "refuse_reason": refuseReason,
    "refuse_note": refuseNote,
    "dues": dues == null ? [] : List<dynamic>.from(dues!.map((x) => x)),
    "created_at": createdAt?.toIso8601String(),
  };
}
