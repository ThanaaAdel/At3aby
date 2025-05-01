class SharedCase {
  final String id;
  final String name;
  final String lawyerName;
  final double price;

  SharedCase({
    required this.id,
    required this.name,
    required this.lawyerName,
    required this.price,
  });
}

// Model for Send Cases
class SendCase {
  final String id;
  final String name;
  final String lawyerName;

  SendCase({
    required this.id,
    required this.name,
    required this.lawyerName,
  });
}
