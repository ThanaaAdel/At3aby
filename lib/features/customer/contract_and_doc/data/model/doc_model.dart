class PdfFileModel {
  final int id; // Unique identifier for the PDF (nullable)
  final String? name; // Name of the PDF (nullable)
  final String? pdfLink; // URL link to the PDF file (nullable)
  final double? price; // Price of the PDF (nullable)
  double? progress; // Price of the PDF (nullable)

  PdfFileModel({
    required this.id,
    this.name,
    this.pdfLink,
    this.price,
    this.progress = 0,
  });

  // Method to convert a JSON object to a PdfFile instance
  factory PdfFileModel.fromJson(Map<String, dynamic> json) {
    return PdfFileModel(
      id: json['id'],
      name: json['name'],
      pdfLink: json['pdfLink'],
      price: json['price'],
    );
  }

  // Method to convert a PdfFile instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pdfLink': pdfLink,
      'price': price,
    };
  }
}
