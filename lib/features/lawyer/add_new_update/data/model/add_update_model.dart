import '../../../home_lawyer/data/model/specialist_model.dart';

class LawyerAddNewUpdateModel {
  LawyerAddNewUpdateModelData? data;
  String? msg;
  int? status;

  LawyerAddNewUpdateModel({
    this.data,
    this.msg,
    this.status,
  });

  factory LawyerAddNewUpdateModel.fromJson(Map<String, dynamic> json) =>
      LawyerAddNewUpdateModel(
        data: json["data"] == null
            ? null
            : LawyerAddNewUpdateModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class LawyerAddNewUpdateModelData {
  int? id;
  String? title;
  int? caseNumber;
  int? seen;
  String? type;
  String? lawyerRate;
  String? clientRate;
  String? status;
  int? caseEstimatedPrice;
  String? details;
  int? caseFinalPrice;
  DateTime? createdAt;
  Speciality? speciality;
  List<FileElement>? files;
  Updates? updates;
  Client? client;
  Event? lawyerEvent;
  List<Event>? allEvents;

  LawyerAddNewUpdateModelData({
    this.id,
    this.title,
    this.caseNumber,
    this.seen,
    this.type,
    this.lawyerRate,
    this.clientRate,
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

  factory LawyerAddNewUpdateModelData.fromJson(Map<String, dynamic> json) =>
      LawyerAddNewUpdateModelData(
        id: json["id"],
        title: json["title"],
        caseNumber: json["case_number"],
        seen: json["seen"],
        type: json["type"],
        lawyerRate: json["lawyer_rate"],
        clientRate: json["client_rate"],
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
        updates:
            json["updates"] == null ? null : Updates.fromJson(json["updates"]),
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
        "seen": seen,
        "type": type,
        "lawyer_rate": lawyerRate,
        "client_rate": clientRate,
        "status": status,
        "case_estimated_price": caseEstimatedPrice,
        "details": details,
        "case_final_price": caseFinalPrice,
        "created_at": createdAt?.toIso8601String(),
        "speciality": speciality?.toJson(),
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
        "updates": updates,
        "client": client?.toJson(),
        "lawyer_event": lawyerEvent?.toJson(),
        "all_events": allEvents == null
            ? []
            : List<dynamic>.from(allEvents!.map((x) => x.toJson())),
      };
}

class Event {
  int? id;
  int? lawyerId;
  String? lawyerName;
  String? lawyerLevel;
  String? lawyerImage;
  dynamic rateCount;
  dynamic avgRate;
  String? status;
  int? price;
  dynamic refuseReason;
  dynamic refuseNote;
  List<Due>? dues;
  DateTime? createdAt;

  Event({
    this.id,
    this.lawyerId,
    this.lawyerName,
    this.lawyerLevel,
    this.lawyerImage,
    this.rateCount,
    this.avgRate,
    this.status,
    this.price,
    this.refuseReason,
    this.refuseNote,
    this.dues,
    this.createdAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        lawyerId: json["lawyer_id"],
        lawyerName: json["lawyer_name"],
        lawyerLevel: json["lawyer_level"],
        lawyerImage: json["lawyer_image"],
        rateCount: json["rate_count"],
        avgRate: json["avg_rate"],
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
        "lawyer_id": lawyerId,
        "lawyer_name": lawyerName,
        "lawyer_level": lawyerLevel,
        "lawyer_image": lawyerImage,
        "rate_count": rateCount,
        "avg_rate": avgRate,
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
  int? paid;
  String? paidName;

  Due({
    this.id,
    this.title,
    this.date,
    this.price,
    this.paid,
    this.paidName,
  });

  factory Due.fromJson(Map<String, dynamic> json) => Due(
        id: json["id"],
        title: json["title"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        price: json["price"],
        paid: json["paid"],
        paidName: json["paid_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "price": price,
        "paid": paid,
        "paid_name": paidName,
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
    this.ratesCount,
    this.rates,
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

class FileElement {
  int? id;
  String? type;
  String? file;
  String? name;

  FileElement({
    this.id,
    this.type,
    this.file,
    this.name,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        type: json["type"],
        file: json["file"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "file": file,
        "name": name,
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
