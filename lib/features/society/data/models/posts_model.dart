class PostsModel {
  List<PostsModelData>? data;
  String? msg;
  int? status;

  PostsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        data: json["data"] == null
            ? []
            : List<PostsModelData>.from(
                json["data"]!.map((x) => PostsModelData.fromJson(x))),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
        "status": status,
      };
}

class PostsModelData {
  int? id;
  Author? author;
  String? authorType;
  String? body;
  List<FileElement>? files;
  int? countLike;
  int? countDislike;
  int? commentCount;
  String? createdAt;
  bool? isLiked;
  bool? isDisliked;
  PostsModelData({
    this.id,
    this.author,
    this.authorType,
    this.body,
    this.files,
    this.countLike,
    this.countDislike,
    this.createdAt,
    this.commentCount,
    this.isLiked,
    this.isDisliked,
  });

  factory PostsModelData.fromJson(Map<String, dynamic> json) => PostsModelData(
        id: json["id"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        authorType: json["author_type"],
        body: json["body"],
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
        countLike: json["count_like"],
        countDislike: json["count_dislike"],
        createdAt: json["created_at"],
        commentCount: json["count_comments"],
        isLiked: json["is_liked"],
        isDisliked: json["is_disliked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author?.toJson(),
        "author_type": authorType,
        "body": body,
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
        "count_like": countLike,
        "count_dislike": countDislike,
        "created_at": createdAt,
        "is_liked": isLiked,
        "is_disliked": isDisliked,
        "count_comments": commentCount
      };
}

class Author {
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
  String? token;
  String? points;
  int? ratesCount;

  double? rates;

  Author({
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
    this.points,
    this.ratesCount,
    this.rates,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
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
        lawyerTimes: json["lawyer_times"] == null
            ? []
            : List<dynamic>.from(json["lawyer_times"]!.map((x) => x)),
        token: json["token"],
        points: json["points"],
        ratesCount: json["rates_count"],
        rates: json["rates"]?.toDouble(),
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
        "points": points,
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
        "speciality": speciality,
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
        "level": level,
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

class FileElement {
  int? id;
  String? file;
  String? type;

  FileElement({
    this.id,
    this.file,
    this.type,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        file: json["file"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "type": type,
      };
}
