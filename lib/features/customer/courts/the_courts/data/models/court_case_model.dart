

import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';


class CourtCaseModel {
  List<CourtData>? data;
  String? msg;
  int? status;

  CourtCaseModel({
    this.data,
    this.msg,
    this.status,
  });

  factory CourtCaseModel.fromJson(Map<String, dynamic> json) => CourtCaseModel(
    data: json["data"] == null ? [] : List<CourtData>.from(json["data"]!.map((x) => CourtData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

