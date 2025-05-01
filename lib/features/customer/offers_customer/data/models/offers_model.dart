class OffersModel {
  OffersModelData? data;
  String? msg;
  int? status;

  OffersModel({
    this.data,
    this.msg,
    this.status,
  });

  factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
        data: json["data"] == null
            ? null
            : OffersModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class OffersModelData {
  List<LawyerOffer>? lawyerOffers;

  OffersModelData({
    this.lawyerOffers,
  });

  factory OffersModelData.fromJson(Map<String, dynamic> json) =>
      OffersModelData(
        lawyerOffers: json["lawyerOffers"] == null
            ? []
            : List<LawyerOffer>.from(
                json["lawyerOffers"]!.map((x) => LawyerOffer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lawyerOffers": lawyerOffers == null
            ? []
            : List<dynamic>.from(lawyerOffers!.map((x) => x.toJson())),
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
