import '../../../home_lawyer/data/model/home_Laywer_model.dart';

class MainMyCourtCasesModel {
  List<NewCourtCase>? data;
  String? msg;
  int? status;

  MainMyCourtCasesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainMyCourtCasesModel.fromJson(Map<String, dynamic> json) =>
      MainMyCourtCasesModel(
        data: json["data"] == null
            ? []
            : List<NewCourtCase>.from(
                json["data"]!.map((x) => NewCourtCase.fromJson(x))),
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
