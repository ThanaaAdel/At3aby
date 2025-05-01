import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/home_lawyer/cubit/state.dart';
import 'package:ataaby/features/lawyer/home_lawyer/data/model/get_office_request_model.dart';
import 'package:ataaby/features/lawyer/home_lawyer/data/repo/home_lawyer.dart';

import '../../current_issues/cubit/cubit.dart';
import '../data/model/home_Laywer_model.dart';
import '../../../new_register/data/model/specialities_model.dart';
import '../data/model/specialist_model.dart';

class HomeLawyerCubit extends Cubit<HomeLawyerState> {
  HomeLawyerCubit(this.api) : super(HomeLawyerStateInitial());
  HomeLawyerRepo api;
  TextEditingController searchController = TextEditingController();
  bool isExpandedSpecialization = false;
  Speciality? selectedSpecialization; // !you will

  onSelectItem(Speciality item) {
    selectedSpecialization = item;
    emit(OnChangeFilterItemState());
  }

  onCancelFilter(BuildContext context, {bool isCurrentcases = false}) {
    selectedSpecialization = null;
    Navigator.pop(context);
    if (isCurrentcases) {
      //! DONE
      context.read<CurrentIssuesCubit>().searchController.clear();
      context.read<CurrentIssuesCubit>().changeIndex(0);
    } else {
      getCourtCaseFromSearch(context);
    }

    emit(OnClearFilterItemState());
  }

  MainSpecialitiesModel? mainSpecialitiesModel;
  getFilterSpecialist() async {
    emit(LoadingGetFilterSpecialist());
    final res = await api.getFilterHomeLawyer();
    res.fold((l) {
      emit(ErrorGetFilterSpecialist());
    }, (r) {
      mainSpecialitiesModel = r;
      emit(LoadedGetFilterSpecialist());
    });
  }

  HomeLawyerModel? searchModel;
  Future<void> getCourtCaseFromSearch(
    BuildContext context,
  ) async {
    emit(CourtCaseFromSearchLoading());
    final res = await api.getCourtCaseFromSearch(
        search: searchController.text,
        specialityId: selectedSpecialization?.id);
    res.fold((l) {
      emit(CourtCaseFromSearchError());
    }, (r) async {
      if (r.status == 200) {
        searchModel = r;

        emit(CourtCaseFromSearchSuccess());
      } else {
        errorGetBar(r.msg ?? '');
        emit(CourtCaseFromSearchError());
      }
    });
  }
  HomeLawyerModel? homeLawyerModel;

  Future<void> getHomeData() async {
    emit(HomeLawyerStateLoading());
    final res = await api.getHomeData();

    res.fold((l) {
      print("Error fetching home data: $l");
      emit(HomeLawyerStateError());
    }, (r) async {
      if (r.status == 200) {
        homeLawyerModel = r;
        print("Fetched home data: ${homeLawyerModel?.data?.toJson()}"); // تأكد من البيانات هنا
        emit(HomeLawyerStateSuccess());
      } else {
        print("Error in response: ${r.msg}");
        emit(HomeLawyerStateError());
      }
    });
  }

  // GetOfficeRequestModel? getOfficeRequestModel;
  // Future<void> getOfficeRequest() async {
  //   emit(GetOfficeRequestStateLoading());
  //   final res = await api.getOfficeRequest();
  //   res.fold((l) {
  //     emit(GetOfficeRequestStateError());
  //
  //   }, (r)  {
  //     getOfficeRequestModel = r;
  //       emit(GetOfficeRequestStateSuccess());
  //
  //   });
  // }
  Future<void> sendOfficeResponse(
  {
    required String requestId,
    required String status
}
      ) async {
    emit(GetOfficeRequestStateLoading());
    final res = await api.sendOfficeResponse(
        requestId: requestId, status: status);
    res.fold((l) {
      errorGetBar(l.toString());
      emit(GetOfficeRequestStateError());
    }, (r)  {
        successGetBar(r.msg ?? '');
        getHomeData();
        emit(GetOfficeRequestStateSuccess());


    });
  }
}
