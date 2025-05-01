
import 'package:ataaby/features/notifications/data/models/notification_lawyer_model.dart';

import '../../../../core/exports.dart';
import '../models/notification_client_model.dart';

class NotificationsRepo {
  BaseApiConsumer api;
  NotificationsRepo(this.api);
  Future<Either<Failure, NotificationLawyerModel>> getNotificationLawyersData() async {
    try {
      final response =
      await api.get(EndPoints.notificationLawyerUrl);

      return Right(NotificationLawyerModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }  Future<Either<Failure, NotificationClientModel>> getNotificationClientData() async {
    try {
      final response =
      await api.get(EndPoints.notificationClientUrl);

      return Right(NotificationClientModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
