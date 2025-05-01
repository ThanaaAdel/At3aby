import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';
import 'package:ataaby/features/customer/courts/the_courts/cubit/state.dart';
import 'package:ataaby/features/customer/courts/the_courts/data/models/action_event_model.dart';
import 'package:ataaby/features/customer/courts/the_courts/data/models/court_case_model.dart';
import 'package:ataaby/features/customer/courts/the_courts/data/models/get_court_case_dues_model.dart';
import 'package:ataaby/features/customer/courts/the_courts/data/repo/issues_customer_repo.dart';
import 'package:ataaby/features/lawyer/current_issues/data/model/main_sos_court.dart';
import 'package:ataaby/features/lawyer/details_issue/data/models/get_refuse_reasons_model.dart';

import '../../../../new_register/data/model/default_model.dart';

class TheCourtsCustomerCubit extends Cubit<TheCourtsCustomerState> {
  TheCourtsCustomerCubit(this.api) : super(TheCourtsCustomerInitial());
  TheCourtsCustomerRepo api;
  int currentIndex = 0;
   double rating = 0;
  void changeIndex(int index) {
    currentIndex = index;
    getCourtData();
    emit(ChangeIndexState());
  }
  TextEditingController cancelNoteController  = TextEditingController();
  TextEditingController commentFromLawyerController = TextEditingController();
  GetRefuseReasonsModelData? reasonCancel; //! delete order
  GetRefuseReasonsModelData? reasonFinish;
  String? selectedCityController;

  int detailsCourtCaseCurrentIndex = 0;
  void detailsCourtCaseChangeIndex(int index) {
    detailsCourtCaseCurrentIndex = index;
    emit(ChangeIndexState());
  }

  MainSosCourtCasesModel? courtCaseSosModel;
  CourtCaseModel? courtCaseModel;
  getCourtData() async {
    emit(LoadingGetCourtData());
    final res = await api.getCourtCase((currentIndex == 0
        ? 'new'
        : currentIndex == 1
            ? "old"
            : "sos"));
    res.fold((l) {
      emit(ErrorGetCourtData());
    }, (r) {
      currentIndex == 2 ? courtCaseSosModel = r : courtCaseModel = r;
      emit(LoadedGetCourtData());
    });
  }

  AddNewCourtCaseModel? detailsCourtCase;
  getCourtDetailsData({required String id}) async {
    emit(LoadingGetDetailsCourtData());
    final res = await api.getDetailsCourtCase(id.toString());
    res.fold((l) {
      emit(ErrorGetDetailsCourtData());
    }, (r) {
      detailsCourtCase = r;
      emit(LoadedGetDetailsCourtData());
    });
  }

  GetCourtCaseDuesModel? getCourtCaseDuesModel;
  getCourtCaseDuesData({required String id}) async {
    emit(LoadingCourtCaseDuesData());
    final res = await api.getCourtCaseDues(id);
    res.fold((l) {
      emit(ErrorCourtCaseDuesData());
    }, (r) {
      getCourtCaseDuesModel = r;
      emit(LoadedCourtCaseDuesData());
    });
  }

  GetMainCancelAndFinishModel? getCancelModel;
  getCancelReasons() async {
    emit(LoadingCourtCaseDuesData());
    final res = await api.getCancelReasons();
    res.fold((l) {
      emit(ErrorCourtCaseDuesData());
    }, (r) {
      getCancelModel = r;
      emit(LoadedCourtCaseDuesData());
    });
  }

  ActionEventModel? actionEventModel;
  actionEvent(
      {required String status,
      required int courtCaseEventId,
      required String id}) async {
    emit(LoadingActionEventData());
    final res = await api.actionEvent(
      status: status,
      courtCaseEventId: courtCaseEventId,
    );
    res.fold((l) {

      emit(ErrorActionEventData());
    }, (r) {
      actionEventModel = r;
      getCourtDetailsData(id: id.toString());
      emit(LoadedActionEventData());
    });
  }
  DefaultMainModel? defaultMainModel;
  cancelCourtCase(
  BuildContext context,{required String courtCaseId,}) async {
    emit(LoadingCancelCourtCaseData());
    final res = await api.cancelCourtCase(
      cancelNote: cancelNoteController.text,
      cancelReasonId: reasonCancel?.id.toString() ?? "" ,
      courtCaseId: courtCaseId,
    );
    res.fold((l) {
      errorGetBar(l.toString());
      emit(ErrorCancelCourtCaseData());
      cancelNoteController.clear();
      Navigator.pop(context);

    }, (r) {
      successGetBar(r.msg.toString());
      getCourtDetailsData(id: courtCaseId);
      getCourtData();
      Navigator.pop(context);
      Navigator.pop(context);

      cancelNoteController.clear();
      emit(LoadedCancelCourtCaseData());
    });
  }
  finishCourtCase(
  BuildContext context,{required String courtCaseId,}) async {
    emit(LoadingFinishCourtCaseData());
    final res = await api.finishCourtCase(
      comment: commentFromLawyerController.text,
      rate: rating.toString(),
      reasonId: reasonFinish?.id.toString() ?? "",
      courtCaseId: courtCaseId,
    );
    res.fold((l) {
      errorGetBar(l.toString());
      emit(ErrorFinishCourtCaseData());
      commentFromLawyerController.clear();


    }, (r) {
      successGetBar(r.msg.toString());
      commentFromLawyerController.clear();
      getCourtDetailsData(id: courtCaseId);
      getCourtData();
      Navigator.pop(context);
      Navigator.pop(context);
      emit(LoadedFinishCourtCaseData());
    });
  }

  GetMainCancelAndFinishModel? getFinishReasonsModel;
  Future<void> getFinishReasons(BuildContext context) async {
    emit(LoadingGetRefuseState());
    // tset

    final res = await api.getFinishReasons();
    res.fold((l) {
      emit(ErrorGetRefuseState());
    }, (r) async {
      if (r.status == 200) {
        getFinishReasonsModel = r;

        // selectedRefusedController = getRefuseReasonsModel?.data?.first;
        emit(LoadedGetRefuseState());
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorGetRefuseState());
      }
    });
  }

}
