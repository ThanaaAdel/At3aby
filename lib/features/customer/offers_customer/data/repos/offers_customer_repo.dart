import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/offers_customer/data/models/offers_model.dart';

class OffersCustomerRepo {
  BaseApiConsumer api;
  OffersCustomerRepo(this.api);
  Future<Either<Failure, OffersModel>> getOffersData() async {
    try {
      final response = await api.get(EndPoints.getOffersUrl);

      return Right(OffersModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
