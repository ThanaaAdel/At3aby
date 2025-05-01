import '../../../../../core/exports.dart';
import '../model/main_my_court_cases.dart';
import '../model/main_sos_court.dart';

class CurrentIssuesRepo {
  BaseApiConsumer dio;
  CurrentIssuesRepo(this.dio);
  Future<Either<Failure, MainMyCourtCasesModel>> getMyCourtCases({
    String status = 'accepted',
    String search = '',
    String? specialityId,
  }) async {
    try {
      final response = await dio.get(
        "${EndPoints.getMyCourtCasesUrl}?status=$status&search=$search&speciality_id=${specialityId ?? ''}",
      );

      return Right(MainMyCourtCasesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainSosCourtCasesModel>> mainSosCourtCases({
    String search = '',
    String? specialityId,
  }) async {
    try {
      final response = await dio.get(
        "${EndPoints.getMyCourtCasesUrl}?status=sos&search=$search&speciality_id=${specialityId ?? ''}",
      );

      return Right(MainSosCourtCasesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
