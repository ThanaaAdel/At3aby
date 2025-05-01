
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/data/models/send_sos_request.dart';

import '../../../../../login/data/models/login_model_lawyer.dart';

class SosLawyerRequestModel {
  SosLawyerRequestModelData? data;
  String? msg;
  int? status;

  SosLawyerRequestModel({
    this.data,
    this.msg,
    this.status,
  });

  factory SosLawyerRequestModel.fromJson(Map<String, dynamic> json) => SosLawyerRequestModel(
    data: json["data"] == null ? null : SosLawyerRequestModelData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class SosLawyerRequestModelData {
  List<LoginModelLawyerData>? nearLawyers;
  List<LoginModelLawyerData>? myLawyers;

  SosLawyerRequestModelData({
    this.nearLawyers,
    this.myLawyers,
  });

  factory SosLawyerRequestModelData.fromJson(Map<String, dynamic> json) => SosLawyerRequestModelData(
    nearLawyers: json["nearLawyers"] == null
        ? []
        : List<LoginModelLawyerData>.from(json["nearLawyers"]!.map((x) => LoginModelLawyerData.fromJson(x))),
    myLawyers: json["myLawyers"] == null
        ? []
        : List<LoginModelLawyerData>.from(json["myLawyers"]!.map((x) => LoginModelLawyerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nearLawyers": nearLawyers == null ? [] : List<dynamic>.from(nearLawyers!.map((x) => x.toJson())),
    "myLawyers": myLawyers == null ? [] : List<dynamic>.from(myLawyers!.map((x) => x.toJson())),
  };
}


