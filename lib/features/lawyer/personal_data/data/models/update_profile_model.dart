//
// class UpdateProfileLawyerModel {
//   Data? data;
//   String? msg;
//   int? status;
//
//   UpdateProfileLawyerModel({
//     this.data,
//     this.msg,
//     this.status,
//   });
//
//   factory UpdateProfileLawyerModel.fromJson(Map<String, dynamic> json) => UpdateProfileLawyerModel(
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     msg: json["msg"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data?.toJson(),
//     "msg": msg,
//     "status": status,
//   };
// }
//
// class Data {
//   int? id;
//   String? image;
//   String? name;
//   String? email;
//   String? phone;
//   String? nationalId;
//   String? lawyerId;
//   String? type;
//   CityWithCountryIdModel? level;
//   CountryDetailsModel? country;
//   CityWithCountryIdModel? city;
//   String? status;
//   List<LawyerSpeciality>? lawyerSpecialities;
//   String? token;
//
//   Data({
//     this.id,
//     this.image,
//     this.name,
//     this.email,
//     this.phone,
//     this.nationalId,
//     this.lawyerId,
//     this.type,
//     this.level,
//     this.country,
//     this.city,
//     this.status,
//     this.lawyerSpecialities,
//     this.token,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//     image: json["image"],
//     name: json["name"],
//     email: json["email"],
//     phone: json["phone"],
//     nationalId: json["national_id"],
//     lawyerId: json["lawyer_id"],
//     type: json["type"],
//     level: json["level"] == null ? null : CityWithCountryIdModel.fromJson(json["level"]),
//     country: json["country"] == null ? null : CountryDetailsModel.fromJson(json["country"]),
//     city: json["city"] == null ? null : CityWithCountryIdModel.fromJson(json["city"]),
//     status: json["status"],
//     lawyerSpecialities: json["lawyer_specialities"] == null ? [] : List<LawyerSpeciality>.from(json["lawyer_specialities"]!.map((x) => LawyerSpeciality.fromJson(x))),
//     token: json["token"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "image": image,
//     "name": name,
//     "email": email,
//     "phone": phone,
//     "national_id": nationalId,
//     "lawyer_id": lawyerId,
//     "type": type,
//     "level": level?.toJson(),
//     "country": country?.toJson(),
//     "city": city?.toJson(),
//     "status": status,
//     "lawyer_specialities": lawyerSpecialities == null ? [] : List<dynamic>.from(lawyerSpecialities!.map((x) => x.toJson())),
//     "token": token,
//   };
// }
//
// class CityWithCountryIdModel {
//   int? id;
//   Title? title;
//   int? countryId;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic deletedAt;
//   String? salary;
//
//   CityWithCountryIdModel({
//     this.id,
//     this.title,
//     this.countryId,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.salary,
//   });
//
//   factory CityWithCountryIdModel.fromJson(Map<String, dynamic> json) => CityWithCountryIdModel(
//     id: json["id"],
//     title: json["title"] == null ? null : Title.fromJson(json["title"]),
//     countryId: json["country_id"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     salary: json["salary"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title?.toJson(),
//     "country_id": countryId,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "salary": salary,
//   };
// }
//
// class Title {
//   String? en;
//   String? ar;
//
//   Title({
//     this.en,
//     this.ar,
//   });
//
//   factory Title.fromJson(Map<String, dynamic> json) => Title(
//     en: json["en"],
//     ar: json["ar"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "en": en,
//     "ar": ar,
//   };
// }
//
// class CountryDetailsModel {
//   int? id;
//   Title? title;
//   String? currency;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic deletedAt;
//
//   CountryDetailsModel({
//     this.id,
//     this.title,
//     this.currency,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//
//   factory CountryDetailsModel.fromJson(Map<String, dynamic> json) => CountryDetailsModel(
//     id: json["id"],
//     title: json["title"] == null ? null : Title.fromJson(json["title"]),
//     currency: json["currency"],
//     status: json["status"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title?.toJson(),
//     "currency": currency,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//   };
// }
//
// class LawyerSpeciality {
//   int? id;
//   Speciality? speciality;
//
//   LawyerSpeciality({
//     this.id,
//     this.speciality,
//   });
//
//   factory LawyerSpeciality.fromJson(Map<String, dynamic> json) => LawyerSpeciality(
//     id: json["id"],
//     speciality: json["speciality"] == null ? null : Speciality.fromJson(json["speciality"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "speciality": speciality?.toJson(),
//   };
// }
//
// class Speciality {
//   int? id;
//   String? title;
//   Level? level;
//   String? status;
//
//   Speciality({
//     this.id,
//     this.title,
//     this.level,
//     this.status,
//   });
//
//   factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
//     id: json["id"],
//     title: json["title"],
//     level: json["level"] == null ? null : Level.fromJson(json["level"]),
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "level": level?.toJson(),
//     "status": status,
//   };
// }
//
// class Level {
//   int? id;
//   String? title;
//   int? salary;
//
//   Level({
//     this.id,
//     this.title,
//     this.salary,
//   });
//
//   factory Level.fromJson(Map<String, dynamic> json) => Level(
//     id: json["id"],
//     title: json["title"],
//     salary: json["salary"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "salary": salary,
//   };
// }
