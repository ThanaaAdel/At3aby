
class SendSosRequestModel {
    Data? data;
    String? msg;
    int? status;

    SendSosRequestModel({
        this.data,
        this.msg,
        this.status,
    });

    factory SendSosRequestModel.fromJson(Map<String, dynamic> json) => SendSosRequestModel(
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
    String? problem;
    String? phone;
    String? address;
    String? lat;
    String? long;
    String? status;
    Lawyer? lawyer;
    DateTime? createdAt;

    Data({
        this.id,
        this.problem,
        this.phone,
        this.address,
        this.lat,
        this.long,
        this.status,
        this.lawyer,
        this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        problem: json["problem"],
        phone: json["phone"],
        address: json["address"],
        lat: json["lat"],
        long: json["long"],
        status: json["status"],
        lawyer: json["lawyer"] == null ? null : Lawyer.fromJson(json["lawyer"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "problem": problem,
        "phone": phone,
        "address": address,
        "lat": lat,
        "long": long,
        "status": status,
        "lawyer": lawyer?.toJson(),
        "created_at": createdAt?.toIso8601String(),
    };
}

class Lawyer {
    int? id;
    String? image;
    String? name;
    String? email;
    String? phone;
    String? nationalId;
    String? lawyerId;
    Type? type;
    Level? level;
    Country? country;
    City? city;
    String? status;
    List<dynamic>? lawyerSpecialities;
    int? rateCount;
    double? avgRate;
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
    List<OfficeTeamWork>? officeTeamWork;
    String? token;

    Lawyer({
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
        this.officeTeamWork,
        this.token,
    });

    factory Lawyer.fromJson(Map<String, dynamic> json) => Lawyer(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        nationalId: json["national_id"],
        lawyerId: json["lawyer_id"],
        type: typeValues.map[json["type"]]!,
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        status: json["status"],
        lawyerSpecialities: json["lawyer_specialities"] == null ? [] : List<dynamic>.from(json["lawyer_specialities"]!.map((x) => x)),
        rateCount: json["rate_count"],
        avgRate: json["avg_rate"]?.toDouble(),
        officeAddress: json["office_address"],
        lat: json["lat"],
        lng: json["lng"],
        successCase: json["success_case"],
        failedCase: json["failed_case"],
        publicWork: json["public_work"],
        about: json["about"],
        consultationFee: json["consultation_fee"],
        attorneyFee: json["attorney_fee"],
        lawyerTimes: json["lawyer_times"] == null ? [] : List<dynamic>.from(json["lawyer_times"]!.map((x) => x)),
        officeTeamWork: json["office_team_work"] == null ? [] : List<OfficeTeamWork>.from(json["office_team_work"]!.map((x) => OfficeTeamWork.fromJson(x))),
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
        "type": typeValues.reverse[type],
        "level": level?.toJson(),
        "country": country?.toJson(),
        "city": city?.toJson(),
        "status": status,
        "lawyer_specialities": lawyerSpecialities == null ? [] : List<dynamic>.from(lawyerSpecialities!.map((x) => x)),
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
        "lawyer_times": lawyerTimes == null ? [] : List<dynamic>.from(lawyerTimes!.map((x) => x)),
        "office_team_work": officeTeamWork == null ? [] : List<dynamic>.from(officeTeamWork!.map((x) => x.toJson())),
        "token": token,
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
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
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

class Level {
    int? id;
    String? title;
    int? salary;

    Level({
        this.id,
        this.title,
        this.salary,
    });

    factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        title: json["title"],
        salary: json["salary"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "salary": salary,
    };
}

class OfficeTeamWork {
    int? id;
    String? image;
    String? name;
    Type? type;
    Level? level;
    dynamic officeId;

    OfficeTeamWork({
        this.id,
        this.image,
        this.name,
        this.type,
        this.level,
        this.officeId,
    });

    factory OfficeTeamWork.fromJson(Map<String, dynamic> json) => OfficeTeamWork(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        type: typeValues.map[json["type"]]!,
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
        officeId: json["office_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "type": typeValues.reverse[type],
        "level": level?.toJson(),
        "office_id": officeId,
    };
}

enum Type {
    INDIVIDUAL,
    OFFICE
}

final typeValues = EnumValues({
    "individual": Type.INDIVIDUAL,
    "office": Type.OFFICE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
