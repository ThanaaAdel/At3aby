import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/details_issue/cubit/details_issue_state.dart';
import 'package:ataaby/features/lawyer/details_issue/data/models/get_court_by_id_model.dart';
import 'package:ataaby/features/lawyer/details_issue/data/repo/details_issue_repo.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

import '../data/models/add_court_case_dues_model.dart';
import '../data/models/get_refuse_reasons_model.dart';

class DetailsIssueCubit extends Cubit<DetailsIssueState> {
  DetailsIssueCubit(this.api) : super(DetailsIssueInitial());
  DetailsIssueRepo api;
  GetCourtCaseByIdModel? getCourtCaseByIdModel;
  TextEditingController notesController = TextEditingController();
  TextEditingController priceForOfferIssueController = TextEditingController();
  TextEditingController firstPaymentController = TextEditingController();
  TextEditingController secondPaymentController = TextEditingController();
  TextEditingController paymentMoneyController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
  final List<File> uploadedImage = [];
  final List<String> uploadedImageStrings = [];

  Future<void> onSelectedDate(BuildContext context) async {
    emit(LoadingAdvanceDateSelectedState());
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(9999),
    );

    if (picked != null) {
      selectedDate = picked;
      emit(AdvanceDateSelectedState());

      updateFormattedDate();
    }
  }

  void updateFormattedDate() {
    formattedDate = DateFormat('yyyy-MM-dd', 'en').format(selectedDate);
  }

  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  Future<void> getCourtById(BuildContext context, {required String id}) async {
    emit(GetCourtByIdLoading());
    final res = await api.getCourtById(id);
    res.fold((l) {
      emit(GetCourtByIdError());
    }, (r) async {
      if (r.status == 200) {
        getCourtCaseByIdModel = r;
        emit(GetCourtByIdSuccess());
      } else {
        errorGetBar(r.msg ?? '');
        emit(GetCourtByIdError());
      }
    });
  }

  GetRefuseReasonsModelData? selectedRefusedController;

  GetMainCancelAndFinishModel? getRefuseReasonsModel;
  Future<void> getRefuseReasons(BuildContext context) async {
    emit(LoadingGetRefuseState());

    final res = await api.getRefuseReasons();
    res.fold((l) {
      emit(ErrorGetRefuseState());
    }, (r) async {
      if (r.status == 200) {
        getRefuseReasonsModel = r;
        selectedRefusedController = getRefuseReasonsModel?.data?.first;
        emit(LoadedGetRefuseState());
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorGetRefuseState());
      }
    });
  }

  Future<void> lawyerActionCourtCase(BuildContext context,
      {bool isAccept = false}) async {
    emit(LoadingActionCourtCaseState());

    final res = await api.lawyerActionCourtCase(
        eventId: getCourtCaseByIdModel?.data?.lawyerEvent?.id.toString(),
        refuseNote: notesController.text,
        refuseReasonId: selectedRefusedController?.id.toString(),
        status: isAccept ? 'accepted' : 'rejected');
    res.fold((l) {
      emit(ErrorActionCourtCaseState());
    }, (r) async {
      if (r.status == 200) {
        successGetBar(r.msg ?? '');
        Navigator.pop(context);
        getCourtById(context,
            id: getCourtCaseByIdModel?.data?.id.toString() ?? "0");
        notesController.clear();
        getCourtCaseByIdModel = null;
        selectedRefusedController = null;
        emit(LoadedGetRefuseState());
      } else {
        Navigator.pop(context);
        errorGetBar(r.msg ?? '');
        emit(ErrorActionCourtCaseState());
      }
    });
  }

  Future<void> addEventCourtCase(BuildContext context) async {
    emit(LoadingAddEventCourtCaseState());

    final res = await api.addEventCourtCase(
      courtCaseId: getCourtCaseByIdModel?.data?.id.toString(),
      price: priceForOfferIssueController.text,
    );
    res.fold((l) {
      emit(ErrorAddEventCourtCaseState());
    }, (r) async {
      if (r.status == 200) {
        successGetBar(r.msg ?? '');
        Navigator.pop(context);
        getCourtById(context,
            id: getCourtCaseByIdModel?.data?.id.toString() ?? "0");
        priceForOfferIssueController.clear();
        emit(LoadedAddEventCourtCaseState());
      } else {
        Navigator.pop(context);
        errorGetBar(r.msg ?? '');
        priceForOfferIssueController.clear();
        emit(ErrorAddEventCourtCaseState());
      }
    });
  }

  AddCourtCaseDuesModel? addCourtCaseDuesModel;
  Future<void> addCourtCaseDues(BuildContext context) async {
    emit(AddCourtCaseDuesLoading());
    final res = await api.addCourtCaseDues(
        price: paymentMoneyController.text,
        eventId: getCourtCaseByIdModel?.data?.lawyerEvent?.id.toString(),
        date: selectedDate.toString(),
        title: addressController.text);
    res.fold((l) {
      emit(AddCourtCaseDuesLoaded());
    }, (r) async {
      if (r.status == 200) {
        addCourtCaseDuesModel = r;
        successGetBar(r.msg ?? '');
        Navigator.pop(context);
        getCourtById(context,
            id: getCourtCaseByIdModel?.data?.id.toString() ?? "0");
        paymentMoneyController.clear();
        addressController.clear();
        selectedDate = DateTime.now();
        emit(AddCourtCaseDuesLoaded());
      } else {
        errorGetBar(r.msg ?? '');
        Navigator.pop(context);
        paymentMoneyController.clear();
        addressController.clear();
        selectedDate = DateTime.now();
        emit(AddCourtCaseDuesError());
      }
    });
  }

  Future<void> deleteEventCourtCase({required BuildContext context}) async {
    emit(LoadingDeleteEventCourtCaseState());
    final res = await api.deleteEventCourtCase(
        eventCaseId:
            getCourtCaseByIdModel?.data?.lawyerEvent?.id?.toString() ?? '');

    res.fold((l) {
      emit(ErrorDeleteEventCourtCaseState());

      //!
    }, (r) {
      //!

      getCourtById(context,
          id: getCourtCaseByIdModel?.data?.id.toString() ?? "0");
      emit(LoadedDeleteEventCourtCaseState());
    });
  }

  Future<void> deleteCourtCaseUpdate(
    BuildContext context, {
    required String courtCaseId,
    required String updateId,
  }) async {
    AwesomeDialog(
        context: context,
        showCloseIcon: false,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        padding: EdgeInsets.all(10.w),
        title: "send_delete_success".tr(),
        btnOkText: "sure".tr(),
        btnCancelText: 'cancel'.tr(),
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          emit(LoadingDeleteNewUpdatesForCouse());
          final res = await api.deleteCourtCaseUpdate(updateId: updateId);
          res.fold((l) {
            emit(ErrorDeleteNewUpdatesForCouse());
          }, (r) {
            getCourtById(context, id: courtCaseId);
            emit(LoadedDeleteNewUpdatesForCouse());
          });
        }).show();
  }

  Future<void> updateCourtCaseUpdate(
    BuildContext context, {
    required String courtCaseId,
    required String updateId,
    required String date,
    required String details,
    required String title,
  }) async {
    emit(LoadingUpdateNewUpdatesForCouse());
    final res = await api.updateCourtCaseUpdate(
      updateId: updateId,
      // courtCaseId: courtCaseId,
      date: date,
      details: details,
      title: title,
    );
    res.fold((l) {
      emit(ErrorUpdateNewUpdatesForCouse());
    }, (r) {
      AwesomeDialog(
          context: context,
          showCloseIcon: false,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          padding: EdgeInsets.all(10.w),
          title: 'update_msg'.tr(),
          btnOkText: "sure".tr(),
          btnOkOnPress: () async {
            getCourtById(context, id: courtCaseId);
            Navigator.pop(context);
          }).show();

      emit(LoadedUpdateNewUpdatesForCouse());
    });
  }
}
