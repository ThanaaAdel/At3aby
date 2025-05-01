
import '../../../../login/data/models/login_model_lawyer.dart';

class AllLawyersModel {
  List<LoginModelLawyer>? data;
  String? msg;
  int? status;

  AllLawyersModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AllLawyersModel.fromJson(Map<String, dynamic> json) => AllLawyersModel(
    data: json["data"] == null ? [] : List<LoginModelLawyer>.from(json["data"]!.map((x) => LoginModelLawyer.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}
