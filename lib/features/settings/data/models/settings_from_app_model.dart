
class GetSettingsFromAppModel {
  List<GetSettingsFromAppModelData>? data;
  String? msg;
  int? status;

  GetSettingsFromAppModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetSettingsFromAppModel.fromJson(Map<String, dynamic> json) => GetSettingsFromAppModel(
    data: json["data"] == null ? [] : List<GetSettingsFromAppModelData>.from(json["data"]!.map((x) => GetSettingsFromAppModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class GetSettingsFromAppModelData {
  String? key;
  String? value;

  GetSettingsFromAppModelData({
    this.key,
    this.value,
  });

  factory GetSettingsFromAppModelData.fromJson(Map<String, dynamic> json) => GetSettingsFromAppModelData(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
