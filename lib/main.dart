import 'package:ataaby/core/notification_services/notification_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ataaby/injector.dart' as injector;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/restart_app_class.dart';
import 'firebase_options.dart';

//! 0==> User
//! 1==> Lawyer
/*
platform :ios, '12.0'
*/

//! Details of shared and action

FirebaseMessaging messaging = FirebaseMessaging.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService notificationService = NotificationService();
  await EasyLocalization.ensureInitialized();
  await notificationService.initialize();

  await ScreenUtil.ensureScreenSize();

  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  IOSOptions getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  prefs = await SharedPreferences.getInstance();

  secureStorage = FlutterSecureStorage(
      aOptions: getAndroidOptions(), iOptions: getIOSOptions());
  await injector.setup();
  Bloc.observer = AppBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // Optional: Allow upside-down portrait
  ]).then((_) {
    runApp(EasyLocalization(
        supportedLocales: const [Locale('ar', ''), Locale('en', '')],
        path: 'assets/lang',
        saveLocale: true,
        startLocale: const Locale('ar', ''),
        fallbackLocale: const Locale('ar', ''),
        child: const MyAppWithScreenUtil()));
  });
}

class MyAppWithScreenUtil extends StatelessWidget {
  const MyAppWithScreenUtil({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // Use MediaQuery to get the current screen size
        final mediaQuery = MediaQuery.of(context);
        final screenWidth = mediaQuery.size.width;
        final screenHeight = mediaQuery.size.height;
        return ScreenUtilInit(
          designSize: Size(screenWidth, screenHeight),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return const HotRestartController(child: MyApp());
          },
        );
      },
    );
  }
}
