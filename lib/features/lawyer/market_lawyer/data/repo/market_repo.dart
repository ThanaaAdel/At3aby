import '../../../../../core/exports.dart';
import '../model/all_products_model.dart';

class MarketLawyerRepo {
  BaseApiConsumer dio;
  MarketLawyerRepo(this.dio);

  //! need handling
  Future<Either<Failure, MainHomeMarketModel>> getHomeMarket(
      {String? search, String? category = '0'}) async {
    try {
      final response = await dio.get(
          '${EndPoints.getHomeMarketUrl}?category=$category&search=$search');

      return Right(MainHomeMarketModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
