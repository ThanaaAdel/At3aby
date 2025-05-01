
import 'package:ataaby/features/new_register/data/model/city_model.dart';

class PersonalDataCustomerModel {
  Data? data;
  String? msg;
  int? status;

  PersonalDataCustomerModel({
    this.data,
    this.msg,
    this.status,
  });

  factory PersonalDataCustomerModel.fromJson(Map<String, dynamic> json) => PersonalDataCustomerModel(
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
  int? id;
  String? name;
  String? image;
  String? email;
  String? phone;
  String? nationalId;
  String? points;
  City? city;
  String? status;
  String? token;
  int? ratesCount;
  dynamic rates;

  Data({
    this.id,
    this.name,
    this.image,
    this.email,
    this.phone,
    this.nationalId,
    this.points,
    this.city,
    this.status,
    this.token,
    this.ratesCount,
    this.rates,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    email: json["email"],
    phone: json["phone"],
    nationalId: json["national_id"],
    points: json["points"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    status: json["status"],
    token: json["token"],
    ratesCount: json["rates_count"],
    rates: json["rates"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "email": email,
    "phone": phone,
    "national_id": nationalId,
    "points": points,
    "city": city?.toJson(),
    "status": status,
    "token": token,
    "rates_count": ratesCount,
    "rates": rates,
  };
}

// class City {
//   int? id;
//   String? title;
//   Country? country;
//
//   City({
//     this.id,
//     this.title,
//     this.country,
//   });
//
//   factory City.fromJson(Map<String, dynamic> json) => City(
//     id: json["id"],
//     title: json["title"],
//     country: json["country"] == null ? null : Country.fromJson(json["country"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "country": country?.toJson(),
//   };
// }
//
// class Country {
//   int? id;
//   String? title;
//   String? currency;
//
//   Country({
//     this.id,
//     this.title,
//     this.currency,
//   });
//
//   factory Country.fromJson(Map<String, dynamic> json) => Country(
//     id: json["id"],
//     title: json["title"],
//     currency: json["currency"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "currency": currency,
//   };
// }
