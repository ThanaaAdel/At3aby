class AddCourtCaseDuesModel {
  Data? data;
  String? msg;
  int? status;

  AddCourtCaseDuesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AddCourtCaseDuesModel.fromJson(Map<String, dynamic> json) =>
      AddCourtCaseDuesModel(
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
  String? status;
  int? price;
  dynamic refuseReason;
  dynamic refuseNote;
  List<Due>? dues;
  DateTime? createdAt;

  Data({
    this.id,
    this.status,
    this.price,
    this.refuseReason,
    this.refuseNote,
    this.dues,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        status: json["status"],
        price: json["price"],
        refuseReason: json["refuse_reason"],
        refuseNote: json["refuse_note"],
        dues: json["dues"] == null
            ? []
            : List<Due>.from(json["dues"]!.map((x) => Due.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "price": price,
        "refuse_reason": refuseReason,
        "refuse_note": refuseNote,
        "dues": dues == null
            ? []
            : List<dynamic>.from(dues!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
      };
}

class Due {
  int? id;
  String? title;
  DateTime? date;
  int? price;

  Due({
    this.id,
    this.title,
    this.date,
    this.price,
  });

  factory Due.fromJson(Map<String, dynamic> json) => Due(
        id: json["id"],
        title: json["title"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "price": price,
      };
}
