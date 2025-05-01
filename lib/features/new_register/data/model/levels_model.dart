import '../../../lawyer/home_lawyer/data/model/specialist_model.dart';

class MainLevelsModel {
  MainLevelsModelData? data;
  String? msg;
  int? status;

  MainLevelsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainLevelsModel.fromJson(Map<String, dynamic> json) =>
      MainLevelsModel(
        data: json["data"] == null
            ? null
            : MainLevelsModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class MainLevelsModelData {
  List<Level>? levels;

  MainLevelsModelData({
    this.levels,
  });

  factory MainLevelsModelData.fromJson(Map<String, dynamic> json) =>
      MainLevelsModelData(
        levels: json["levels"] == null
            ? []
            : List<Level>.from(json["levels"]!.map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "levels": levels == null
            ? []
            : List<dynamic>.from(levels!.map((x) => x.toJson())),
      };
}
