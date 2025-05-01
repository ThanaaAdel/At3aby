import 'package:ataaby/features/lawyer/packages/data/model/add_ad_offer_package_to_lawyer_model.dart';

import '../../../../../core/exports.dart';
import '../model/main_packages_model.dart';

class PackagesRepo {
  BaseApiConsumer dio;
  PackagesRepo(this.dio);

  //! getAdOfferPackagesUrl
  Future<Either<Failure, GetAdOfferPackagesModel>> getAdOfferPackages() async {
    try {
      final response = await dio.get(EndPoints.getAdOfferPackagesUrl);
      return Right(GetAdOfferPackagesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  //! Add AdOfferPackageToLawyer
  Future<Either<Failure, AddAdOfferPackageToLawyerModel>> addAdOfferPackagesToLawyer({
    required String packageId,

}) async {
    try {
      final response = await dio.post(EndPoints.addAdOfferPackagesToLawyer,
      body: {
        "package_id":packageId,

      });
      return Right(AddAdOfferPackageToLawyerModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
