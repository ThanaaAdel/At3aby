// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:ataaby/core/api/base_api_consumer.dart';

import '../../../../core/exports.dart';
import '../../../new_register/data/model/default_model.dart';
import '../../details_issue/data/models/get_court_by_id_model.dart';
import 'models/details_of_share.dart';
import 'models/get_send_courtcases_model.dart';
import 'models/getallshared_courtcase.dart';
import 'models/send_courtcase_details_model.dart';

class CourtcaseSharedandSendRepo {
  BaseApiConsumer dio;
  CourtcaseSharedandSendRepo(this.dio);

//! i need
//? API of get Shared
//? API of of details of courtcase shared

//? API of of details of courtcase shared && send
//? API of take action for shared
//? API of take action for send
//? API of share courtcase with another lawyer
//? API of send courtcase to another client

// GetSendCourtsClientModel

// getAllTransferCourtCasesUrl

  Future<Either<Failure, GetSendCourtsClientModel>>
      getAllTransferCourtCases() async {
    try {
      final response = await dio.get(EndPoints.getAllTransferCourtCasesUrl);
      return Right(GetSendCourtsClientModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>>
      transferCourtCaseToAnotherLawyerResponse({
    required String courtCaseEventId,
    required String transferClientStatus,
  }) async {
    try {
      final response = await dio.post(
          EndPoints.transferCourtCaseToAnotherLawyerResponseUrl,
          formDataIsEnabled: true,
          body: {
            "court_case_event_id": courtCaseEventId,
            "transfer_client_status": transferClientStatus,
          });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>>
      transferCourtCaseToAnotherLawyerResponseLawyer({
    required String courtCaseEventId,
    required String transferClientStatus,
  }) async {
    try {
      final response = await dio.post(
          EndPoints.transferCourtCaseToAnotherLawyerResponseLawyerUrl,
          formDataIsEnabled: true,
          body: {
            "court_case_event_id": courtCaseEventId,
            "transfer_lawyer_status": transferClientStatus
          });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //? API of get send
  Future<Either<Failure, GetSendCourtsClientModel>>
      getAllTransferCourtCaseslawyer() async {
    try {
      final response =
          await dio.get(EndPoints.getAllTransferCourtCaseslawyerUrl);
      return Right(GetSendCourtsClientModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //getDetailsOfCourtcase
  Future<Either<Failure, CourtCaseDetailsSendModel>> getDetailsOfCourtcase(
      String courtcaseId) async {
    try {
      final response =
          await dio.get(EndPoints.courtCaseTransferRequestUrl + courtcaseId);
      return Right(CourtCaseDetailsSendModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //getDetailsOfCourtcase
  Future<Either<Failure, GetAllCourtCaseSharedModel>>
      getAllCourtCaseShared() async {
    try {
      final response = await dio.get(EndPoints.getAllContributionCourtCasesUrl);
      return Right(GetAllCourtCaseSharedModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //getDetailsOfCourtcase
  Future<Either<Failure, CourtCaseDetailsSendModel>>
      courtCaseContributionRequestById(String id) async {
    try {
      final response =
          await dio.get(EndPoints.courtCaseContributionRequestByIdUrl + id);

      return Right(CourtCaseDetailsSendModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>>
      shareCourtCaseToAnotherLawyerResponseLawyer({
    required String courtCaseEventId,
    required String transferClientStatus,
  }) async {
    try {
      final response = await dio.post(
        '${EndPoints.addLawyerToCourtCaseResponseUrl}$courtCaseEventId&status=$transferClientStatus',
      );
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
