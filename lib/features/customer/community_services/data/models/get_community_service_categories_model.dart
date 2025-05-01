
class GetCommunityServiceCategoriesModel {
  List<GetCommunityServiceCategoriesModelData>? data;
  String? msg;
  int? status;

  GetCommunityServiceCategoriesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetCommunityServiceCategoriesModel.fromJson(Map<String, dynamic> json) => GetCommunityServiceCategoriesModel(
    data: json["data"] == null ? [] : List<GetCommunityServiceCategoriesModelData>.from(json["data"]!.map((x) => GetCommunityServiceCategoriesModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class GetCommunityServiceCategoriesModelData {
  int? id;
  String? title;
  List<SubCategory>? subCategories;

  GetCommunityServiceCategoriesModelData({
    this.id,
    this.title,
    this.subCategories,
  });

  factory GetCommunityServiceCategoriesModelData.fromJson(Map<String, dynamic> json) => GetCommunityServiceCategoriesModelData(
    id: json["id"],
    title: json["title"],
    subCategories: json["sub_categories"] == null ? [] : List<SubCategory>.from(json["sub_categories"]!.map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sub_categories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
  };
}

class SubCategory {
  int? id;
  String? title;

  SubCategory({
    this.id,
    this.title,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
