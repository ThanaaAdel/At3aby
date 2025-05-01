
class GetContractsModel {
  List<ContractsDataModel>? data;
  String? msg;
  int? status;

  GetContractsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetContractsModel.fromJson(Map<String, dynamic> json) => GetContractsModel(
    data: json["data"] == null ? [] : List<ContractsDataModel>.from(json["data"]!.map((x) => ContractsDataModel.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class ContractsDataModel {
  int? id;
  String? title;
  List<PDFFileElement>? files;

  ContractsDataModel({
    this.id,
    this.title,
    this.files,
  });

  factory ContractsDataModel.fromJson(Map<String, dynamic> json) => ContractsDataModel(
    id: json["id"],
    title: json["title"],
    files: json["files"] == null ? [] : List<PDFFileElement>.from(json["files"]!.map((x) => PDFFileElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
  };
}

class PDFFileElement {
  int? id;
  String? filePath;
  String? fileName;
  String? fileExtension;
  int? contractCategoryId;
  double? progress;

  PDFFileElement({
    this.id,
    this.filePath,
    this.fileName,
    this.fileExtension,
    this.contractCategoryId,
    this.progress =0,
  });

  factory PDFFileElement.fromJson(Map<String, dynamic> json) => PDFFileElement(
    id: json["id"],
    filePath: json["file_path"],
    fileName: json["file_name"],
    fileExtension: json["file_extension"],
    contractCategoryId: json["contract_category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file_path": filePath,
    "file_name": fileName,
    "file_extension": fileExtension,
    "contract_category_id": contractCategoryId,
  };
}
