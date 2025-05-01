import '../../../lawyer/home_lawyer/data/model/specialist_model.dart';

class MainSpecialitiesModel {
  MainSpecialitiesModelData? data;
  String? msg;
  int? status;

  MainSpecialitiesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainSpecialitiesModel.fromJson(Map<String, dynamic> json) =>
      MainSpecialitiesModel(
        data: json["data"] == null
            ? null
            : MainSpecialitiesModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class MainSpecialitiesModelData {
  List<Speciality>? specialities;

  MainSpecialitiesModelData({
    this.specialities,
  });

  factory MainSpecialitiesModelData.fromJson(Map<String, dynamic> json) =>
      MainSpecialitiesModelData(
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
