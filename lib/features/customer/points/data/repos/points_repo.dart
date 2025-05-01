import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/points/data/models/points_model.dart';

class PointsRepo {
  BaseApiConsumer api;
  PointsRepo(this.api);

  Future<Either<Failure, PointsModel>> getPointsClientData() async {
    try {
      final response = await api.get(EndPoints.pointsClientUrl);

      return Right(PointsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
