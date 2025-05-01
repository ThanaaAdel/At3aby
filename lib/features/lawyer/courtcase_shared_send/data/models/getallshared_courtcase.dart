class GetAllCourtCaseSharedModel {
  List<GetAllCourtCaseSharedModelData>? data;
  String? msg;
  int? status;

  GetAllCourtCaseSharedModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetAllCourtCaseSharedModel.fromJson(Map<String, dynamic> json) =>
      GetAllCourtCaseSharedModel(
        data: json["data"] == null
            ? []
            : List<GetAllCourtCaseSharedModelData>.from(json["data"]!
                .map((x) => GetAllCourtCaseSharedModelData.fromJson(x))),
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

class GetAllCourtCaseSharedModelData {
  int? eventId;
  String? courtCaseName;
  int? courtCaseId;
  int? partnerId;
  dynamic contributionPrice;
  String? contributionComment;

  GetAllCourtCaseSharedModelData({
    this.eventId,
    this.courtCaseName,
    this.courtCaseId,
    this.partnerId,
    this.contributionPrice,
    this.contributionComment,
  });

  factory GetAllCourtCaseSharedModelData.fromJson(Map<String, dynamic> json) =>
      GetAllCourtCaseSharedModelData(
        eventId: json["event_id"],
        courtCaseName: json["court_case_name"],
        courtCaseId: json["court_case_id"],
        partnerId: json["partner_id"],
        contributionPrice: json["contribution_price"],
        contributionComment: json["contribution_comment"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "court_case_name": courtCaseName,
        "court_case_id": courtCaseId,
        "partner_id": partnerId,
        "contribution_price": contributionPrice,
        "contribution_comment": contributionComment,
      };
}
