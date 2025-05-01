// To parse this JSON data, do
//
//     final loginModelLawyer = loginModelLawyerFromJson(jsonString);

import '../../../lawyer/home_lawyer/data/model/specialist_model.dart';
import '../../../new_register/data/model/country_model.dart';

class LoginModelLawyer {
  LoginModelLawyerData? data;
  String? msg;
  dynamic status;

  LoginModelLawyer({
    this.data,
    this.msg,
    this.status,
  });

  factory LoginModelLawyer.fromJson(Map<String, dynamic> json) =>
      LoginModelLawyer(
        data: json["data"] == null
            ? null
            : LoginModelLawyerData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class LoginModelLawyerData {
  int? id;
  String? image;
  String? name;
  String? email;
  String? phone;
  String? nationalId;
  String? lawyerId;
  String? type;
  Level? level;
  Country? country;
  LoginCity? city;
  String? status;
  List<LawyerSpeciality>? lawyerSpecialities;
  List<dynamic>? lawyerRates;
  int? rateCount;
  dynamic avgRate;
  String? officeAddress;
  String? lat;
  String? lng;
  int? successCase;
  int? failedCase;
  String? publicWork;
  String? about;
  dynamic consultationFee;
  dynamic attorneyFee;
  List<Time>? lawyerTimes;
  List<OfficeTeamWork>? officeTeamWork;
  String? token;

  LoginModelLawyerData({
    this.id,
    this.image,
    this.name,
    this.email,
    this.phone,
    this.nationalId,
    this.lawyerId,
    this.type,
    this.level,
    this.country,
    this.city,
    this.status,
    this.lawyerSpecialities,
    this.lawyerRates,
    this.rateCount,
    this.avgRate,
    this.officeAddress,
    this.lat,
    this.lng,
    this.successCase,
    this.failedCase,
    this.publicWork,
    this.about,
    this.consultationFee,
    this.attorneyFee,
    this.lawyerTimes,
    this.officeTeamWork,
    this.token,
  });

  factory LoginModelLawyerData.fromJson(Map<String, dynamic> json) =>
      LoginModelLawyerData(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        nationalId: json["national_id"],
        lawyerId: json["lawyer_id"],
        type: json["type"],
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        city: json["city"] == null ? null : LoginCity.fromJson(json["city"]),
        status: json["status"],
        lawyerSpecialities: json["lawyer_specialities"] == null
            ? []
            : List<LawyerSpeciality>.from(json["lawyer_specialities"]!
                .map((x) => LawyerSpeciality.fromJson(x))),
        lawyerRates: json["lawyer_rates"] == null
            ? []
            : List<dynamic>.from(json["lawyer_rates"]!.map((x) => x)),
        rateCount: json["rate_count"],
        avgRate: json["avg_rate"],
        officeAddress: json["office_address"],
        lat: json["lat"],
        lng: json["lng"],
        successCase: json["success_case"],
        failedCase: json["failed_case"],
        publicWork: json["public_work"],
        about: json["about"],
        consultationFee: json["consultation_fee"],
        attorneyFee: json["attorney_fee"],
        lawyerTimes: json["lawyer_times"] == null
            ? []
            : List<Time>.from(
                json["lawyer_times"].map((x) => Time.fromJson(x))),
        officeTeamWork: json["office_team_work"] == null
            ? []
            : List<OfficeTeamWork>.from(json["office_team_work"]!
                .map((x) => OfficeTeamWork.fromJson(x))),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
        "phone": phone,
        "national_id": nationalId,
        "lawyer_id": lawyerId,
        "type": type,
        "level": level?.toJson(),
        "country": country?.toJson(),
        "city": city?.toJson(),
        "status": status,
        "lawyer_specialities": lawyerSpecialities == null
            ? []
            : List<dynamic>.from(lawyerSpecialities!.map((x) => x.toJson())),
        "lawyer_rates": lawyerRates == null
            ? []
            : List<dynamic>.from(lawyerRates!.map((x) => x)),
        "rate_count": rateCount,
        "avg_rate": avgRate,
        "office_address": officeAddress,
        "lat": lat,
        "lng": lng,
        "success_case": successCase,
        "failed_case": failedCase,
        "public_work": publicWork,
        "about": about,
        "consultation_fee": consultationFee,
        "attorney_fee": attorneyFee,
        "lawyer_times": lawyerTimes == null
            ? []
            : List<dynamic>.from(lawyerTimes!.map((x) => x.toJson())),
        "office_team_work": officeTeamWork == null
            ? []
            : List<dynamic>.from(officeTeamWork!.map((x) => x.toJson())),
        "token": token,
      };
}

class LoginCity {
  int? id;
  String? title;
  Country? country;

  LoginCity({
    this.id,
    this.title,
    this.country,
  });

  factory LoginCity.fromJson(Map<String, dynamic> json) => LoginCity(
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

// class Country {
//   int? id;
//   String? title;
//   String? currency;

//   Country({
//     this.id,
//     this.title,
//     this.currency,
//   });

//   factory Country.fromJson(Map<String, dynamic> json) => Country(
//         id: json["id"],
//         title: json["title"],
//         currency: json["currency"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "currency": currency,
//       };
// }

class LawyerSpeciality {
  int? id;
  Speciality? speciality;

  LawyerSpeciality({
    this.id,
    this.speciality,
  });

  factory LawyerSpeciality.fromJson(Map<String, dynamic> json) =>
      LawyerSpeciality(
        id: json["id"],
        speciality: json["speciality"] == null
            ? null
            : Speciality.fromJson(json["speciality"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "speciality": speciality?.toJson(),
      };
}

class OfficeTeamWork {
  int? id;
  String? image;
  String? name;
  String? type;
  Level? level;

  OfficeTeamWork({
    this.id,
    this.image,
    this.name,
    this.type,
    this.level,
  });

  factory OfficeTeamWork.fromJson(Map<String, dynamic> json) => OfficeTeamWork(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        type: json["type"],
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "type": type,
        "level": level?.toJson(),
      };
}

class CityAtLogin {
  int? id;
  String? title;
  int? countryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? salary;

  CityAtLogin({
    this.id,
    this.title,
    this.countryId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.salary,
  });

  factory CityAtLogin.fromJson(Map<String, dynamic> json) => CityAtLogin(
        id: json["id"],
        title: json["title"],
        countryId: json["country_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        salary: json["salary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "country_id": countryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "salary": salary,
      };
}

class Time {
  int? id;
  String? day;
  String? from;
  String? to;

  Time({
    this.id,
    this.day,
    this.from,
    this.to,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
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

// class CountryOfLogin {
//   int? id;
//   String? title;
//   String? currency;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic deletedAt;

//   CountryOfLogin({
//     this.id,
//     this.title,
//     this.currency,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });

//   factory CountryOfLogin.fromJson(Map<String, dynamic> json) => CountryOfLogin(
//         id: json["id"],
//         title: json["title"],
//         currency: json["currency"],
//         status: json["status"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         deletedAt: json["deleted_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "currency": currency,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "deleted_at": deletedAt,
//       };
// }

class LawyerRate {
  int? id;
  dynamic fromUser;
  dynamic toUser;
  String? fromUserType;
  String? toUserType;
  int? rate;
  String? reason;
  String? comment;

  LawyerRate({
    this.id,
    this.fromUser,
    this.toUser,
    this.fromUserType,
    this.toUserType,
    this.rate,
    this.reason,
    this.comment,
  });

  factory LawyerRate.fromJson(Map<String, dynamic> json) => LawyerRate(
        id: json["id"],
        fromUser: json["from_user"],
        toUser: json["to_user"],
        fromUserType: json["from_user_type"],
        toUserType: json["to_user_type"],
        rate: json["rate"],
        reason: json["reason"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_user": fromUser,
        "to_user": toUser,
        "from_user_type": fromUserType,
        "to_user_type": toUserType,
        "rate": rate,
        "reason": reason,
        "comment": comment,
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
