import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';
import 'package:ataaby/features/customer/courts/the_courts/data/models/action_event_model.dart';
import 'package:ataaby/features/customer/courts/the_courts/data/models/court_case_model.dart';
import 'package:ataaby/features/customer/courts/the_courts/data/models/get_court_case_dues_model.dart';
import 'package:ataaby/features/lawyer/current_issues/data/model/main_sos_court.dart';
import 'package:ataaby/features/lawyer/details_issue/data/models/get_refuse_reasons_model.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';
import '../../../../../../core/exports.dart';

class TheCourtsCustomerRepo {
  BaseApiConsumer api;
  TheCourtsCustomerRepo(this.api);
  Future<Either<Failure, dynamic>> getCourtCase(String typeCourt) async {
    try {
      final response = await api.get(EndPoints.courtCase + typeCourt);

      return typeCourt == 'sos'
          ? Right(MainSosCourtCasesModel.fromJson(response))
          : Right(CourtCaseModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AddNewCourtCaseModel>> getDetailsCourtCase(
      String id) async {
    try {
      final response =
          await api.get(EndPoints.detailsCourtCase + id.toString());

      return Right(AddNewCourtCaseModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetCourtCaseDuesModel>> getCourtCaseDues(
      String id) async {
    try {
      final response = await api.get(EndPoints.getCourtCaseDues + id);

      return Right(GetCourtCaseDuesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetMainCancelAndFinishModel>>
      getCancelReasons() async {
    try {
      final response = await api.get(EndPoints.getCancelReasonsUrl);

      return Right(GetMainCancelAndFinishModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> cancelCourtCase(
      {required String courtCaseId,
      required String cancelReasonId,
      required String cancelNote}) async {
    try {
      final response = await api.post(EndPoints.cancelCourtCaseUrl, body: {
        "court_case_id": courtCaseId,
        "cancel_reason_id": cancelReasonId,
        "canel_note": cancelNote,
      });

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> finishCourtCase(
      {required String courtCaseId,
      required String reasonId,
      required String rate,
      required String comment}) async {
    try {
      final response = await api.post(EndPoints.finishCourtCaseUrl, body: {
        "court_case_id": courtCaseId,
        "reason_id": reasonId,
        "rate": rate,
        "comment": comment,
      });

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ActionEventModel>> actionEvent(
      {required String status, required int courtCaseEventId}) async {
    try {
      final response = await api.post(EndPoints.actionEvent, body: {
        "court_case_event_id": courtCaseEventId,
        "status": status,
      });

      return Right(ActionEventModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetMainCancelAndFinishModel>>
      getFinishReasons() async {
    try {
      final response = await api.get(EndPoints.getRefuseReasonsUrl);
      return Right(GetMainCancelAndFinishModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
