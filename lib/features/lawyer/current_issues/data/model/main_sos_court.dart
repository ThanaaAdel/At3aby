class MainSosCourtCasesModel {
  List<MainSosCourtCasesModelDatum>? data;
  String? msg;
  int? status;

  MainSosCourtCasesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainSosCourtCasesModel.fromJson(Map<String, dynamic> json) =>
      MainSosCourtCasesModel(
        data: json["data"] == null
            ? []
            : List<MainSosCourtCasesModelDatum>.from(json["data"]!
                .map((x) => MainSosCourtCasesModelDatum.fromJson(x))),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
        "status": status,
      };
}

class MainSosCourtCasesModelDatum {
  int? id;
  String? problem;
  String? phone;
  String? address;
  String? lat;
  String? long;
  String? voice;
  String? status;
  dynamic lawyer;
  DateTime? createdAt;

  MainSosCourtCasesModelDatum({
    this.id,
    this.problem,
    this.phone,
    this.address,
    this.lat,
    this.voice,
    this.long,
    this.status,
    this.lawyer,
    this.createdAt,
  });

  factory MainSosCourtCasesModelDatum.fromJson(Map<String, dynamic> json) =>
      MainSosCourtCasesModelDatum(
        id: json["id"],
        problem: json["problem"],
        phone: json["phone"],
        address: json["address"],
        lat: json["lat"],
        long: json["long"],
        status: json["status"],
        voice: json["voice"],
        lawyer: json["lawyer"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "problem": problem,
        "phone": phone,
        "address": address,
        "lat": lat,
        "long": long,
        "voice": voice,
        "status": status,
        "lawyer": lawyer,
        "created_at": createdAt?.toIso8601String(),
      };
}
