
class PromoCodeModel {
  String? data;
  String? msg;
  int? status;

  PromoCodeModel({
    this.data,
    this.msg,
    this.status,
  });

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) => PromoCodeModel(
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
