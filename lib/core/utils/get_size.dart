import 'package:ataaby/core/exports.dart';

double getWidthSize(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double getHeightSize(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

double textScaleFactor(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth > 600) {
    // Tablet scaling
    return 1.5; // Increase font size for tablets
  }
  return 1.0; // Default scaling for mobile
}
