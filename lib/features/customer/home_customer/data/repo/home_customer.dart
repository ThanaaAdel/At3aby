import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/home_customer/data/models/home_data_lawyer_model.dart';

import '../../../../new_register/data/model/levels_model.dart';
import '../../../../new_register/data/model/specialities_model.dart';

class HomeCustomerRepo {
  BaseApiConsumer dio;
  HomeCustomerRepo(this.dio);

  Future<Either<Failure, HomeDataCustomer>> getHomeDataCustomer({
    String? lng,
    String? lat,
  }) async {
    try {
      final response = await dio.get(
        '${EndPoints.homeDataCustomer}?lng=$lng&lat=$lat',
      );

      return Right(HomeDataCustomer.fromJson(response));
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
}
