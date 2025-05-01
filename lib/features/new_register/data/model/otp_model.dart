class MainOtpModel {
  Data? data;
  String? msg;
  int? status;

  MainOtpModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainOtpModel.fromJson(Map<String, dynamic> json) => MainOtpModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class Data {
  int? otp;

  Data({
    this.otp,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}
