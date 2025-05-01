import 'dart:convert';
import 'package:ataaby/features/login/data/models/login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/login/data/models/login_model_lawyer.dart';
import '../exports.dart';

late SharedPreferences prefs;
late FlutterSecureStorage secureStorage;

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// Save user securely
  Future<void> setUser(LoginModel loginModel) async {
    String userJson = jsonEncode(LoginModel.fromJson(loginModel.toJson()));
    await secureStorage.write(key: 'user', value: userJson);
  }

  /// Retrieve user securely
  Future<LoginModel> getUserModel() async {
    String? jsonData = await secureStorage.read(key: 'user');
    if (jsonData != null) {
      return LoginModel.fromJson(jsonDecode(jsonData));
    } else {
      return LoginModel();
    }
  }

  //! Save lawyer securely
  Future<void> setLawyer(LoginModelLawyer loginModelLawyer) async {
    String laywerJson =
        jsonEncode(LoginModelLawyer.fromJson(loginModelLawyer.toJson()));
    await secureStorage.write(key: 'lawyer', value: laywerJson);
    await getLawyerModel();
  }

  //! Retrieve lawyer securely
  Future<LoginModelLawyer> getLawyerModel() async {
    String? jsonData = await secureStorage.read(key: 'lawyer');
    if (jsonData != null) {
      return LoginModelLawyer.fromJson(jsonDecode(jsonData));
    } else {
      return LoginModelLawyer();
    }
  }

  Future<bool> clearUserAndlawyer() async {
    await secureStorage.delete(key: 'lawyer');
    await secureStorage.delete(key: 'user');
    return true;
  }

  /// Save app language using SharedPreferences
  Future<void> savedLang(String local) async {
    await prefs.setString(AppStrings.locale, local);
  }

  /// Get app language using SharedPreferences
  Future<String> getSavedLang() async {
    return prefs.getString(AppStrings.locale) ?? 'ar'; // Default to 'ar'
  }

  /// Save app language using SharedPreferences

  /// Clear all data from secure storage and shared preferences
  Future<void> clearAll() async {
    await secureStorage.deleteAll(); // Clear secure storage
    await prefs.clear(); // Clear shared preferences
  }

  Future<void> setDeviceToken(String token) async {
    print('=====>> $token');
    await prefs.setString('device_token', token);
  }

  /// Get app language using SharedPreferences
  Future<String> getDeviceToken() async {
    return prefs.getString('device_token') ?? 'device_token';
  }
}

// late SharedPreferences prefs;

// class Preferences {
// static final Preferences instance = Preferences._internal();

// Preferences._internal();

// factory Preferences() => instance;

//   // Future<void> setFirstInstall() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.setString('onBoarding', 'Done');
//   // }

//   // Future<String?> getFirstInstall() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String? jsonData = prefs.getString('onBoarding');
//   //   return jsonData;
//   // }

//   Future<void> setUser(LoginModel loginModel) async {
//     prefs.setString(
//         'user', jsonEncode(LoginModel.fromJson(loginModel.toJson())));
//     print(await getUserModel());
//   }

//   Future<void> clearShared() async {
//     prefs.clear();
//   }

//   Future<LoginModel> getUserModel() async {
//     String? jsonData = prefs.getString('user');
//     LoginModel userModel;
//     if (jsonData != null) {
//       userModel = LoginModel.fromJson(jsonDecode(jsonData));
//     } else {
//       userModel = LoginModel();
//     }
//     return userModel;
//   }

//   Future<String> getSavedLang() async {
//     return prefs.getString(AppStrings.locale) ?? 'ar';
//   }

//   Future<void> savedLang(String local) async {
//     prefs.setString(AppStrings.locale, local);
//   }
// }
