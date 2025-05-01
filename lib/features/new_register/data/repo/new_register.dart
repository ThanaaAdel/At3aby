import 'dart:developer';
import 'package:ataaby/features/lawyer/home_lawyer/data/model/specialist_model.dart';
import 'package:ataaby/features/login/data/models/login_model.dart';
import 'package:ataaby/features/login/data/models/login_model_lawyer.dart';
import '../../../../core/exports.dart';
import '../model/city_model.dart';
import '../model/country_model.dart';
import '../model/default_model.dart';
import '../model/levels_model.dart';
import '../model/otp_model.dart';
import '../model/specialities_model.dart';
import '../model/verify_model.dart';

class NewRegisterRepo {
  BaseApiConsumer dio;
  NewRegisterRepo(this.dio);

// getCountries

  Future<Either<Failure, MainCountryModel>> getCountries() async {
    try {
      final response = await dio.get(EndPoints.getCountriesUrl);

      return Right(MainCountryModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainCityModel>> getCities(String countryId) async {
    try {
      final response = await dio.get(EndPoints.getCitiesUrl + countryId);

      return Right(MainCityModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainLevelsModel>> getLevels() async {
    try {
      final response = await dio.get(EndPoints.getLevelsUrl);

      return Right(MainLevelsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainSpecialitiesModel>> getSpecialities(
      String id) async {
    try {
      final response = await dio.get(EndPoints.specialitiesByIdUrl + id);

      return Right(MainSpecialitiesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> registerAsClient({
    required String name,
    required String email,
    required String password,
    String? nationalId,
    String? phone,
    String? cityId,
    String? countryId,
  }) async {
    final macAddress = await getMacAddress() ?? '';
    final deviceToken = await Preferences.instance.getDeviceToken();
    log('====>> $macAddress');
    log('====>> device Token :$deviceToken');
    try {
      final response = await dio
          .post(EndPoints.clientRegistersUrl, formDataIsEnabled: true, body: {
        "name": name,
        "email": email,
        "password": password,
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'device_token': deviceToken,
        "mac_address": macAddress,
        "national_id": nationalId,
        "phone": phone,
        "city_id": cityId,
        "country_id": countryId,
      });

      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModelLawyer>> registerAsLawyer({
    required String name,
    required String email,
    required String password,
    required String nationalId,
    required String phone,
    required String cityId,
    required String countryId,
    required String lawyerId,
    required String? type,
    required List<Speciality> selectedSpecialityList,
    String? levelId,
  }) async {
    final macAddress = await getMacAddress() ?? '';
    final deviceToken = await Preferences.instance.getDeviceToken();
    log('====>> $macAddress');
    log('====>> device Token :$deviceToken');
    try {
      final response = await dio
          .post(EndPoints.lawyerRegisterUrl, formDataIsEnabled: true, body: {
        "name": name,
        "email": email,
        "password": password,
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'device_token': deviceToken,
        "mac_address": macAddress,
        "national_id": nationalId,
        "phone": phone,
        "city_id": cityId,
        "country_id": countryId,
        "lawyer_id": lawyerId,
        "type": type,
        "level_id": levelId,
        for (int i = 0; i < selectedSpecialityList.length; i++)
          "speciality_ids[$i]": selectedSpecialityList[i].id.toString(),
      });

      return Right(LoginModelLawyer.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainOtpModel>> sendOtpClient({
    required String email,
    String? levelId,
  }) async {
    try {
      final response = await dio
          .post(EndPoints.clientSendOtpUrl, formDataIsEnabled: true, body: {
        "email": email,
      });

      return Right(MainOtpModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainOtpModel>> sendOtpLawyer({
    required String email,
    String? levelId,
  }) async {
    try {
      final response = await dio
          .post(EndPoints.lawyerSendOtpUrl, formDataIsEnabled: true, body: {
        "email": email,
      });

      return Right(MainOtpModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainVerifyOtpModel>> verifyOtpClient({
    required String email,
    required String? otp,
  }) async {
    try {
      final response = await dio
          .post(EndPoints.clientcheckOtpUrl, formDataIsEnabled: true, body: {
        "email": email,
        "otp": otp,
      });

      return Right(MainVerifyOtpModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainVerifyOtpModel>> verifyOtpLawyer({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await dio
          .post(EndPoints.lawyercheckOtpUrl, formDataIsEnabled: true, body: {
        "email": email,
        "otp": otp,
      });

      return Right(MainVerifyOtpModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> clientResetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(EndPoints.clientResetPasswordUrl,
          formDataIsEnabled: true,
          body: {"email": email, "password": password});

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> lawyerResetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(EndPoints.lawyerResetPasswordUrl,
          formDataIsEnabled: true,
          body: {"email": email, "password": password});

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModelLawyer>> lawyerUpdateEmail(
      {required String email}) async {
    try {
      final response = await dio.post(
        EndPoints.lawyerUpdateEmailUrl,
        formDataIsEnabled: true,
        body: {"email": email},
      );
      return Right(LoginModelLawyer.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> clientUpdateEmail(
      {required String email}) async {
    try {
      final response = await dio.post(
        EndPoints.clientUpdateEmailUrl,
        formDataIsEnabled: true,
        body: {"email": email},
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
