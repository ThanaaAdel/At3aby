class DefaultMainModel {
  dynamic data;
  dynamic msg;
  int? status;

  DefaultMainModel({
    this.data,
    this.msg,
    this.status,
  });

  factory DefaultMainModel.fromJson(Map<String, dynamic> json) =>
      DefaultMainModel(
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
