import 'package:ataaby/core/api/base_api_consumer.dart';
import 'package:ataaby/core/api/end_points.dart';
import 'package:ataaby/core/error/exceptions.dart';
import 'package:ataaby/core/error/failures.dart';
import 'package:ataaby/features/lawyer/home_lawyer/data/model/get_office_request_model.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../new_register/data/model/specialities_model.dart';
import '../model/home_Laywer_model.dart';

class HomeLawyerRepo {
  BaseApiConsumer dio;

  HomeLawyerRepo(this.dio);

  Future<Either<Failure, HomeLawyerModel>> getCourtCaseFromSearch(
      {String? search, int? specialityId}) async {
    try {
      final response = await dio.get(EndPoints.homeLawyerUrl, queryParameters: {
        'search': search,
        'speciality_id': specialityId,
      });
      return Right(HomeLawyerModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, HomeLawyerModel>> getHomeData() async {
    try {
      final response = await dio.get(EndPoints.homeLawyerUrl
      );
      return Right(HomeLawyerModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, HomeLawyerModel>> homeDataFromLawyer(
      {String? search, int? specialityId}) async {
    try {
      final response = await dio.get(EndPoints.homeLawyerUrl, queryParameters: {
        'search': search,
        'speciality_id': specialityId,
      });
      return Right(HomeLawyerModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, GetOfficeRequestModel>> getOfficeRequest() async {
    try {
      final response = await dio.get(EndPoints.getOfficeRequestUrl);
      return Right(GetOfficeRequestModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainSpecialitiesModel>> getFilterHomeLawyer() async {
    try {
      final response = await dio.get(EndPoints.lawyertGetSpecialitieslUrl);

      return Right(MainSpecialitiesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, DefaultMainModel>> sendOfficeResponse(
  {
    required String requestId,
    required String status
}
      ) async {
    try {
      final response = await dio.post(EndPoints.sendOfficeResponseUrl,
      body: {
        'request_id':requestId,
        'status':status,
      }
      );

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
