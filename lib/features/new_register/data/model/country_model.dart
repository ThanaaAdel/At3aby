class MainCountryModel {
  MainCountryModelData? data;
  String? msg;
  int? status;

  MainCountryModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainCountryModel.fromJson(Map<String, dynamic> json) =>
      MainCountryModel(
        data: json["data"] == null
            ? null
            : MainCountryModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class MainCountryModelData {
  List<Country>? countries;

  MainCountryModelData({
    this.countries,
  });

  factory MainCountryModelData.fromJson(Map<String, dynamic> json) =>
      MainCountryModelData(
        countries: json["countries"] == null
            ? []
            : List<Country>.from(
                json["countries"]!.map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x.toJson())),
      };
}

class Country {
  int? id;
  String? title;
  String? currency;

  Country({
    this.id,
    this.title,
    this.currency,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        title: json["title"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "currency": currency,
      };
}
