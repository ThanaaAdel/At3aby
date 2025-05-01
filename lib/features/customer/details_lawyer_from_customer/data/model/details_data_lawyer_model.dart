import 'package:ataaby/features/login/data/models/login_model_lawyer.dart';

class DetailsDataLawyerModel {
  DetailsDataLawyerModelData? data;
  String? msg;
  int? status;

  DetailsDataLawyerModel({
    this.data,
    this.msg,
    this.status,
  });

  factory DetailsDataLawyerModel.fromJson(Map<String, dynamic> json) =>
      DetailsDataLawyerModel(
        data: json["data"] == null
            ? null
            : DetailsDataLawyerModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class DetailsDataLawyerModelData {
  LoginModelLawyerData? lawyer;
  Advertise? advertise;

  DetailsDataLawyerModelData({
    this.lawyer,
    this.advertise,
  });

  factory DetailsDataLawyerModelData.fromJson(Map<String, dynamic> json) =>
      DetailsDataLawyerModelData(
        lawyer: json["lawyer"] == null
            ? null
            : LoginModelLawyerData.fromJson(json["lawyer"]),
        advertise: json["advertise"] == null
            ? null
            : Advertise.fromJson(json["advertise"]),
      );

  Map<String, dynamic> toJson() => {
        "lawyer": lawyer?.toJson(),
        "advertise": advertise?.toJson(),
      };
}

class Advertise {
  int? id;
  String? status;
  DateTime? fromDate;
  DateTime? toDate;
  dynamic link;
  String? image;
  String? adConfirmation;

  Advertise({
    this.id,
    this.status,
    this.fromDate,
    this.toDate,
    this.link,
    this.image,
    this.adConfirmation,
  });

  factory Advertise.fromJson(Map<String, dynamic> json) => Advertise(
        id: json["id"],
        status: json["status"],
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        link: json["link"],
        image: json["image"],
        adConfirmation: json["ad_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "from_date":
            "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "link": link,
        "image": image,
        "ad_confirmation": adConfirmation,
      };
}

class LawyerTime {
  int? id;
  String? day;
  String? from;
  String? to;

  LawyerTime({
    this.id,
    this.day,
    this.from,
    this.to,
  });

  factory LawyerTime.fromJson(Map<String, dynamic> json) => LawyerTime(
        id: json["id"],
        day: json["day"],
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "from": from,
        "to": to,
      };
}
