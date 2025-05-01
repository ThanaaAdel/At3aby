//
// import 'package:ataaby/features/login/data/models/login_model_lawyer.dart';
//
// class CourtCaseSosModel {
//   List<CourtCaseSosModel>? data;
//   String? msg;
//   dynamic? status;
//
//   CourtCaseSosModel({
//     this.data,
//     this.msg,
//     this.status,
//   });
//
//   factory CourtCaseSosModel.fromJson(Map<String, dynamic> json) => CourtCaseSosModel(
//     data: json["data"] == null ? [] : List<CourtCaseSosModel>.from(json["data"]!.map((x) => CourtCaseSosModel.fromJson(x))),
//     msg: json["msg"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     "msg": msg,
//     "status": status,
//   };
// }
//
// class CourtCaseSosDataModel {
//   int? id;
//   String? problem;
//   String? phone;
//   String? address;
//   String? lat;
//   String? long;
//   String? status;
//   LoginModelLawyer? lawyer;
//   DateTime? createdAt;
//
//   CourtCaseSosDataModel({
//     this.id,
//     this.problem,
//     this.phone,
//     this.address,
//     this.lat,
//     this.long,
//     this.status,
//     this.lawyer,
//     this.createdAt,
//   });
//
//   factory CourtCaseSosDataModel.fromJson(Map<String, dynamic> json) => CourtCaseSosDataModel(
//     id: json["id"],
//     problem: json["problem"],
//     phone: json["phone"],
//     address: json["address"],
//     lat: json["lat"],
//     long: json["long"],
//     status:json["status"],
//     lawyer: json["lawyer"] == null ? null : LoginModelLawyer.fromJson(json["lawyer"]),
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "problem": problem,
//     "phone": phone,
//     "address": address,
//     "lat": lat,
//     "long": long,
//     "status": status,
//     "lawyer": lawyer?.toJson(),
//     "created_at": createdAt?.toIso8601String(),
//   };
// }
