
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/working_hours/cubit/working_hours_state.dart';
import 'package:ataaby/features/lawyer/working_hours/data/models/lawyer_work_times_model.dart';
import 'package:ataaby/features/lawyer/working_hours/data/models/update_status_lawyer_times_model.dart';
import 'package:ataaby/features/lawyer/working_hours/data/repos/working_hours_repo.dart';

class WorkingHoursCubit extends Cubit<WorkingHoursState> {
  WorkingHoursCubit(this.workingHoursRepo) : super(WorkingHoursInitial());
  WorkingHoursRepo workingHoursRepo;

  LawyerWorkTimesModel? lawyerWorkTimesModel;

  Future<void> onSelectedTime(BuildContext context, int index, bool isFromTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()), // استخدم الوقت الحالي كافتراضي
    );

    if (picked != null) {
      final formattedTime = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";

      if (lawyerWorkTimesModel != null && lawyerWorkTimesModel!.data != null && index < lawyerWorkTimesModel!.data!.length) {
        if (isFromTime) {
          lawyerWorkTimesModel!.data![index].from = formattedTime;
        } else {
          lawyerWorkTimesModel!.data![index].to = formattedTime;
        }
        emit(SuccessLawyerWorkTimesState()); // إعادة بناء الـ UI بعد تحديث الوقت
      }
    }
  }

  void getLawyerWorkTimes() async {
    emit(LoadingLawyerWorkTimesState());
    final res = await workingHoursRepo.getLawyerWorkTimes();
    res.fold((l) {
      emit(ErrorLawyerWorkTimesState());
    }, (r) {
      lawyerWorkTimesModel = r;
      emit(SuccessLawyerWorkTimesState());
    });
  }
  UpdateStatusLawyerTimesModel? updateStatusLawyerTimesModel;
  void updateStatusLawyerWorkTimes({
    required int lawyerId,
    required String status,
    required String day,}) async {
    emit(LoadingLawyerWorkTimesState());
    final res = await workingHoursRepo.updateStatusLawyerWorkTimes(
        lawyerId: lawyerId,
        status: status,
        day: day);
    res.fold((l) {
      emit(ErrorLawyerWorkTimesState());
    }, (r) {
      updateStatusLawyerTimesModel = r;
      emit(SuccessLawyerWorkTimesState());
    });
  }

  void updateLawyerWorkTimes({required int lawyerId}) async {
    emit(LoadingLawyerWorkTimesState());

    if (lawyerWorkTimesModel != null && lawyerWorkTimesModel!.data != null) {
      final res = await workingHoursRepo.updateLawyerWorkTimes(
        lawyerId: lawyerId,
        dayList: lawyerWorkTimesModel!.data!.map((e) => e.day!).toList(),
        fromTimeList: lawyerWorkTimesModel!.data!.map((e) => e.from!).toList(),
        toTimeList: lawyerWorkTimesModel!.data!.map((e) => e.to!).toList(),
        statusList: lawyerWorkTimesModel!.data!.map((e) => e.status!).toList(),
        existingData: lawyerWorkTimesModel,
      );

      res.fold(
            (l) {
          emit(ErrorLawyerWorkTimesState());
          errorGetBar(l.toString());
        },
            (r) {
          lawyerWorkTimesModel = r;
          successGetBar(r.msg ?? 'تم التحديث بنجاح');
          emit(SuccessLawyerWorkTimesState());
        },
      );
    }
  }
}
