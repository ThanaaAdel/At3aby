import 'package:ataaby/core/exports.dart';

import 'model/all_lawyers_model.dart';

class LawyersRepoImplementation {
  BaseApiConsumer dio;
  LawyersRepoImplementation(this.dio);

  Future<Either<Failure, MainCustomerLawyerModel>> getAllLawyers({
    String? type,
    String? levelId,
    String? specialityId,
    String? lat,
    String? lng,
    String? search,
  }) async {
    try {
      final response =
          await dio.get(EndPoints.clientGetLawyers, queryParameters: {
        if (type != null) type: 1,
        "level_id": levelId,
        "speciality_id": specialityId,
        "lat": lat,
        "lng": lng,
        "search": search
      });

      return Right(MainCustomerLawyerModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
