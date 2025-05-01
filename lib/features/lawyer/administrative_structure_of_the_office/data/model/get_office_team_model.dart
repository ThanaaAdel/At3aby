
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/data/model/search_lawyer_model.dart';

class GetOfficeTeamModel {
  GetOfficeTeamModelData? data;
  String? msg;
  int? status;

  GetOfficeTeamModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetOfficeTeamModel.fromJson(Map<String, dynamic> json) => GetOfficeTeamModel(
    data: json["data"] == null ? null : GetOfficeTeamModelData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class GetOfficeTeamModelData {
  List<SearchLawyerModelData>? team;
  SearchLawyerModelData? office;

  GetOfficeTeamModelData({
    this.team,
    this.office,
  });

  factory GetOfficeTeamModelData.fromJson(Map<String, dynamic> json) => GetOfficeTeamModelData(
    team: json["team"] == null ? [] : List<SearchLawyerModelData>.from(json["team"]!.map((x) => SearchLawyerModelData.fromJson(x))),
    office: json["office"] == null ? null : SearchLawyerModelData.fromJson(json["office"]),
  );

  Map<String, dynamic> toJson() => {
    "team": team == null ? [] : List<dynamic>.from(team!.map((x) => x.toJson())),
    "office": office?.toJson(),
  };
}



class Level {
  int? id;
  String? title;
  int? salary;

  Level({
    this.id,
    this.title,
    this.salary,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    id: json["id"],
    title: json["title"],
    salary: json["salary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "salary": salary,
  };
}
