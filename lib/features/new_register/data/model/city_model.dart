import 'country_model.dart';

class MainCityModel {
  MainCityModelData? data;
  String? msg;
  int? status;

  MainCityModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainCityModel.fromJson(Map<String, dynamic> json) => MainCityModel(
        data: json["data"] == null
            ? null
            : MainCityModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class MainCityModelData {
  List<City>? cities;

  MainCityModelData({
    this.cities,
  });

  factory MainCityModelData.fromJson(Map<String, dynamic> json) =>
      MainCityModelData(
        cities: json["cities"] == null
            ? []
            : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cities": cities == null
            ? []
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class City {
  int? id;
  String? title;
  Country? country;

  City({
    this.id,
    this.title,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        title: json["title"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "country": country?.toJson(),
      };
}
