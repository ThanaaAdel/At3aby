import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/core/widgets/image_view.dart';
import 'package:ataaby/features/lawyer/details_issue/cubit/details_issue_state.dart';
import 'package:ataaby/features/lawyer/details_issue/screen/widgets/accept_and_reject_issue.dart';
import 'package:ataaby/features/lawyer/home_lawyer/data/model/home_Laywer_model.dart';
import 'package:ataaby/features/lawyer/issues_status/screen/issues_status.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_popup/flutter_popup.dart';
import '../../../customer/contract_and_doc/data/model/contracts_model.dart';
import '../../../customer/courts/add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';
import '../../../pdf_view/screen/pdf_view.dart';
import '../../add_new_update/data/model/model.dart';
import '../cubit/details_issue_cubit.dart';

class DetailsIssueScreen extends StatefulWidget {
  const DetailsIssueScreen({super.key, required this.newCourtCase});
  final NewCourtCase newCourtCase;

  @override
  State<DetailsIssueScreen> createState() => _DetailsIssueScreenState();
}

class _DetailsIssueScreenState extends State<DetailsIssueScreen> {
  @override
  initState() {
    super.initState();
    context
        .read<DetailsIssueCubit>()
        .getCourtById(context, id: widget.newCourtCase.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsIssueCubit, DetailsIssueState>(
      builder: (context, state) {
        var cubit = context.read<DetailsIssueCubit>();

        return Scaffold(
          body: Column(
            children: [
              // ! Appbar with Image
              AppbarContainImage(
                widget: CustomPopup(
                  showArrow: true,
                  arrowColor: Colors.white,
                  backgroundColor: Colors.white,
                  content: SizedBox(
                    // height: getHeightSize(context) / 2,
                    width: getWidthSize(context) / 2,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.sendIssueFromLawyerOrSubscribeRoute,
                              arguments: {
                                'sendFromAnotherLawyer': false,
                                'courtData': cubit.getCourtCaseByIdModel?.data,
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "new_lawyer_in_case".tr(),
                                    style: getBoldStyle(
                                        fontSize:
                                            14.sp * textScaleFactor(context),
                                        color: AppColors.blackLight),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.sendIssueFromLawyerOrSubscribeRoute,
                              arguments: {
                                'sendFromAnotherLawyer': true,
                                'courtData': cubit.getCourtCaseByIdModel?.data,
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0.h),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "send_case_to_other_lawyer".tr(),
                                    style: getBoldStyle(
                                        fontSize:
                                            14.sp * textScaleFactor(context),
                                        color: AppColors.blackLight),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  child: cubit.getCourtCaseByIdModel?.data?.status != "new"
                      ? Icon(
                          Icons.more_vert_sharp,
                          color: AppColors.white,
                        )
                      : const SizedBox(),
                ),
                isLawyer: true,
                titleCenter: "details_issue".tr(),
              ),
              // ! Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: (state is GetCourtByIdLoading ||
                          cubit.getCourtCaseByIdModel == null)
                      ? SizedBox(
                          height: getHeightSize(context) / 1.5,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: CustomLoadingIndicator()),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            //! STATUS OF ISSUE
                            AcceptAndRejectIssue(
                              getCourtCaseByIdModel:
                                  cubit.getCourtCaseByIdModel!,
                            ),
                            SizedBox(height: 10.h),
                            // Conditionally Render Content Based on Status
                            (cubit.getCourtCaseByIdModel?.data?.status ==
                                        "new" ||
                                    cubit.getCourtCaseByIdModel?.data?.status ==
                                        "private")
                                ? _buildDetailedCaseView(cubit)
                                : _buildExistingIssueContent(
                                    cubit.currentIndex, cubit),
                          ],
                        ),
                ),
              ),
              (state is GetCourtByIdLoading ||
                      cubit.getCourtCaseByIdModel == null)
                  ? Container()
                  : (cubit.getCourtCaseByIdModel?.data?.status == "new" ||
                          cubit.getCourtCaseByIdModel?.data?.status ==
                              "private" ||
                          cubit.getCourtCaseByIdModel?.data?.status ==
                              "offered")
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: CustomButton(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.addNewUpdateRoute,
                                  arguments: UpdateCourtCaseModel(
                                      courtid: cubit
                                          .getCourtCaseByIdModel?.data?.id
                                          ?.toString(),
                                      isUpdate: false,
                                      updateid: ''),
                                );
                              },
                              widget: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                    size: 15.sp,
                                  ),
                                  Text(
                                    "add_new_update".tr(),
                                    style: getRegularStyle(
                                        fontSize: 15.sp,
                                        color: AppColors.white),
                                  )
                                ],
                              )),
                        ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  /// Content for new issues (status == "جديدة")
  Widget _buildExistingIssueContent(int index, DetailsIssueCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IssueStatus(
          onTap: cubit.changeIndex,
          currentIndex: index,
          titles: ["updates_issue".tr(), "details_issue".tr()],
        ),
        index == 0 ? _buildUpdatesSection(cubit) : _buildDetailedCaseView(cubit)
      ],
    );
  }

  /// Widget displayed when there are no updates
  Widget _noUpdatesWidget() {
    return Column(
      children: [
        SizedBox(height: 70.h),
        SvgPicture.asset(ImageAssets.noUpdateIcon),
        SizedBox(height: 10.h),
        Text(
          "no_updates".tr(),
          style: getRegularStyle(color: AppColors.gray),
        ),
      ],
    );
  }

  /// Widget with detailed case view
  Widget _buildDetailedCaseView(DetailsIssueCubit cubit) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: customShadow,
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Text(
                      "the_client_of_the_case".tr(),
                      style: getRegularStyle(color: AppColors.blackLight),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25.sp,
                        backgroundColor: AppColors.white,
                        backgroundImage: NetworkImage(
                            cubit.getCourtCaseByIdModel?.data?.client?.image ??
                                ""),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.getCourtCaseByIdModel?.data?.client?.name ??
                                "",
                            style: getRegularStyle(
                              color: AppColors.blackLight,
                              fontSize: 14.sp * textScaleFactor(context),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ///// const rate //////
                              Text(
                                "${cubit.getCourtCaseByIdModel?.data?.client?.rates ?? '0'} (${cubit.getCourtCaseByIdModel?.data?.client?.ratesCount ?? '0'})",
                                style: getRegularStyle(
                                  color: AppColors.blackLight,
                                  fontSize: 14.sp * textScaleFactor(context),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.yellow,
                                size: 14.sp * textScaleFactor(context),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(12.sp),
            alignment: AlignmentDirectional.centerStart,
            decoration: BoxDecoration(
              boxShadow: customShadow,
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "details_issue".tr(),
                  style: getBoldStyle(
                      fontSize: 13.sp, color: AppColors.blackLight),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  cubit.getCourtCaseByIdModel?.data?.details ?? "",
                  style: getBoldStyle(
                      fontSize: 14.sp * textScaleFactor(context),
                      color: AppColors.gray),
                ),
              ],
            ),
          ),
        ),
        cubit.getCourtCaseByIdModel?.data?.files?.length == 0
            ? Container()
            : Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          boxShadow: customShadow,
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'additional_files'.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cubit.getCourtCaseByIdModel?.data
                                        ?.files?.length ??
                                    0,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    (cubit.getCourtCaseByIdModel!.data!
                                                .files![index].name!
                                                .contains('.png') ||
                                            cubit.getCourtCaseByIdModel!.data!
                                                .files![index].name!
                                                .contains('.jpg'))
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ImageView(
                                                      image: cubit
                                                          .getCourtCaseByIdModel
                                                          ?.data
                                                          ?.files?[index]
                                                          .file,
                                                      isAsset: false,
                                                    )))
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PDFViewScreen(
                                                    pdfModel: PDFFileElement(
                                                        id: 1,
                                                        fileName: cubit
                                                                .getCourtCaseByIdModel
                                                                ?.data
                                                                ?.files?[index]
                                                                .name ??
                                                            '',
                                                        filePath: cubit
                                                            .getCourtCaseByIdModel
                                                            ?.data
                                                            ?.files?[index]
                                                            .file))));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          ImageAssets.fileIcon,
                                        ),
                                        SizedBox(width: 10.w),
                                        SizedBox(
                                          width: 250.w,
                                          child: AutoSizeText(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              cubit.getCourtCaseByIdModel?.data
                                                      ?.files?[index].name ??
                                                  '',
                                              style: getUnderLine(
                                                  color: AppColors.primary)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]))
                  ],
                ),
              ),
        20.verticalSpace,
      ],
    );
  }

  Widget _buildUpdatesSection(DetailsIssueCubit cubit) {
    final updates = cubit.getCourtCaseByIdModel?.data?.updates;
    if (updates == null || updates.isEmpty) {
      return Column(
        children: [
          SizedBox(height: 70.h),
          SvgPicture.asset(ImageAssets.noUpdateIcon),
          SizedBox(height: 10.h),
          Text(
            "no_updates".tr(),
            style: getRegularStyle(color: AppColors.gray),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: updates.keys.length,
        itemBuilder: (context, updateIndex) {
          String dateKey = updates.keys.elementAt(updateIndex);
          List<CourtCaseUpdate>? updatesList = updates[dateKey] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عرض التاريخ في أعلى كل مجموعة تحديثات
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: AppColors.greenLight,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      dateKey,
                      style: getRegularStyle(
                          color: AppColors.white, fontSize: 13.sp),
                    ),
                  ),
                ),
              ),

              // عرض تفاصيل كل تحديث
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: updatesList.length,
                itemBuilder: (context, index) {
                  CourtCaseUpdate update = updatesList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(ImageAssets.dateIcon),
                                  const SizedBox(width: 5),
                                  Text(
                                    update.date?.toString() ?? "-",
                                    style: getRegularStyle(
                                        color: AppColors.gray, fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            update.title ?? "",
                            style: getBoldStyle(
                                color: AppColors.blackLight, fontSize: 14.sp),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            update.details ?? "",
                            style: getRegularStyle(
                                color: AppColors.gray, fontSize: 14.sp),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: customShadow,
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12.sp),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (update.files == null ||
                                              update.files!.isEmpty)
                                          ? const SizedBox()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'additional_files'.tr(),
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: update.files?.length ?? 0,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            (update.files![index].name!
                                                        .contains('.png') ||
                                                    update.files![index].name!
                                                        .contains('.jpg'))
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ImageView(
                                                              image: update
                                                                  .files![index]
                                                                  .file,
                                                              isAsset: false,
                                                            )))
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => PDFViewScreen(
                                                            pdfModel: PDFFileElement(
                                                                id: 1,
                                                                fileName: update
                                                                        .files![
                                                                            index]
                                                                        .name ??
                                                                    '',
                                                                filePath: update
                                                                    .files![
                                                                        index]
                                                                    .file))));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  ImageAssets.fileIcon,
                                                ),
                                                SizedBox(width: 10.w),
                                                Flexible(
                                                  child: Text(
                                                      update.files![index]
                                                              .name ??
                                                          '',
                                                      maxLines: 1,
                                                      style: getUnderLine(
                                                          color: AppColors
                                                              .primary)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
