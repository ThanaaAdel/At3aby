import 'package:ataaby/core/api/base_api_consumer.dart';
import 'package:ataaby/core/error/exceptions.dart';
import 'package:ataaby/core/error/failures.dart';
import 'package:ataaby/core/preferences/preferences.dart';
import 'package:ataaby/core/utils/get_mac_address.dart';
import 'package:ataaby/features/lawyer/details_issue/data/models/add_court_case_dues_model.dart';
import 'package:ataaby/features/lawyer/details_issue/data/models/get_court_by_id_model.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/api/end_points.dart';
import '../../../add_new_update/data/model/add_update_model.dart';
import '../../../add_new_update/data/model/delete_update.dart';
import '../models/get_refuse_reasons_model.dart';
import '../models/result_of_refuse.dart';

class DetailsIssueRepo {
  BaseApiConsumer dio;
  DetailsIssueRepo(this.dio);
  Future<Either<Failure, GetCourtCaseByIdModel>> getCourtById(String id) async {
    try {
      final response = await dio.get(
        EndPoints.getCourtByIdUrl + id.toString(),
      );
      return Right(GetCourtCaseByIdModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetMainCancelAndFinishModel>>
      getRefuseReasons() async {
    try {
      final response = await dio.get(EndPoints.getRefuseReasonsUrl);
      return Right(GetMainCancelAndFinishModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ActionCourtCaseModel>> lawyerActionCourtCase({
    String? status,
    String? eventId,
    String? refuseReasonId,
    String? refuseNote,
  }) async {
    try {
      final response = await dio.post(EndPoints.lawyerActionCourtCaseUrl,
          formDataIsEnabled: true,
          body: {
            "status": status,
            "event_id": eventId,
            "refuse_reason_id": refuseReasonId,
            "refuse_note": refuseNote,
          });
      return Right(ActionCourtCaseModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> addEventCourtCase({
    String? courtCaseId,
    String? price,
  }) async {
    try {
      final response = await dio.post(EndPoints.addEventCourtCaseUrl,
          formDataIsEnabled: true,
          body: {"court_case_id": courtCaseId, "price": price});
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AddCourtCaseDuesModel>> addCourtCaseDues({
    String? price,
    String? eventId,
    String? date,
    String? title,
  }) async {
    final macAddress = await getMacAddress() ?? '';
    final deviceToken = await Preferences.instance.getDeviceToken();
    try {
      final response = await dio
          .post(EndPoints.addCourtCaseDuesUrl, formDataIsEnabled: true, body: {
        'device_token': deviceToken,
        "mac_address": macAddress,
        'price': price,
        'event_id': eventId,
        'date': date,
        'title': title,
      });

      return Right(AddCourtCaseDuesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> deleteEventCourtCase({
    required String eventCaseId,
  }) async {
    try {
      final response =
          await dio.get(EndPoints.deleteEventCourtCaseUrl + eventCaseId);

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LawyerDeleteUpdateModel>> deleteCourtCaseUpdate({
    String? updateId,
  }) async {
    try {
      final response = await dio.delete(
        EndPoints.deleteCourtCaseUpdateUrl + (updateId ?? ''),
      );
      return Right(LawyerDeleteUpdateModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LawyerAddNewUpdateModel>> updateCourtCaseUpdate({
    String? updateId,
    String? title,
    String? details,
    String? date,
  }) async {
    try {
      final response = await dio.post(
          EndPoints.updateCourtCaseUpdateUrl + (updateId ?? ''),
          formDataIsEnabled: true,
          body: {
            "details": details,
            'date': date,
            'title': title,
          });
      return Right(LawyerAddNewUpdateModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
