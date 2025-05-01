
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/notifications/cubit/notifications_state.dart';
import 'package:ataaby/features/notifications/data/repos/notifications_repo.dart';

import '../data/models/notification_client_model.dart';
import '../data/models/notification_lawyer_model.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.notificationsRepo) : super(NotificationsInitial());
  NotificationsRepo notificationsRepo ;
  NotificationLawyerModel? notificationLawyerModel;
  getNotificationLawyersData() async {
    emit(LoadingNotificationLawyersData());
    final res = await notificationsRepo.getNotificationLawyersData();
    res.fold((l) {
      emit(ErrorNotificationLawyersData());
    }, (r) {
      notificationLawyerModel = r;
      emit(LoadedNotificationLawyersData());
    });
  }
  NotificationClientModel? notificationClientModel;
  getNotificationClientData() async {
    emit(LoadingNotificationClientData());
    final res = await notificationsRepo.getNotificationClientData();
    res.fold((l) {
      emit(ErrorNotificationClientData());
    }, (r) {
      notificationClientModel = r;
      emit(LoadedNotificationClientData());
    });
  }
}
