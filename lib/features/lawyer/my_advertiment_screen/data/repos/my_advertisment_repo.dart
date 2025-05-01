import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/my_advertiment_screen/data/models/get_lawyer_package_ads_model.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';
import 'package:dio/dio.dart';

import '../models/get_lawyer_ad_packages_model.dart';

class MyAdvertismentRepo {
  BaseApiConsumer dio;
  MyAdvertismentRepo(this.dio);

  // الاشتراكات
  Future<Either<Failure, GetLawyerAdPackagesModel>>
      getLawyerAdPackages() async {
    try {
      final response = await dio.get(
        EndPoints.getLawyerAdPackagesUrl,
      );
      return Right(GetLawyerAdPackagesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // تفاصيل الاشتراك

  Future<Either<Failure, GetLawyerPackageAdsModel>> getLawyerPackageAdsDetails(
      {required String idFromPackage}) async {
    try {
      final response = await dio.get(
        EndPoints.getLawyerPackageAdsUrl + idFromPackage,
      );
      return Right(GetLawyerPackageAdsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // اضافة اعلان
  Future<Either<Failure, DefaultMainModel>> addAdsToLawyerPackage(
      {required String id,
      required String fromDate,
      required String toDate,
      required File image}) async {
    try {
      final response = await dio.post(EndPoints.addAdsToLawyerPackageUrl,
          formDataIsEnabled: true,
          body: {
            'id': id,
            'from_date': fromDate,
            'to_date': toDate,
            'image': MultipartFile.fromFileSync(image.path,
                filename: image.path.split('/').last),
          });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
