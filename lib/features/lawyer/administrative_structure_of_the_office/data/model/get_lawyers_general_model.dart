
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/data/model/search_lawyer_model.dart';

class GetLawyersGeneralModel {
  Data? data;
  String? msg;
  int? status;

  GetLawyersGeneralModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetLawyersGeneralModel.fromJson(Map<String, dynamic> json) => GetLawyersGeneralModel(
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
  List<SearchLawyerModelData>? lawyers;

  Data({
    this.lawyers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    lawyers: json["lawyers"] == null ? [] : List<SearchLawyerModelData>.from(json["lawyers"]!.map((x) => SearchLawyerModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lawyers": lawyers == null ? [] : List<dynamic>.from(lawyers!.map((x) => x.toJson())),
  };
}


