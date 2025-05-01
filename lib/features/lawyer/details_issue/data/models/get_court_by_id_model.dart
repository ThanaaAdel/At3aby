import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';

import '../../../home_lawyer/data/model/home_Laywer_model.dart';

class GetCourtCaseByIdModel {
  CourtData? data;
  String? msg;
  int? status;

  GetCourtCaseByIdModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetCourtCaseByIdModel.fromJson(Map<String, dynamic> json) =>
      GetCourtCaseByIdModel(
        data: json["data"] == null ? null : CourtData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}
