import 'dart:developer';

import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/courts/the_courts/data/models/court_case_model.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_cubit.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_state.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/screens/widgets/lawyer_information_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/appbar_with_image.dart';
import '../../../../core/widgets/search_text_field.dart';
import '../../../customer/courts/add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';
import '../../home_lawyer/screen/filter_of_lawyer.dart';

class SendIssueFromLawyerOrSubscribeScreen extends StatefulWidget {
  const SendIssueFromLawyerOrSubscribeScreen(
      {super.key,
      required this.sendFromAnatherLawyer,
      required this.courtData});
  final bool sendFromAnatherLawyer;
  final CourtData courtData;
  @override
  State<SendIssueFromLawyerOrSubscribeScreen> createState() =>
      _SendIssueFromLawyerOrSubscribeScreenState();
}

class _SendIssueFromLawyerOrSubscribeScreenState
    extends State<SendIssueFromLawyerOrSubscribeScreen> {
  @override
  initState() {
    super.initState();

    context.read<AdministrativeStructureOfTheOfficeCubit>().getOfficeTeamData();
    context
        .read<AdministrativeStructureOfTheOfficeCubit>()
        .getAllLawyersFromSendAndSubscription();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AdministrativeStructureOfTheOfficeCubit>();
    return Scaffold(
      body: BlocBuilder<AdministrativeStructureOfTheOfficeCubit,
          AdministrativeStructureOfTheOfficeState>(builder: (context, state) {
        return Column(
          children: [
            AppbarContainImage(
              isLawyer: true,
              titleCenter: widget.sendFromAnatherLawyer
                  ? "send_case_to_other_lawyer".tr()
                  : "new_lawyer_in_case".tr(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      SearchTextField(
                        controller: cubit.searchController,
                        hintText: "search_from_issue".tr(),
                        suffixIcon: _buildSearchSuffixIcon(context),
                        prefixIcon: _buildSearchPrefixIcon(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(
                          "list_of_lawyers_in_the_office".tr(),
                          style: getRegularStyle(
                            fontSize: 14.sp * textScaleFactor(context),
                          ),
                        ),
                      ),
                      (cubit.getOfficeTeamModel?.data?.team?.length == 0)
                          ? Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: Center(
                                child: Text("no_lawyer".tr()),
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) =>
                                  LawyerInformationWidget(
                                onTapSelected: () {
                                  // ارسال القضية لمحامي اخر
                                  widget.sendFromAnatherLawyer
                                      ? cubit.sendOfficeRequestToAnatherLawyer(
                                          courtCaseId:
                                              widget.courtData.id.toString() ??
                                                  "",
                                          transfareLawyerId: cubit
                                                  .getOfficeTeamModel
                                                  ?.data
                                                  ?.team?[index]
                                                  .id
                                                  .toString() ??
                                              "",
                                        )
                                      :
                                      // اشراك قضية الي محامي اخر
                                      cubit.showAddLawyerDialog(
                                          context,
                                          lawyerId: cubit.getOfficeTeamModel
                                                  ?.data?.team?[index].id
                                                  .toString() ??
                                              "",
                                          courtCaseId:
                                              widget.courtData.id.toString() ??
                                                  "",
                                        );
                                },
                                id: cubit.getOfficeTeamModel!.data!.team![index]
                                        .id ??
                                    0,
                                cubit: cubit,
                                searchLawyerModelData:
                                    cubit.getOfficeTeamModel!.data!.office!,
                                type: "select",
                              ),
                              itemCount: cubit
                                      .getOfficeTeamModel?.data?.team?.length ??
                                  0,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Text(
                          "list_of_lawyers".tr(),
                          style: getRegularStyle(
                            fontSize: 14.sp * textScaleFactor(context),
                          ),
                        ),
                      ),
                      (cubit.getLawyersGeneralModel?.data?.lawyers?.length == 0)
                          ? Center(
                              child: Text("no_lawyer".tr()),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) =>
                                  LawyerInformationWidget(
                                onTapSelected: () {
                                  // ارسال القضية لمحامي اخر
                                  widget.sendFromAnatherLawyer
                                      ? cubit.sendOfficeRequestToAnatherLawyer(
                                          courtCaseId:
                                              widget.courtData.id.toString() ??
                                                  "",
                                          transfareLawyerId: cubit
                                                  .getLawyersGeneralModel
                                                  ?.data
                                                  ?.lawyers?[index]
                                                  .id
                                                  .toString() ??
                                              "",
                                        )
                                      :

                                      // اشراك قضية الي محامي اخر
                                      cubit.showAddLawyerDialog(context,
                                          lawyerId: cubit.getLawyersGeneralModel
                                                  ?.data?.lawyers?[index].id
                                                  .toString() ??
                                              "",
                                          courtCaseId:
                                              widget.courtData.id.toString());
                                },
                                id: cubit.getLawyersGeneralModel?.data
                                        ?.lawyers?[index].id ??
                                    0,
                                cubit: cubit,
                                type: "select",
                                searchLawyerModelData: cubit
                                    .getLawyersGeneralModel!
                                    .data!
                                    .lawyers![index],
                              ),
                              itemCount: cubit.getLawyersGeneralModel?.data
                                      ?.lawyers?.length ??
                                  0,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(
            //       top: 10.0.h, bottom: 10.h, right: 10.w, left: 10.w),
            //   child: CustomButton(
            //       onTap: () {
            //         log('0000000 ${"new_lawyer_in_case".tr()}');
            //         //!
            //       },
            //       widget: Center(
            //         child: Text(
            //           widget.sendFromAnatherLawyer
            //               ? "send_case_to_other_lawyer".tr()
            //               : "new_lawyer_in_case".tr(),
            //           style: getRegularStyle(
            //             color: AppColors.white,
            //             fontSize: 14.sp * textScaleFactor(context),
            //           ),
            //         ),
            //       )),
            // )
          ],
        );
      }),
    );
  }
}

Widget _buildSearchSuffixIcon(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FilterLawyerScreen(
                  screenName: 'send_issue_from_lawyer_or_subscribe_screen')));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
          color: AppColors.greenLight,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(ImageAssets.candleIcon),
        ),
      ),
    ),
  );
}

Widget _buildSearchPrefixIcon() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SvgPicture.asset(ImageAssets.searchIcon),
  );
}
