import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

bool isMobileDevice(BuildContext context) {
  final deviceScreenType = getDeviceType(MediaQuery.of(context).size);

  return !(deviceScreenType == DeviceScreenType.mobile);
}

void checkDeviceType(BuildContext context) {
  // Check if the device is a mobile
  bool isMobile = isMobileDevice(context);

  // Print the result
  if (isMobile) {
    print("This is a mobile device.");
  } else {
    print("This is a tablet.");
  }
}
