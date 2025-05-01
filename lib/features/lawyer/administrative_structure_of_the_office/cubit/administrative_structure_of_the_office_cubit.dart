import 'package:ataaby/app.dart';
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/cubit/Sos_lawyers_cubit.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_state.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/data/model/get_office_team_model.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/data/model/search_lawyer_model.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/data/repo/administrative_structure_of_the_office_repo.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../data/model/all-lawyers-model.dart';
import '../data/model/get_lawyers_general_model.dart';

class AdministrativeStructureOfTheOfficeCubit
    extends Cubit<AdministrativeStructureOfTheOfficeState> {
  AdministrativeStructureOfTheOfficeCubit(
      this.administrativeStructureOfTheOfficeRepo)
      : super(AdministrativeStructureOfTheOfficeInitial());

  AdministrativeStructureOfTheOfficeRepo administrativeStructureOfTheOfficeRepo;
  TextEditingController nameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController identificationNumberController =
      TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController lawyerMembershipNumberController =
      TextEditingController();

  GetOfficeTeamModel? getOfficeTeamModel;
  void getOfficeTeamData() async {
    emit(LoadingOfficeTeamDataState());
    final res =
        await administrativeStructureOfTheOfficeRepo.getOfficeTeamData();
    res.fold((l) {
      emit(ErrorOfficeTeamDataState());
    }, (r) {
      getOfficeTeamModel = r;
      emit(SuccessOfficeTeamDataState());
    });
  }

  GetLawyersGeneralModel? getLawyersGeneralModel;
  void getAllLawyersFromSendAndSubscription() async {
    emit(LoadingAllLawyersState());
    final res = await administrativeStructureOfTheOfficeRepo
        .getAllLawyersFromSendAndSubscription();
    res.fold((l) {
      emit(ErrorAllLawyersState());
    }, (r) {
      getLawyersGeneralModel = r;
      emit(SuccessAllLawyersState());
    });
  }

/*
  TextEditingController priceInTheCaseController = TextEditingController();
  TextEditingController descInTheCaseController = TextEditingController();
  DefaultMainModel? defaultMainModel;
  addLawyerToCourtCaseRequest(
      {required String lawyerId,
      required String courtCaseId,
      required String price}) async {
    emit(LoadingAddLawyerToCourtCaseRequestDataState());

    //!start

    final res = await administrativeStructureOfTheOfficeRepo
        .addLawyerToCourtCaseRequest(
            lawyerId: lawyerId,
            courtCaseId: courtCaseId,
            price: priceInTheCaseController.text,
            describtion: descInTheCaseController.text);
    res.fold((l) {
      errorGetBar(l.toString() ?? '');
      emit(ErrorAddLawyerToCourtCaseRequestDataState());
    }, (r) {
      defaultMainModel = r;
      successGetBar(r.msg ?? '');
      emit(SuccessAddLawyerToCourtCaseRequestDataState());
    });

    //!end
  }
*/
// Method to show the dialog for entering price and description
  void showAddLawyerDialog(
    BuildContext context, {
    required String lawyerId,
    required String courtCaseId,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'new_lawyer_in_case'.tr(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                hintText: 'price'.tr(),
                titleFromTextFormField: 'price'.tr(),
                controller: priceInTheCaseController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'detailed_description_of_the_case'.tr(),
                titleFromTextFormField: 'detailed_description_of_the_case'.tr(),
                controller: descInTheCaseController,
              ),
            ],
          ),
          actions: [
            CustomButton(
              paddingButton: EdgeInsets.only(
                top: 5.h,
                bottom: 5.h,
                right: 20.w,
                left: 20.w,
              ),
              color: AppColors.white,
              widget: Text('cancel'.tr()),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            CustomButton(
              paddingButton: EdgeInsets.only(
                top: 5.h,
                bottom: 5.h,
                right: 20.w,
                left: 20.w,
              ),
              color: AppColors.primary,
              onTap: () {
                String price = priceInTheCaseController.text.trim();
                String description = descInTheCaseController.text.trim();

                if (price.isEmpty || description.isEmpty) {
                  errorGetBar('Please enter both price and description.');
                  return;
                }

                addLawyerToCourtCaseRequest(
                  context,
                  lawyerId: lawyerId,
                  courtCaseId: courtCaseId,
                );

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              widget: Text(
                'confirm'.tr(),
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

// Original method to handle the request
  TextEditingController priceInTheCaseController = TextEditingController();
  TextEditingController descInTheCaseController = TextEditingController();
  DefaultMainModel? defaultMainModel;

  void addLawyerToCourtCaseRequest(BuildContext context,
      {required String lawyerId, required String courtCaseId}) async {
    emit(LoadingAddLawyerToCourtCaseRequestDataState());

    //!start
    final res = await administrativeStructureOfTheOfficeRepo
        .addLawyerToCourtCaseRequest(
      lawyerId: lawyerId,
      courtCaseId: courtCaseId,
      price: priceInTheCaseController.text,
      describtion: descInTheCaseController.text,
    );
    res.fold((l) {
      errorGetBar('error'.tr());
      emit(ErrorAddLawyerToCourtCaseRequestDataState());
    }, (r) {
      successGetBar(r.msg ?? '');
      priceInTheCaseController.clear();
      descInTheCaseController.clear();

      emit(SuccessAddLawyerToCourtCaseRequestDataState());
    });

    //!end
  }

  // send to anather lawyer
  void sendOfficeRequestToAnatherLawyer(
      {required String courtCaseId, required String transfareLawyerId}) async {
    emit(LoadingAddLawyerToCourtCaseRequestDataState());
    final res = await administrativeStructureOfTheOfficeRepo
        .sendOfficeRequestToAnatherLawyer(
      transfareLawyerId: transfareLawyerId,
      courtCaseId: courtCaseId,
    );
    res.fold((l) {
      errorGetBar(l.toString() ?? '');
      emit(ErrorAddLawyerToCourtCaseRequestDataState());
    }, (r) {
      defaultMainModel = r;
      successGetBar(r.msg ?? '');
      emit(SuccessAddLawyerToCourtCaseRequestDataState());
    });
  }

  void deleteLawyerFromOffice({required String id}) async {
    emit(LoadingDeleteLawyerFromOfficeState());
    final res = await administrativeStructureOfTheOfficeRepo
        .deleteLawyerFromOffice(id: id);
    res.fold((l) {
      errorGetBar(l.toString());
      emit(ErrorDeleteLawyerFromOfficeState());
    }, (r) {
      successGetBar(r.msg.toString());
      defaultMainModel = r;
      getOfficeTeamData();
      emit(SuccessDeleteLawyerFromOfficeState());
    });
  }

  void sendOfficeRequest({required String lawyerId}) async {
    emit(LoadingSendOfficeRequestState());
    final res = await administrativeStructureOfTheOfficeRepo.sendOfficeRequest(
      lawyerId: lawyerId,
    );
    res.fold((l) {
      errorGetBar(l.toString() ?? '');
      emit(ErrorSendOfficeRequestState());
    }, (r) {
      successGetBar(r.msg ?? '');
      searchController.clear();
      searchLawyerModel = null;
      emit(SuccessSendOfficeRequestState());
    });
  }

  SearchLawyerModel? searchLawyerModel;
  Future<void> searchLawyerData({required int lawyerId}) async {
    emit(LoadingSearchLawyerDataState());
    final res = await administrativeStructureOfTheOfficeRepo.searchLawyerData(
      lawyerId: lawyerId,
    );
    res.fold((l) {
      errorGetBar(l.toString() ?? '');
      emit(ErrorSearchLawyerDataState());
    }, (r) {
      searchLawyerModel = r;
      emit(SuccessSearchLawyerDataState());
    });
  }
}
