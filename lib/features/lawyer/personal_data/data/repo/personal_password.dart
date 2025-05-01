import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/new_register/data/model/city_model.dart';
import 'package:ataaby/features/new_register/data/model/country_model.dart';
import 'package:dio/dio.dart';

import '../../../../login/data/models/login_model_lawyer.dart';

class PersonalDataRepo {
  BaseApiConsumer dio;
  PersonalDataRepo(this.dio);
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

  Future<Either<Failure, LoginModelLawyer>> updateProfileLawyer(
      {required int cityId,
      required int countryId,
      required String type,
      String? image,
      required int numberOfSuccessCases,
      required String aboutMe,
      required String? name,
      required int numberOfFailedCases,
      required String publicWorkController,
      required String attorneyFee,
      required String consultationFee,
      required String? phone}) async {
    final macAddress = await getMacAddress() ?? '';
    final deviceToken = await Preferences.instance.getDeviceToken();
    try {
      final response = await dio.post(EndPoints.updateProfileLawyerUrl,
          formDataIsEnabled: true,
          body: {
            'about': aboutMe,
            'device_type': Platform.isAndroid ? 'android' : 'ios',
            'device_token': deviceToken,
            "mac_address": macAddress,
            'city_id': cityId,
            'country_id': countryId,
            'type': type,
            'success_case': numberOfSuccessCases,
            'failed_case': numberOfFailedCases,
            'public_work': publicWorkController,
            'attorney_fee': attorneyFee,
            'consultation_fee': consultationFee,
            if (image != null)
              "image": MultipartFile.fromFileSync(image, filename: image),
            'number_of_success_cases': numberOfSuccessCases,
            'phone': phone,
            'name': name
          });

      return Right(LoginModelLawyer.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
