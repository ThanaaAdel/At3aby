import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/current_issues/cubit/state.dart';
import 'package:ataaby/features/lawyer/current_issues/data/model/main_my_court_cases.dart';
import 'package:ataaby/features/lawyer/current_issues/data/repo/current_issues_repo.dart';

import '../../home_lawyer/data/model/home_Laywer_model.dart';
import '../data/model/main_sos_court.dart';

class CurrentIssuesCubit extends Cubit<CurrentIssuesState> {
  CurrentIssuesCubit(this.api) : super(CurrentIssuesStateInitial());
  CurrentIssuesRepo api;

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());

    if (currentIndex == 0) {
      getMyCourtCases(status: 'accepted');
    } else if (currentIndex == 1) {
      searchController.clear();
      getMyCourtCases(status: 'finished');
    } else {
      searchController.clear();

      // successGetBar('sos');
      mainSosCourtCases();
      // getMyCourtCases(status: 'sos');
    }
  }

  TextEditingController searchController = TextEditingController();
  List<NewCourtCase> issues = [];

  MainMyCourtCasesModel? mainMyCourtCasesModel;

  Future<void> getMyCourtCases(
      {String status = 'accepted', String? specialityId}) async {
    emit(LoadingGetMyCourtCasesStateState());
    final res = await api.getMyCourtCases(
        search: searchController.text,
        specialityId: specialityId,
        status: status);
    res.fold((l) {
      emit(ErrorGetMyCourtCasesStateState());
    }, (r) {
      mainMyCourtCasesModel = r;
      emit(LoadedGetMyCourtCasesStateState());
    });
  }

  MainSosCourtCasesModel? mainSosCourtCasesModel;

  Future<void> mainSosCourtCases(
      {String status = 'accepted', String? specialityId}) async {
    emit(LoadingGetMyCourtCasesStateState());
    final res = await api.mainSosCourtCases(
      search: searchController.text,
      specialityId: specialityId,
    );
    res.fold((l) {
      emit(ErrorGetMyCourtCasesStateState());
    }, (r) {
      mainSosCourtCasesModel = r;
      emit(LoadedGetMyCourtCasesStateState());
    });
  }
}
