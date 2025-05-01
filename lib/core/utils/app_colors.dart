import 'package:ataaby/core/exports.dart';
import 'hex_color.dart';

class AppColors {
  static Color primary = HexColor('#009FE3'); // light blue
  static Color secondPrimary = HexColor('#2A3A65'); // dark blue
  static Color redLight = HexColor('#DD476F'); // light red
  static Color greenLight = HexColor('#3AC188'); // light green
  static Color orangeLight = HexColor('#EDC366'); // light green
  static Color yellow = HexColor('#EDC366'); // light yellow
  static Color black = Colors.black; // black
  static Color blackLight = HexColor('#2A3A65'); // black
  static Color grey = HexColor('#8EA3AC'); // black
  static Color grayLite = HexColor('#EDF3F5');
  static Color gray2Lite = HexColor('#D5DADC');
  static Color graySemiLite = HexColor('#D2DDE2');
  static Color grayLiteColor = HexColor('#C9CFDE');
  static Color blackLiteColor = HexColor('#2F3036');
  static Color grayLite3Color = HexColor('#D4DDE1');
  static Color grayLite2Color = HexColor('#F4F7F8');
  static Color textGreyColor = const Color(0xff8EA3AC);
  static Color darkGray = HexColor('#8EA3AC');
  static Color white = Colors.white;
  static Color red = Colors.red;
  static Color green = Colors.green;
  static Color transparent = Colors.transparent;

  static Color gray = Colors.grey;

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lightens(String color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(HexColor(color));
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
