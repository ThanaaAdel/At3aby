import 'package:easy_localization/easy_localization.dart';

String? passwordValidator(
  String? value, {
  int minLength = 8,
  bool requireUppercase = true,
  bool requireLowercase = true,
  bool requireNumber = true,
  bool requireSpecialChar = true,
}) {
  if (value == null || value.isEmpty) {
    return "password_required".tr();
  }

  if (value.length < minLength) {
    return "password_min_length".tr().replaceFirst('{}', minLength.toString());
  }

  if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
    return "password_uppercase".tr();
  }

  if (requireLowercase && !RegExp(r'[a-z]').hasMatch(value)) {
    return "password_lowercase".tr();
  }

  if (requireNumber && !RegExp(r'[0-9]').hasMatch(value)) {
    return "password_number".tr();
  }

  if (requireSpecialChar &&
      !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return "password_special".tr();
  }

  return null;
}
