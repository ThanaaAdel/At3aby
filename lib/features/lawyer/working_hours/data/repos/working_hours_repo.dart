import 'dart:developer';

import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/working_hours/data/models/lawyer_work_times_model.dart';
import 'package:ataaby/features/lawyer/working_hours/data/models/update_status_lawyer_times_model.dart';

class WorkingHoursRepo {
  BaseApiConsumer api;
  WorkingHoursRepo(this.api);

  Future<Either<Failure, LawyerWorkTimesModel>> getLawyerWorkTimes() async {
    try {
      final response = await api.get(EndPoints.lawyerWorkTimesUrl);
      return Right(LawyerWorkTimesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, UpdateStatusLawyerTimesModel>> updateStatusLawyerWorkTimes({
    required int lawyerId,
    required String status,
    required String day,
}) async {
    try {
      final response = await api.post(EndPoints.updateLawyerWorkTimesUrl,

      body: {
        'lawyer_id':lawyerId,
        'status':status,
        'day':day,
      }
      );
      return Right(UpdateStatusLawyerTimesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LawyerWorkTimesModel>> updateLawyerWorkTimes({
    List<String>? fromTimeList, // السماح بأن تكون Null
    List<String>? toTimeList,
    List<String>? statusList,
    List<String>? dayList,
    required int lawyerId,
    required LawyerWorkTimesModel? existingData, // لإحضار القيم الافتراضية
  }) async {
    try {
      log(dayList?.length.toString()??'');
      final response = await api
          .post(EndPoints.lawyerWorkTimesUrl,
          formDataIsEnabled: true,
          body: {
        for (int i = 0; i <= 6; i++) 'day[$i]': dayList![i],
        for (int i = 0; i <= 6; i++)
          'to[$i]': toTimeList != null && toTimeList.length > i
              ? toTimeList[i]
              : existingData?.data?[i].to ?? DateTime.now().toString(),
        for (int i = 0; i <= 6; i++)
          'from[$i]': fromTimeList != null && fromTimeList.length > i
              ? fromTimeList[i]
              : existingData?.data?[i].from ?? DateTime.now().toString(),
        'lawyer_id': lawyerId,
        for (int i = 0; i <= 6; i++)
          'status[$i]': statusList != null && statusList.length > i
              ? statusList[i]
              : existingData?.data?[i].status ?? "inactive",
      });

      return Right(LawyerWorkTimesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
