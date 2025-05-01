
class SearchLawyerModel {
  SearchLawyerModelData? data;
  String? msg;
  int? status;

  SearchLawyerModel({
    this.data,
    this.msg,
    this.status,
  });

  factory SearchLawyerModel.fromJson(Map<String, dynamic> json) => SearchLawyerModel(
    data: json["data"] == null ? null : SearchLawyerModelData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class SearchLawyerModelData {
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

  SearchLawyerModelData({
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

  factory SearchLawyerModelData.fromJson(Map<String, dynamic> json) => SearchLawyerModelData(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    nationalId: json["national_id"],
    lawyerId: json["lawyer_id"],
    type: json["type"],
    level: json["level"] == null ? null : Level.fromJson(json["level"]),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    status: json["status"],
    lawyerSpecialities: json["lawyer_specialities"] == null ? [] : List<LawyerSpeciality>.from(json["lawyer_specialities"]!.map((x) => LawyerSpeciality.fromJson(x))),
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
    lawyerTimes: json["lawyer_times"] == null ? [] : List<dynamic>.from(json["lawyer_times"]!.map((x) => x)),
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
    "lawyer_specialities": lawyerSpecialities == null ? [] : List<dynamic>.from(lawyerSpecialities!.map((x) => x.toJson())),
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

class LawyerSpeciality {
  int? id;
  Speciality? speciality;

  LawyerSpeciality({
    this.id,
    this.speciality,
  });

  factory LawyerSpeciality.fromJson(Map<String, dynamic> json) => LawyerSpeciality(
    id: json["id"],
    speciality: json["speciality"] == null ? null : Speciality.fromJson(json["speciality"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "speciality": speciality?.toJson(),
  };
}

class Speciality {
  int? id;
  String? title;
  Level? level;
  String? status;

  Speciality({
    this.id,
    this.title,
    this.level,
    this.status,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
    id: json["id"],
    title: json["title"],
    level: json["level"] == null ? null : Level.fromJson(json["level"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "level": level?.toJson(),
    "status": status,
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
