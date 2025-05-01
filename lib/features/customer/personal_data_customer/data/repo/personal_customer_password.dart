import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/login/data/models/login_model.dart';
import 'package:ataaby/features/new_register/data/model/city_model.dart';
import 'package:ataaby/features/new_register/data/model/country_model.dart';
import 'package:dio/dio.dart';

class PersonalCustomerDataRepo {
  BaseApiConsumer api;
  PersonalCustomerDataRepo(this.api);
  Future<Either<Failure, MainCountryModel>> getCountries() async {
    try {
      final response = await api.get(EndPoints.getCountriesUrl);

      return Right(MainCountryModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainCityModel>> getCities(String countryId) async {
    try {
      final response = await api.get(EndPoints.getCitiesUrl + countryId);

      return Right(MainCityModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> updateProfileCustomer(
      {required int cityId,
      required int countryId,
      String? image,
      required String? name,
      required String? phone,
      required String? nationalId}) async {
    final macAddress = await getMacAddress() ?? '';
    final deviceToken = await Preferences.instance.getDeviceToken();
    try {
      final response = await api
          .post(EndPoints.personalDataCustomer, formDataIsEnabled: true, body: {
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'device_token': deviceToken,
        "mac_address": macAddress,
        'city_id': cityId,
        'country_id': countryId,
        if (image != null)
          "image": MultipartFile.fromFileSync(image, filename: image),
        'national_id': nationalId,
        'phone': phone,
        'name': name
      });

      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
