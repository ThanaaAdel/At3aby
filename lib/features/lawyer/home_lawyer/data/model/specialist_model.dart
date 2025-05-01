
class GetSpecialitieslawyer {
  Data? data;
  String? msg;
  int? status;

  GetSpecialitieslawyer({
    this.data,
    this.msg,
    this.status,
  });

  factory GetSpecialitieslawyer.fromJson(Map<String, dynamic> json) =>
      GetSpecialitieslawyer(
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
  List<Speciality>? specialities;

  Data({
    this.specialities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        specialities: json["specialities"] == null
            ? []
            : List<Speciality>.from(
                json["specialities"]!.map((x) => Speciality.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "specialities": specialities == null
            ? []
            : List<dynamic>.from(specialities!.map((x) => x.toJson())),
      };
}

class Speciality {
  int? id;
  String? title;
  Level? level;
  String? status;

  Speciality({
    this.id,
    this.title,
    this.level,
    this.status,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
        id: json["id"],
        title: json["title"],
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "level": level?.toJson(),
        "status": status,
      };
}

class Level {
  int? id;
  String? title;
  int? salary;

  Level({
    this.id,
    this.title,
    this.salary,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        title: json["title"],
        salary: json["salary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "salary": salary,
      };
}
