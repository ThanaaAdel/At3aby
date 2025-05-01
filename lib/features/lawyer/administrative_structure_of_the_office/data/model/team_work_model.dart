import '../../../../login/data/models/login_model_lawyer.dart';

class MainTeamWorkModel {
  List<OfficeTeamWork>? data;
  String? msg;
  int? status;

  MainTeamWorkModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainTeamWorkModel.fromJson(Map<String, dynamic> json) =>
      MainTeamWorkModel(
        data: json["data"] == null
            ? []
            : List<OfficeTeamWork>.from(
                json["data"]!.map((x) => OfficeTeamWork.fromJson(x))),
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
