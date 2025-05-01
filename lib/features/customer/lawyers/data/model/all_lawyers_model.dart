import '../../../../login/data/models/login_model_lawyer.dart';

class MainCustomerLawyerModel {
  List<LoginModelLawyerData>? data;
  String? msg;
  int? status;

  MainCustomerLawyerModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainCustomerLawyerModel.fromJson(Map<String, dynamic> json) =>
      MainCustomerLawyerModel(
        data: json["data"] == null
            ? []
            : List<LoginModelLawyerData>.from(
                json["data"]!.map((x) => LoginModelLawyerData.fromJson(x))),
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
