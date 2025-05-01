//!

class OrdersModel {
  List<OrdersModelData>? data;
  String? msg;
  int? status;

  OrdersModel({
    this.data,
    this.msg,
    this.status,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        data: json["data"] == null
            ? []
            : List<OrdersModelData>.from(
                json["data"]!.map((x) => OrdersModelData.fromJson(x))),
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

class OrdersModelData {
  MarketProduct? marketProduct;
  int? qty;
  String? phone;
  String? address;
  double? totalPrice;
  String? status;
  String? createdAt;

  OrdersModelData({
    this.marketProduct,
    this.qty,
    this.phone,
    this.address,
    this.totalPrice,
    this.status,
    this.createdAt,
  });

  factory OrdersModelData.fromJson(Map<String, dynamic> json) =>
      OrdersModelData(
        marketProduct: json["market_product"] == null
            ? null
            : MarketProduct.fromJson(json["market_product"]),
        qty: json["qty"],
        phone: json["phone"],
        address: json["address"],
        totalPrice: json["total_price"]?.toDouble(),
        status: json["status"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "market_product": marketProduct?.toJson(),
        "qty": qty,
        "phone": phone,
        "address": address,
        "total_price": totalPrice,
        "status": status,
        "created_at": createdAt,
      };
}

class MarketProduct {
  int? id;
  String? title;
  String? image;
  String? description;
  String? location;
  int? stock;
  int? price;
  int? discount;
  int? priceAfterDiscount;
  MarketProductCategory? marketProductCategory;
  String? status;

  MarketProduct({
    this.id,
    this.title,
    this.image,
    this.description,
    this.location,
    this.stock,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.marketProductCategory,
    this.status,
  });

  factory MarketProduct.fromJson(Map<String, dynamic> json) => MarketProduct(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        location: json["location"],
        stock: json["stock"],
        price: json["price"],
        discount: json["discount"],
        priceAfterDiscount: json["price_after_discount"],
        marketProductCategory: json["market_product_category"] == null
            ? null
            : MarketProductCategory.fromJson(json["market_product_category"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "description": description,
        "location": location,
        "stock": stock,
        "price": price,
        "discount": discount,
        "price_after_discount": priceAfterDiscount,
        "market_product_category": marketProductCategory?.toJson(),
        "status": status,
      };
}

class MarketProductCategory {
  int? id;
  String? title;

  MarketProductCategory({
    this.id,
    this.title,
  });

  factory MarketProductCategory.fromJson(Map<String, dynamic> json) =>
      MarketProductCategory(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
