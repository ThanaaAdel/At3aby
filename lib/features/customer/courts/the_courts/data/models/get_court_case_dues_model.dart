
class GetCourtCaseDuesModel {
  List<GetCourtCaseDuesModelData>? data;
  String? msg;
  int? status;

  GetCourtCaseDuesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetCourtCaseDuesModel.fromJson(Map<String, dynamic> json) => GetCourtCaseDuesModel(
    data: json["data"] == null ? [] : List<GetCourtCaseDuesModelData>.from(json["data"]!.map((x) => GetCourtCaseDuesModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class GetCourtCaseDuesModelData {
  int? id;
  String? title;
  DateTime? date;
  int? price;
  int? paid;
  String? paidName;

  GetCourtCaseDuesModelData({
    this.id,
    this.title,
    this.date,
    this.price,
    this.paid,
    this.paidName,
  });

  factory GetCourtCaseDuesModelData.fromJson(Map<String, dynamic> json) => GetCourtCaseDuesModelData(
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
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "price": price,
    "paid": paid,
    "paid_name": paidName,
  };
}
