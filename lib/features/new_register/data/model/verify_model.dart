class MainVerifyOtpModel {
  bool? data;
  String? msg;
  int? status;

  MainVerifyOtpModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainVerifyOtpModel.fromJson(Map<String, dynamic> json) =>
      MainVerifyOtpModel(
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
