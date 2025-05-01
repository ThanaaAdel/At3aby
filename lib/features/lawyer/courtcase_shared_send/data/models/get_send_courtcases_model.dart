// To parse this JSON data, do
//
//     final getSendCourtsClientModel = getSendCourtsClientModelFromJson(jsonString);

import 'dart:convert';

GetSendCourtsClientModel getSendCourtsClientModelFromJson(String str) =>
    GetSendCourtsClientModel.fromJson(json.decode(str));

String getSendCourtsClientModelToJson(GetSendCourtsClientModel data) =>
    json.encode(data.toJson());

class GetSendCourtsClientModel {
  List<GetSendCourtsClientModelData>? data;
  String? msg;
  int? status;

  GetSendCourtsClientModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetSendCourtsClientModel.fromJson(Map<String, dynamic> json) =>
      GetSendCourtsClientModel(
        data: json["data"] == null
            ? []
            : List<GetSendCourtsClientModelData>.from(json["data"]!
                .map((x) => GetSendCourtsClientModelData.fromJson(x))),
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

class GetSendCourtsClientModelData {
  int? eventId;
  String? oldLawyer;
  String? newLawyer;
  String? courtCaseName;
  int? courtCaseId;
  int? transferClientStatus;
  int? transferLawyerStatus;

  GetSendCourtsClientModelData({
    this.eventId,
    this.oldLawyer,
    this.newLawyer,
    this.courtCaseName,
    this.courtCaseId,
    this.transferClientStatus,
    this.transferLawyerStatus,
  });

  factory GetSendCourtsClientModelData.fromJson(Map<String, dynamic> json) =>
      GetSendCourtsClientModelData(
        eventId: json["event_id"],
        oldLawyer: json["old_lawyer"],
        newLawyer: json["new_lawyer"],
        courtCaseName: json["court_case_name"],
        courtCaseId: json["court_case_id"],
        transferClientStatus: json["transfer_client_status"],
        transferLawyerStatus: json["transfer_lawyer_status"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "old_lawyer": oldLawyer,
        "new_lawyer": newLawyer,
        "court_case_name": courtCaseName,
        "court_case_id": courtCaseId,
        "transfer_client_status": transferClientStatus,
        "transfer_lawyer_status": transferLawyerStatus,
      };
}
