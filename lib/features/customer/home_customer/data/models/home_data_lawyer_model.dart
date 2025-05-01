
import 'package:ataaby/features/login/data/models/login_model_lawyer.dart';

class HomeDataCustomer {
  HomeDataCustomerData? data;
  String? msg;
  int? status;

  HomeDataCustomer({
    this.data,
    this.msg,
    this.status,
  });

  factory HomeDataCustomer.fromJson(Map<String, dynamic> json) => HomeDataCustomer(
    data: json["data"] == null ? null : HomeDataCustomerData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class HomeDataCustomerData {
  List<LawyerOffer>? lawyerOffers;
  List<LoginModelLawyerData>? topRateLawyers;
  List<LoginModelLawyerData>? nearLawyers;

  HomeDataCustomerData({
    this.lawyerOffers,
    this.topRateLawyers,
    this.nearLawyers,
  });

  factory HomeDataCustomerData.fromJson(Map<String, dynamic> json) => HomeDataCustomerData(
    lawyerOffers: json["lawyerOffers"] == null ? [] : List<LawyerOffer>.from(json["lawyerOffers"]!.map((x) => LawyerOffer.fromJson(x))),
    topRateLawyers: json["topRateLawyers"] == null ? [] : List<LoginModelLawyerData>.from(json["topRateLawyers"]!.map((x) => LoginModelLawyerData.fromJson(x))),
    nearLawyers: json["nearLawyers"] == null ? [] : List<LoginModelLawyerData>.from(json["nearLawyers"]!.map((x) => LoginModelLawyerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lawyerOffers": lawyerOffers == null ? [] : List<dynamic>.from(lawyerOffers!.map((x) => x.toJson())),
    "topRateLawyers": topRateLawyers == null ? [] : List<dynamic>.from(topRateLawyers!.map((x) => x.toJson())),
    "nearLawyers": nearLawyers == null ? [] : List<dynamic>.from(nearLawyers!.map((x) => x.toJson())),
  };
}

class LawyerOffer {
  int? id;
  String? status;
  DateTime? fromDate;
  DateTime? toDate;
  dynamic link;
  String? image;
  String? adConfirmation;

  LawyerOffer({
    this.id,
    this.status,
    this.fromDate,
    this.toDate,
    this.link,
    this.image,
    this.adConfirmation,
  });

  factory LawyerOffer.fromJson(Map<String, dynamic> json) => LawyerOffer(
    id: json["id"],
    status: json["status"],
    fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
    link: json["link"],
    image: json["image"],
    adConfirmation: json["ad_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "from_date": "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
    "to_date": "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
    "link": link,
    "image": image,
    "ad_confirmation": adConfirmation,
  };
}

class OfficeRequest {
  int? id;
  String? image;
  dynamic name;
  String? type;
  dynamic level;
  int? officeId;

  OfficeRequest({
    this.id,
    this.image,
    this.name,
    this.type,
    this.level,
    this.officeId,
  });

  factory OfficeRequest.fromJson(Map<String, dynamic> json) => OfficeRequest(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    type: json["type"],
    level: json["level"],
    officeId: json["office_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "type": type,
    "level": level,
    "office_id": officeId,
  };
}