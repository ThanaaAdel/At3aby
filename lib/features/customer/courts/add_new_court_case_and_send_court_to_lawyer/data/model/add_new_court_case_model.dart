import 'package:ataaby/features/lawyer/home_lawyer/data/model/specialist_model.dart';
import '../../../../../lawyer/add_new_update/data/model/add_update_model.dart';

class AddNewCourtCaseModel {
  CourtData? data;
  String? msg;
  int? status;

  AddNewCourtCaseModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AddNewCourtCaseModel.fromJson(Map<String, dynamic> json) =>
      AddNewCourtCaseModel(
        data: json["data"] == null ? null : CourtData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class CourtData {
  int? id;
  int? lawyerId;
  String? title;
  int? caseNumber;
  int? seen;
  String? type;
  String? lawyerRate;
  String? clientRate;
  String? status;
  String? eventStatus;
  dynamic caseEstimatedPrice;
  String? details;
  dynamic caseFinalPrice;
  String? createdAt;
  Speciality? speciality;
  List<FileElement>? files;
  Map<String, List<CourtCaseUpdate>>? updates = {};
  Client? client;
  Event? lawyerEvent;
  List<AllEvent>? allEvents;

  CourtData({
    this.id,
    this.lawyerId,
    this.title,
    this.caseNumber,
    this.type,
    this.lawyerRate,
    this.seen,
    this.clientRate,
    this.status,
    this.eventStatus,
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

  factory CourtData.fromJson(Map<String, dynamic> json) => CourtData(
        id: json["id"],
        lawyerId: json["lawyer_id"],
        title: json["title"],
        caseNumber: json["case_number"],
        type: json["type"],
        seen: json["seen"],
        lawyerRate: json["lawyer_rate"],
        clientRate: json["client_rate"],
        status: json["status"],
        eventStatus: json["event_status"],
        caseEstimatedPrice: json["case_estimated_price"],
        details: json["details"],
        caseFinalPrice: json["case_final_price"],
        createdAt: json["created_at"],
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
            : List<AllEvent>.from(
                json["all_events"]!.map((x) => AllEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lawyer_id": lawyerId,
        "title": title,
        "case_number": caseNumber,
        "type": type,
        "seen": seen,
        "lawyer_rate": lawyerRate,
        "client_rate": clientRate,
        "status": status,
        "event_status": eventStatus,
        "case_estimated_price": caseEstimatedPrice,
        "details": details,
        "case_final_price": caseFinalPrice,
        "created_at": createdAt,
        "speciality": speciality?.toJson(),
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
        "updates": Map.from(updates!).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "client": client?.toJson(),
        "lawyer_event": lawyerEvent?.toJson(),
        "all_events": allEvents == null
            ? []
            : List<dynamic>.from(allEvents!.map((x) => x)),
      };
}

class AllEvent {
  int? id;
  String? lawyerName;
  String? lawyerLevel;
  String? lawyerImage;
  dynamic rateCount;
  dynamic avgRate;
  String? status;
  int? price;
  dynamic refuseReason;
  dynamic refuseNote;
  List<dynamic>? dues;
  DateTime? createdAt;

  AllEvent({
    this.id,
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

  factory AllEvent.fromJson(Map<String, dynamic> json) => AllEvent(
        id: json["id"],
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
            : List<dynamic>.from(json["dues"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lawyer_name": lawyerName,
        "lawyer_level": lawyerLevel,
        "lawyer_image": lawyerImage,
        "rate_count": rateCount,
        "avg_rate": avgRate,
        "status": status,
        "price": price,
        "refuse_reason": refuseReason,
        "refuse_note": refuseNote,
        "dues": dues == null ? [] : List<dynamic>.from(dues!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
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
      name: json["name"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "file": file,
        "name": name,
      };
}

class CourtCaseUpdate {
  int? id;
  String? title;
  String? details;
  String? date;
  List<FileElement>? files;

  CourtCaseUpdate({
    this.id,
    this.title,
    this.details,
    this.date,
    this.files,
  });

  factory CourtCaseUpdate.fromJson(Map<String, dynamic> json) =>
      CourtCaseUpdate(
        id: json["id"],
        title: json["title"],
        details: json["details"],
        date: json["date"],
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "details": details,
        "date": date,
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
      };
}
