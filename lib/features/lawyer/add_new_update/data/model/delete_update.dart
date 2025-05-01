class LawyerDeleteUpdateModel {
  dynamic data;
  String? msg;
  int? status;

  LawyerDeleteUpdateModel({
    this.data,
    this.msg,
    this.status,
  });

  factory LawyerDeleteUpdateModel.fromJson(Map<String, dynamic> json) =>
      LawyerDeleteUpdateModel(
        data: json["data"],
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "msg": msg,
        "status": status,
      };
}
