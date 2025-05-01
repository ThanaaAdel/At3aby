
import 'package:ataaby/core/exports.dart';

import '../models/promo_code_model.dart';

class ProfileCustomerRepo {
  BaseApiConsumer api;
  ProfileCustomerRepo(this.api);

  Future<Either<Failure, PromoCodeModel>> getPromoCode() async {
    try {
      final response = await api.get(EndPoints.getCommercialCodeUrl
      );
      return Right(PromoCodeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
