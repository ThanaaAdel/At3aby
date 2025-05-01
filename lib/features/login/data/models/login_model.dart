import 'package:ataaby/features/new_register/data/model/city_model.dart';

class LoginModel {
  LoginModelData? data;
  String? msg;
  int? status;

  LoginModel({
    this.data,
    this.msg,
    this.status,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data:
            json["data"] == null ? null : LoginModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class LoginModelData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? nationalId;
  String? points;
  City? city;
  String? status;
  String? token;
  String? image;

  LoginModelData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.nationalId,
    this.points,
    this.image,
    this.city,
    this.status,
    this.token,
  });

  factory LoginModelData.fromJson(Map<String, dynamic> json) => LoginModelData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        nationalId: json["national_id"],
        points: json["points"],
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        status: json["status"],
        image: json["image"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "national_id": nationalId,
        "points": points,
        "city": city?.toJson(),
        "status": status,
        "token": token,
    "image": image,

      };
}
