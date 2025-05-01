import 'package:ataaby/features/lawyer/market_lawyer/data/model/all_products_model.dart';
import 'package:ataaby/features/login/data/models/login_model_lawyer.dart';

import '../../../../customer/courts/add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';
import '../../../../new_register/data/model/city_model.dart';
import '../../../../new_register/data/model/country_model.dart';
import 'specialist_model.dart';

class HomeLawyerModel {
  HomeLawyerModelData? data;
  String? msg;
  int? status;

  HomeLawyerModel({
    this.data,
    this.msg,
    this.status,
  });

  factory HomeLawyerModel.fromJson(Map<String, dynamic> json) =>
      HomeLawyerModel(
        data: json["data"] == null || json["status"] != 200
            ? null
            : HomeLawyerModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class HomeLawyerModelData {
  List<MarketOffer>? marketOffers;
  List<NewCourtCase>? newCourtCases;
  LawyerData? lawyerData;
  List<OfficeRequest>? officeRequests;

  HomeLawyerModelData({
    this.marketOffers,
    this.newCourtCases,
    this.lawyerData,
    this.officeRequests,
  });

  factory HomeLawyerModelData.fromJson(Map<String, dynamic> json) =>
      HomeLawyerModelData(
        marketOffers: json["marketOffers"] == null
            ? []
            : List<MarketOffer>.from(
                json["marketOffers"]!.map((x) => MarketOffer.fromJson(x))),
        newCourtCases: json["newCourtCases"] == null
            ? []
            : List<NewCourtCase>.from(
                json["newCourtCases"]!.map((x) => NewCourtCase.fromJson(x))),
        officeRequests: json["officeRequests"] == null ? [] : List<OfficeRequest>.from(json["officeRequests"]!.map((x) => OfficeRequest.fromJson(x))),
        lawyerData: json["lawyerData"] == null
            ? null
            : LawyerData.fromJson(json["lawyerData"]),
      );

  Map<String, dynamic> toJson() => {
        "marketOffers": marketOffers == null
            ? []
            : List<dynamic>.from(marketOffers!.map((x) => x)),
        "newCourtCases": newCourtCases == null
            ? []
            : List<dynamic>.from(newCourtCases!.map((x) => x.toJson())),
    "officeRequests": officeRequests == null ? [] : List<dynamic>.from(officeRequests!.map((x) => x.toJson())),

    "lawyerData": lawyerData?.toJson(),
      };
}

class LawyerData {
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
  City? city;
  String? status;
  List<LawyerSpeciality>? lawyerSpecialities;
  int? rateCount;
  dynamic avgRate;
  String? officeAddress;
  String? lat;
  String? lng;
  int? successCase;
  int? failedCase;
  String? publicWork;
  String? about;
  int? consultationFee;
  int? attorneyFee;
  List<dynamic>? lawyerTimes;
  String? token;

  LawyerData({
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
    this.token,
  });

  factory LawyerData.fromJson(Map<String, dynamic> json) => LawyerData(
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
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        status: json["status"],
        lawyerSpecialities: json["lawyer_specialities"] == null
            ? []
            : List<LawyerSpeciality>.from(json["lawyer_specialities"]!
                .map((x) => LawyerSpeciality.fromJson(x))),
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
            : List<dynamic>.from(json["lawyer_times"]!.map((x) => x)),
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
            : List<dynamic>.from(lawyerTimes!.map((x) => x)),
        "token": token,
      };
}



class NewCourtCase {
  int? id;
  String? title;
  int? caseNumber;
  String? status;
  int? caseEstimatedPrice;
  String? details;
  int? caseFinalPrice;
  DateTime? createdAt;
  Speciality? speciality;
  List<FileElement>? files;
  Map<String, List<CourtCaseUpdate>>? updates = {};
  Client? client;
  Event? lawyerEvent;
  List<Event>? allEvents;

  NewCourtCase({
    this.id,
    this.title,
    this.caseNumber,
    this.status,
    this.caseEstimatedPrice,
    this.details,
    this.caseFinalPrice,
    this.createdAt,
    this.speciality,
    this.files,
    this.updates,
    this.client,
    this.lawyerEvent,
    this.allEvents,
  });

  factory NewCourtCase.fromJson(Map<String, dynamic> json) => NewCourtCase(
        id: json["id"],
        title: json["title"],
        caseNumber: json["case_number"],
        status: json["status"],
        caseEstimatedPrice: json["case_estimated_price"],
        details: json["details"],
        caseFinalPrice: json["case_final_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        speciality: json["speciality"] == null
            ? null
            : Speciality.fromJson(json["speciality"]),
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
        updates: json["updates"] is Map
            ? Map.from(json["updates"])
                .map((k, v) => MapEntry<String, List<CourtCaseUpdate>>(
                      k,
                      List<CourtCaseUpdate>.from(
                          v.map((x) => CourtCaseUpdate.fromJson(x))),
                    ))
            : {},
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        lawyerEvent: json["lawyer_event"] == null
            ? null
            : Event.fromJson(json["lawyer_event"]),
        allEvents: json["all_events"] == null
            ? []
            : List<Event>.from(
                json["all_events"]!.map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "case_number": caseNumber,
        "status": status,
        "case_estimated_price": caseEstimatedPrice,
        "details": details,
        "case_final_price": caseFinalPrice,
        "created_at": createdAt?.toIso8601String(),
        "speciality": speciality?.toJson(),
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
        "updates": Map.from(updates!).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "client": client?.toJson(),
        "lawyer_event": lawyerEvent?.toJson(),
        "all_events": allEvents == null
            ? []
            : List<dynamic>.from(allEvents!.map((x) => x.toJson())),
      };
}

class Client {
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

  Client({
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
    this.rates,
    this.ratesCount,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
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
        rates: json["rates"],
        ratesCount: json["rates_count"],
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

class Updates {
  List<Update> updates;

  Updates({required this.updates});

  factory Updates.fromJson(dynamic json) {
    if (json is List) {
      return Updates(
        updates: json.map((x) => Update.fromJson(x)).toList(),
      );
    } else {
      return Updates(updates: []); // ✅ في حالة كان الـ JSON غير متوقع
    }
  }

  List<Map<String, dynamic>> toJson() {
    return updates.map((x) => x.toJson()).toList();
  }
}

class Update {
  int? id;
  String? title;
  String? details;
  DateTime? date;
  List<FileElement>? files;

  Update({
    this.id,
    this.title,
    this.details,
    this.date,
    this.files,
  });

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        id: json["id"],
        title: json["title"],
        details: json["details"],
        date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "details": details,
        "date": date != null
            ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
            : null,
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
      };
}

class Event {
  int? id;
  String? status;
  int? price;
  String? refuseReason;
  String? refuseNote;
  List<Due>? dues;
  DateTime? createdAt;

  Event({
    this.id,
    this.status,
    this.price,
    this.refuseReason,
    this.refuseNote,
    this.dues,
    this.createdAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        status: json["status"],
        price: json["price"],
        refuseReason: json["refuse_reason"],
        refuseNote: json["refuse_note"],
        dues: json["dues"] == null
            ? []
            : List<Due>.from(json["dues"]!.map((x) => Due.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "price": price,
        "refuse_reason": refuseReason,
        "refuse_note": refuseNote,
        "dues": dues == null
            ? []
            : List<dynamic>.from(dues!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
      };
}

class Due {
  int? id;
  String? title;
  DateTime? date;
  int? price;

  Due({
    this.id,
    this.title,
    this.date,
    this.price,
  });

  factory Due.fromJson(Map<String, dynamic> json) => Due(
        id: json["id"],
        title: json["title"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "price": price,
      };
}
class OfficeRequest {
  int? requestId;
  Office? office;

  OfficeRequest({
    this.requestId,
    this.office,
  });

  factory OfficeRequest.fromJson(Map<String, dynamic> json) => OfficeRequest(
    requestId: json["request_id"],
    office: json["office"] == null ? null : Office.fromJson(json["office"]),
  );

  Map<String, dynamic> toJson() => {
    "request_id": requestId,
    "office": office?.toJson(),
  };
}

class Office {
  int? id;
  String? image;
  String? name;
  String? type;
  Level? level;
  dynamic officeId;

  Office({
    this.id,
    this.image,
    this.name,
    this.type,
    this.level,
    this.officeId,
  });

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    type: json["type"],
    level: json["level"] == null ? null : Level.fromJson(json["level"]),
    officeId: json["office_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "type": type,
    "level": level?.toJson(),
    "office_id": officeId,
  };
}