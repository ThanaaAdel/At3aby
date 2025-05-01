import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/search_text_field.dart';
import 'package:ataaby/features/lawyer/current_issues/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/current_issues/cubit/state.dart';
import 'package:ataaby/features/lawyer/home_lawyer/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/issues_status/screen/issues_status.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/custom_issue.dart';
import '../../home_lawyer/screen/filter_of_lawyer.dart';
import '../../sos_details/sos_details.dart';
import 'widget/sos_court.dart';

class CurrentIssuesScreen extends StatefulWidget {
  const CurrentIssuesScreen({super.key});

  @override
  State<CurrentIssuesScreen> createState() => _CurrentIssuesScreenState();
}

class _CurrentIssuesScreenState extends State<CurrentIssuesScreen> {
  @override
  void initState() {
    context.read<CurrentIssuesCubit>().searchController.clear();
    context.read<CurrentIssuesCubit>().changeIndex(0);
    super.initState();
  }

  @override
  void dispose() {
    EasyDebounce.cancel('mycurrent-cases-debouncer');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CurrentIssuesCubit, CurrentIssuesState>(
        builder: (context, state) {
          var cubit = context.read<CurrentIssuesCubit>();
          var cubit2 = context.read<HomeLawyerCubit>();

          return RefreshIndicator(
            onRefresh: () async {
              await cubit.getMyCourtCases(
                  specialityId: cubit.currentIndex == 0
                      ? cubit2.selectedSpecialization?.id.toString()
                      : null,
                  status: cubit.currentIndex == 0
                      ? 'accepted '
                      : cubit.currentIndex == 10
                          ? "finished"
                          : "sos");
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      ImageAssets.smallAppbarImage,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.0.h, top: 30.0.h, right: 5.w, left: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            ImageAssets.coloredLogoImage,
                            height: 60.h,
                            width: 60.w,
                            color: AppColors.white,
                          ),
                          Text(
                            "current_issues".tr(),
                            style: getRegularStyle(color: AppColors.white),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.chatRoom,
                                      arguments: true);
                                },
                                child: SvgPicture.asset(
                                  ImageAssets.messageIcon,
                                  color: AppColors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.notificationRoute,
                                      arguments: true);
                                },
                                child: SvgPicture.asset(
                                  ImageAssets.notificationIcon,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                IssueStatus(
                  onTap: cubit.changeIndex,
                  currentIndex: cubit.currentIndex,
                  titles: [
                    "current_issues".tr(),
                    "ended_issues".tr(),
                    "Distress_issues".tr()
                  ],
                ),
                Flexible(
                  child: cubit.currentIndex == 0
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 0.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.h.verticalSpace,
                              SearchTextField(
                                  controller: cubit.searchController,
                                  onChanged: (v) async {
                                    EasyDebounce.debounce(
                                        'mycurrent-cases-debouncer',
                                        const Duration(seconds: 1),
                                        () async =>
                                            //!cubit.searchController
                                            await cubit.getMyCourtCases(
                                                specialityId: cubit
                                                            .currentIndex ==
                                                        0
                                                    ? cubit2
                                                        .selectedSpecialization
                                                        ?.id
                                                        .toString()
                                                    : null,
                                                status: cubit.currentIndex == 0
                                                    ? 'accepted '
                                                    : cubit.currentIndex == 10
                                                        ? "finished"
                                                        : "sos"));
                                  },
                                  hintText: "search_from_issue".tr(),
                                  suffixIcon: _buildSearchSuffixIcon(),
                                  prefixIcon: _buildSearchPrefixIcon()),
                              if (cubit2.selectedSpecialization != null)
                                Chip(
                                  label: Text(cubit2
                                          .selectedSpecialization?.title
                                          ?.toString() ??
                                      ''),
                                  backgroundColor: AppColors.white,
                                  shadowColor: AppColors.white,
                                  side: BorderSide(
                                    color: AppColors.grayLite3Color,
                                    width: 1,
                                  ),
                                  deleteIconColor: AppColors.red,
                                  onDeleted: () {
                                    cubit2.selectedSpecialization = null;
                                    cubit.changeIndex(0);
                                  },
                                ),
                              Flexible(
                                child: (state
                                        is LoadingGetMyCourtCasesStateState)
                                    ? Center(
                                        child: CustomLoadingIndicator(),
                                      )
                                    : cubit.mainMyCourtCasesModel?.data
                                                ?.length ==
                                            0
                                        ? Center(
                                            child: Text('no_data'.tr(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      AppColors.secondPrimary,
                                                )),
                                          )
                                        : ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: cubit
                                                .mainMyCourtCasesModel
                                                ?.data
                                                ?.length,
                                            shrinkWrap: true,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (context, index) =>
                                                Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10.h, bottom: 10.h),
                                              child: CustomHomeIssue(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      Routes
                                                          .detailsIssueLawyerRoute,
                                                      arguments: cubit
                                                          .mainMyCourtCasesModel
                                                          ?.data?[index]);
                                                },
                                                newCourtCase: cubit
                                                    .mainMyCourtCasesModel
                                                    ?.data?[index],
                                              ),
                                            ),
                                          ),
                              ),
                            ],
                          ),
                        )
                      : cubit.currentIndex == 1
                          ? (state is LoadingGetMyCourtCasesStateState)
                              ? Center(
                                  child: CustomLoadingIndicator(),
                                )
                              : cubit.mainMyCourtCasesModel?.data?.length == 0
                                  ? Center(
                                      child: Text('no_data'.tr(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.secondPrimary,
                                          )),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: cubit.mainMyCourtCasesModel
                                            ?.data?.length,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: CustomHomeIssue(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.detailsIssueLawyerRoute,
                                                arguments: cubit
                                                    .mainMyCourtCasesModel
                                                    ?.data?[index],
                                              );
                                            },
                                            newCourtCase: cubit
                                                .mainMyCourtCasesModel
                                                ?.data?[index],
                                          ),
                                        ),
                                      ),
                                    )
                          : (state is LoadingGetMyCourtCasesStateState)
                              ? Center(
                                  child: CustomLoadingIndicator(),
                                )
                              : cubit.mainSosCourtCasesModel?.data?.length == 0
                                  ? Center(
                                      child: Text(
                                        'no_data'.tr(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondPrimary,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: cubit
                                              .mainSosCourtCasesModel
                                              ?.data
                                              ?.length,
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var item = cubit
                                                .mainSosCourtCasesModel
                                                ?.data?[index];
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SosCourCaseDetails(
                                                              sosCourCaseDetails:
                                                                  item,
                                                            )),
                                                  );
                                                },
                                                child: SosCartWidget(
                                                  sosCourt: item,
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchSuffixIcon() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FilterLawyerScreen(
                      screenName: 'current_issue',
                      onTap: () {
                        var cubit = context.read<CurrentIssuesCubit>();
                        var cubit2 = context.read<HomeLawyerCubit>();
                        if (cubit.currentIndex == 0) {
                          cubit.getMyCourtCases(
                            status: 'accepted',
                            specialityId:
                                cubit2.selectedSpecialization?.id.toString() ??
                                    '',
                          );
                        }
                        Navigator.pop(context);
                      },
                    )));
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
}
