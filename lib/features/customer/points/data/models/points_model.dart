
class PointsModel {
  PointsModelData? data;
  String? msg;
  int? status;

  PointsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory PointsModel.fromJson(Map<String, dynamic> json) => PointsModel(
    data: json["data"] == null ? null : PointsModelData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class PointsModelData {
  String? points;
  String? cash;
  List<Transaction>? transactions;

  PointsModelData({
    this.points,
    this.cash,
    this.transactions,
  });

  factory PointsModelData.fromJson(Map<String, dynamic> json) => PointsModelData(
    points: json["points"],
    cash: json["cash"],
    transactions: json["transactions"] == null ? [] : List<Transaction>.from(json["transactions"]!.map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "points": points,
    "cash": cash,
    "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
  };
}

class Transaction {
  int? points;
  String? comment;
  String? createdAt;

  Transaction({
    this.points,
    this.comment,
    this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    points: json["points"],
    comment: json["comment"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "points": points,
    "comment": comment,
    "created_at": createdAt,
  };
}
