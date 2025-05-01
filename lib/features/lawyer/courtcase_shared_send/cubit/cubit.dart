// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/exports.dart';
import '../../../../core/utils/appwidget.dart';

import '../data/models/details_of_share.dart';
import '../data/models/get_send_courtcases_model.dart';
import '../data/models/getallshared_courtcase.dart';
import '../data/models/send_courtcase_details_model.dart';
import '../data/repo_impl.dart';
import 'state.dart';

class CourtcaseSharedandSendCubit extends Cubit<CourtcaseSharedandSendState> {
  CourtcaseSharedandSendCubit(this.api)
      : super(CourtcaseSharedandSendInitial());

  final CourtcaseSharedandSendRepo api;

  //?

  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  GetSendCourtsClientModel? getSendCourtsClientModel;
  getAllTransferCourtCases() async {
    emit(LoadingGetAllTransferCourtCasesState());
    final res = await api.getAllTransferCourtCases();

    res.fold((l) {
      emit(ErrorGetAllTransferCourtCasesState());
    }, (r) {
      getSendCourtsClientModel = r;
      emit(LoadedGetAllTransferCourtCasesState());
    });
  }
  //! Lawyer

  GetSendCourtsClientModel? getAllTransferCourtCaseslawyerModel;
  getAllTransferCourtCaseslawyer() async {
    emit(LoadingGetAllTransferCourtCasesState());
    final res = await api.getAllTransferCourtCaseslawyer();

    res.fold((l) {
      emit(ErrorGetAllTransferCourtCasesState());
    }, (r) {
      getAllTransferCourtCaseslawyerModel = r;
      emit(LoadedGetAllTransferCourtCasesState());
    });
  }

  GetAllCourtCaseSharedModel? getAllCourtCaseSharedModel;
  getAllCourtCaseShared() async {
    emit(LoadingGetAllTransferCourtCasesState());
    final res = await api.getAllCourtCaseShared();
    res.fold((l) {
      emit(ErrorGetAllTransferCourtCasesState());
    }, (r) {
      getAllCourtCaseSharedModel = r;
      emit(LoadedGetAllTransferCourtCasesState());
    });
  }

  CourtCaseDetailsSendModel? getSharedCourtCaseByIdModel;
  getDetailsOfCourtcase(String courtcaseId) async {
    emit(LoadingGetDetailsOfTransferById());
    final res = await api.getDetailsOfCourtcase(courtcaseId);

    res.fold((l) {
      emit(ErrorGetDetailsOfTransferById());
    }, (r) {
      getSharedCourtCaseByIdModel = r;
      emit(LoadedGetDetailsOfTransferById());
    });
  }

  transferCourtCaseToAnotherLawyerResponse({
    required String courtCaseEventId,
    required String transferClientStatus,
    required BuildContext context,
  }) async {
    emit(LoadingTransferCourtCasesState());

    AppWidget.createProgressDialog(context);
    final res = await api.transferCourtCaseToAnotherLawyerResponse(
        courtCaseEventId: courtCaseEventId,
        transferClientStatus: transferClientStatus);

    res.fold((l) {
      Navigator.pop(context);

      emit(ErrorTransferCourtCasesState());
    }, (r) {
      Navigator.pop(context);

      getAllTransferCourtCases();
      emit(LoadedTransferCourtCasesState());
    });
  }

  transferCourtCaseToAnotherLawyerResponseLawyer({
    required String courtCaseEventId,
    required String transferClientStatus,
    required BuildContext context,
  }) async {
    emit(LoadingTransferCourtCasesState());

    AppWidget.createProgressDialog(context);
    final res = await api.transferCourtCaseToAnotherLawyerResponseLawyer(
        courtCaseEventId: courtCaseEventId,
        transferClientStatus: transferClientStatus);

    res.fold((l) {
      Navigator.pop(context);

      emit(ErrorTransferCourtCasesState());
    }, (r) {
      Navigator.pop(context);
      getAllTransferCourtCaseslawyer();

      Navigator.pop(context);
      emit(LoadedTransferCourtCasesState());
    });
  }

  //! Shared Court Case

  CourtCaseDetailsSendModel? getAllCourtCaseSharedModelDetails;
  courtCaseContributionRequestById(String courtcaseId) async {
    emit(LoadingGetDetailsOfTransferById());
    final res = await api.courtCaseContributionRequestById(courtcaseId);

    res.fold((l) {
      emit(ErrorGetDetailsOfTransferById());
    }, (r) {
      getAllCourtCaseSharedModelDetails = r;
      emit(LoadedGetDetailsOfTransferById());
    });
  }

  shareCourtCaseToAnotherLawyerResponseLawyer({
    required String courtCaseEventId,
    required String transferClientStatus,
    required BuildContext context,
  }) async {
    emit(LoadingTransferCourtCasesState());

    AppWidget.createProgressDialog(context);
    final res = await api.shareCourtCaseToAnotherLawyerResponseLawyer(
        courtCaseEventId: courtCaseEventId,
        transferClientStatus: transferClientStatus);

    res.fold((l) {
      Navigator.pop(context);

      emit(ErrorTransferCourtCasesState());
    }, (r) {
      getAllCourtCaseShared();
      Navigator.pop(context);
      Navigator.pop(context);
      emit(LoadedTransferCourtCasesState());
    });
  }
}
