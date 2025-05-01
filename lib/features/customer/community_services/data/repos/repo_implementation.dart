import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/community_services/data/models/get_community_service_categories_model.dart';
import 'package:ataaby/features/customer/community_services/data/models/get_community_service_details_categories_model.dart';

class CommunityServicesRepo {
  BaseApiConsumer dio;
  CommunityServicesRepo(this.dio);
  // main community service
  Future<Either<Failure, GetCommunityServiceCategoriesModel>>
      getCommunityServiceCategories( String search) async {
    try {
      final response =
          await dio.get('${EndPoints.getCommunityServiceCategoriesUrl}?q= $search');

      return Right(GetCommunityServiceCategoriesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }



  Future<Either<Failure, GetCommunityServiceDetailsFromCategoriesModel>>
      getCommunityServiceDetailsCategories({
    required String id,
  }) async {
    try {
      final response = await dio.get(
          EndPoints.getCommunityServiceDetailsCategoriesUrl + id.toString());

      return Right(GetCommunityServiceDetailsFromCategoriesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
