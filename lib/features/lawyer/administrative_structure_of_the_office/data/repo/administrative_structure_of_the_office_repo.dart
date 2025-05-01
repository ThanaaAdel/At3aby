import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/data/model/get_office_team_model.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/data/model/search_lawyer_model.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';

import '../../../../../core/exports.dart';
import '../model/all-lawyers-model.dart';
import '../model/get_lawyers_general_model.dart';
import '../model/team_work_model.dart';

class AdministrativeStructureOfTheOfficeRepo {
  BaseApiConsumer dio;
  AdministrativeStructureOfTheOfficeRepo(this.dio);

  //! lawyer/getOfficeTeam
  //! need handling
  Future<Either<Failure, MainTeamWorkModel>> getOfficeTeam() async {
    try {
      final response = await dio.get(EndPoints.getOfficeTeamUrl);

      return Right(MainTeamWorkModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> deleteLawyerFromOffice(
      {required String id}) async {
    try {
      final response = await dio.post(
        EndPoints.deleteLawyerFromOffice,
        body: {"id": id},
        formDataIsEnabled: true,
      );

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetOfficeTeamModel>> getOfficeTeamData() async {
    try {
      final response = await dio.get(EndPoints.getOfficeTeamUrl);
      return Right(GetOfficeTeamModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetLawyersGeneralModel>>
      getAllLawyersFromSendAndSubscription() async {
    try {
      final response = await dio.get(EndPoints.getLawyersFromGeneral);
      return Right(GetLawyersGeneralModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> sendOfficeRequest(
      {required String lawyerId}) async {
    try {
      final response = await dio.post(EndPoints.sendOfficeRequest, body: {
        'lawyer_id': lawyerId,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // send to anather lawyer
  Future<Either<Failure, DefaultMainModel>> sendOfficeRequestToAnatherLawyer({
    required String courtCaseId,
    required String transfareLawyerId,
  }) async {
    try {
      final response =
          await dio.post(EndPoints.transfareCourtCaseToAnatherLawyer, body: {
        "court_case_id": courtCaseId,
        "transfer_lawyer_id": transfareLawyerId,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SearchLawyerModel>> searchLawyerData(
      {required int lawyerId}) async {
    try {
      final response =
          await dio.get(EndPoints.searchLawyerUrl + lawyerId.toString());
      return Right(SearchLawyerModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> addLawyerToCourtCaseRequest(
      {required String lawyerId,
      required String courtCaseId,
      required String describtion,
      required String price}) async {
    try {
      final response =
          await dio.post(EndPoints.addLawyerToCourtCaseRequestUrl, body: {
        "lawyer_id": lawyerId,
        "court_case_id": courtCaseId,
        "price": price,
        "comment": describtion
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
