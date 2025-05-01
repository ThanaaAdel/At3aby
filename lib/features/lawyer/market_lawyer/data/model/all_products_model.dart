// To parse this JSON data, do
//
//     final mainHomeMarketModel = mainHomeMarketModelFromJson(jsonString);

import 'dart:convert';

MainHomeMarketModel mainHomeMarketModelFromJson(String str) =>
    MainHomeMarketModel.fromJson(json.decode(str));

String mainHomeMarketModelToJson(MainHomeMarketModel data) =>
    json.encode(data.toJson());

class MainHomeMarketModel {
  Data? data;
  String? msg;
  int? status;

  MainHomeMarketModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainHomeMarketModel.fromJson(Map<String, dynamic> json) =>
      MainHomeMarketModel(
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
  List<MarketOffer>? marketOffer;
  List<MarketProductCategory>? marketProductCategory;
  List<MarketProduct>? marketProduct;

  Data({
    this.marketOffer,
    this.marketProductCategory,
    this.marketProduct,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        marketOffer: json["market_offer"] == null
            ? []
            : List<MarketOffer>.from(
                json["market_offer"]!.map((x) => MarketOffer.fromJson(x))),
        marketProductCategory: json["market_product_category"] == null
            ? []
            : List<MarketProductCategory>.from(json["market_product_category"]!
                .map((x) => MarketProductCategory.fromJson(x))),
        marketProduct: json["market_product"] == null
            ? []
            : List<MarketProduct>.from(
                json["market_product"]!.map((x) => MarketProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "market_offer": marketOffer == null
            ? []
            : List<dynamic>.from(marketOffer!.map((x) => x.toJson())),
        "market_product_category": marketProductCategory == null
            ? []
            : List<dynamic>.from(marketProductCategory!.map((x) => x.toJson())),
        "market_product": marketProduct == null
            ? []
            : List<dynamic>.from(marketProduct!.map((x) => x.toJson())),
      };
}

class MarketOffer {
  int? id;
  String? image;
  MarketProduct? marketProduct;

  MarketOffer({
    this.id,
    this.image,
    this.marketProduct,
  });

  factory MarketOffer.fromJson(Map<String, dynamic> json) => MarketOffer(
        id: json["id"],
        image: json["image"],
        marketProduct: json["market_product"] == null
            ? null
            : MarketProduct.fromJson(json["market_product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "market_product": marketProduct?.toJson(),
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
