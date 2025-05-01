

import 'package:ataaby/features/customer/details_lawyer_from_customer/data/model/details_data_lawyer_model.dart';
import '../../../../../core/exports.dart';

class DetailsLawyerFromCustomerPartRepo {
  BaseApiConsumer api;
  DetailsLawyerFromCustomerPartRepo(this.api);
  Future<Either<Failure, DetailsDataLawyerModel>> getDetailsDataCustomer({required int lawyerId}) async {
    try {
      final response = await api.get("${EndPoints.homeDetailsDataCustomer}$lawyerId");

      return Right(DetailsDataLawyerModel.fromJson(response));

    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
