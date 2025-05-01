class GetMainCancelAndFinishModel {
  List<GetRefuseReasonsModelData>? data;
  String? msg;
  int? status;

  GetMainCancelAndFinishModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetMainCancelAndFinishModel.fromJson(Map<String, dynamic> json) =>
      GetMainCancelAndFinishModel(
        data: json["data"] == null
            ? []
            : List<GetRefuseReasonsModelData>.from(json["data"]!
                .map((x) => GetRefuseReasonsModelData.fromJson(x))),
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

class GetRefuseReasonsModelData {
  int? id;
  String? name;

  GetRefuseReasonsModelData({
    this.id,
    this.name,
  });

  factory GetRefuseReasonsModelData.fromJson(Map<String, dynamic> json) =>
      GetRefuseReasonsModelData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
