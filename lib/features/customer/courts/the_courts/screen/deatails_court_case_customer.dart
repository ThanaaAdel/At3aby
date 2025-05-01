import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/customer/courts/the_courts/cubit/cubit.dart';
import 'package:ataaby/features/customer/courts/the_courts/cubit/state.dart';
import 'package:ataaby/features/customer/courts/the_courts/screen/widgets/connect_from_lawyer_or_cancel_order.dart';
import 'package:ataaby/features/lawyer/issues_status/screen/issues_status.dart';
import 'package:ataaby/features/pdf_view/screen/pdf_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/widgets/image_view.dart';
import '../../../contract_and_doc/data/model/contracts_model.dart';
import '../../add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';

class DetailsIssueCustomerScreen extends StatefulWidget {
  const DetailsIssueCustomerScreen({super.key, required this.id});

  final String id;

  @override
  State<DetailsIssueCustomerScreen> createState() => _DetailsIssueScreenState();
}

class _DetailsIssueScreenState extends State<DetailsIssueCustomerScreen> {
  @override
  void initState() {
    context.read<TheCourtsCustomerCubit>().getCourtDetailsData(id: widget.id);
    context.read<TheCourtsCustomerCubit>().getCancelReasons();
    context.read<TheCourtsCustomerCubit>().getFinishReasons(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TheCourtsCustomerCubit>();

    return Scaffold(
      body: Column(
        children: [
          AppbarContainImage(
            isLawyer: false,
            titleCenter: "details_issue".tr(),
          ),
          BlocBuilder<TheCourtsCustomerCubit, TheCourtsCustomerState>(
            builder: (context, state) {
              if (state is LoadingGetDetailsCourtData ||
                  state is LoadingCancelCourtCaseData ||
                  state is LoadingGetRefuseState ||
                  state is LoadingActionEventData ||
                  cubit.detailsCourtCase == null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CustomLoadingIndicator()],
                );
              }
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      (cubit.detailsCourtCase != null &&
                              cubit.detailsCourtCase!.data != null)
                          ? ConnectFromLawyerOrCancelOrder(
                              courtData: cubit.detailsCourtCase!.data!,
                            )
                          :
                          // Handle the null case
                          const Center(
                              child: Text(
                                  'No court data available'), // Or a loading spinner, etc.
                            ),
                      const SizedBox(height: 10),
                      _buildIssueDetails(cubit, state),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildIssueDetails(
      TheCourtsCustomerCubit cubit, TheCourtsCustomerState state) {
    if (cubit.detailsCourtCase?.data?.status == "new" ||
        cubit.detailsCourtCase?.data?.status == "private" &&
            (cubit.detailsCourtCase?.data?.eventStatus == "new" ||
                cubit.detailsCourtCase?.data?.eventStatus == "offer")) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailsSection(cubit),
          _buildAdditionalFilesSection(cubit),
          _buildLawyerOffers(cubit, state),
        ],
      );
    } else if (cubit.detailsCourtCase?.data?.status == 'offered' &&
        cubit.detailsCourtCase?.data?.eventStatus == "accepted") {
      return Column(
        children: [
          _buildDetailsSection(cubit),
          _buildAdditionalFilesSection(cubit),
        ],
      );
    } else
      return _buildUpdatesAndDetails(cubit);
  }

  Widget _buildDetailsSection(TheCourtsCustomerCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          boxShadow: customShadow,
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "details_issue".tr(),
              style: getBoldStyle(fontSize: 13.sp, color: AppColors.blackLight),
            ),
            const SizedBox(height: 10),
            Text(
              cubit.detailsCourtCase?.data?.details ?? "",
              style: getBoldStyle(
                  fontSize: 14.sp * textScaleFactor(context),
                  color: AppColors.gray),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalFilesSection(TheCourtsCustomerCubit cubit) {
    if (cubit.detailsCourtCase?.data?.files?.isEmpty ?? true) {
      return Container();
    }

    return Padding(
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
                  itemCount: cubit.detailsCourtCase?.data?.files?.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      (cubit.detailsCourtCase!.data!.files![index].name!
                                  .contains('.png') ||
                              cubit.detailsCourtCase!.data!.files![index].name!
                                  .contains('.jpg'))
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageView(
                                        image: cubit.detailsCourtCase?.data
                                            ?.files?[index].file,
                                        isAsset: false,
                                      )))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PDFViewScreen(
                                      pdfModel: PDFFileElement(
                                          id: 1,
                                          fileName: cubit.detailsCourtCase?.data
                                                  ?.files?[index].name ??
                                              '',
                                          filePath: cubit.detailsCourtCase?.data
                                              ?.files?[index].file))));
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
                                cubit.detailsCourtCase?.data?.files?[index]
                                        .name ??
                                    '',
                                style: getUnderLine(color: AppColors.primary)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // itemBuilder: (context, index) => InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => PDFViewScreen(
                  //           pdfModel: PdfFileModel(
                  //             id: 1,
                  //             name: cubit.detailsCourtCase?.data?.files?[index]
                  //                     .name ??
                  //                 "",
                  //             price: 1,
                  //             pdfLink: cubit.detailsCourtCase?.data
                  //                     ?.files?[index].file ??
                  //                 "",
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       children: [
                  //         SvgPicture.asset(ImageAssets.fileIcon),
                  //         const SizedBox(width: 10),
                  //         Text(
                  //           cubit.detailsCourtCase?.data?.files?[index].name ??
                  //               "",
                  //           style: getUnderLine(
                  //               color: AppColors.primary, fontSize: 13),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLawyerOffers(
      TheCourtsCustomerCubit cubit, TheCourtsCustomerState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Text(
            cubit.detailsCourtCase?.data?.allEvents?.length == 0
                ? ""
                : "lawyers_offers".tr(),
            style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView.builder(
            itemCount: cubit.detailsCourtCase?.data?.allEvents?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                _buildLawyerOfferItem(cubit, index, state),
          ),
        ),
      ],
    );
  }

  Widget _buildLawyerOfferItem(
      TheCourtsCustomerCubit cubit, int index, TheCourtsCustomerState state) {
    return SizedBox(
      width: getWidthSize(context) * 2 / 2.3,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 35.h),
            padding: EdgeInsets.all(8.sp * textScaleFactor(context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.white,
              boxShadow: customShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPriceSection(cubit, index),
                Text(
                  cubit.detailsCourtCase?.data?.allEvents?[index].lawyerName ??
                      "",
                  style: getRegularStyle(
                    fontSize: 14.sp * textScaleFactor(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      cubit.detailsCourtCase?.data?.allEvents?[index]
                              .lawyerLevel ??
                          "",
                      style: getBoldStyle(
                        color: AppColors.gray,
                        fontSize: 14.sp * textScaleFactor(context),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${cubit.detailsCourtCase?.data?.allEvents?[index].avgRate}(${cubit.detailsCourtCase?.data?.allEvents?[index].rateCount})",
                          style: getRegularStyle(
                            color: AppColors.gray,
                            fontSize: 14.sp * textScaleFactor(context),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.star,
                          color: AppColors.yellow,
                          size: 10.sp * textScaleFactor(context),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                (state is LoadingActionEventData)
                    ? Center(child: CustomLoadingIndicator())
                    : Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onTap: () {
                                cubit.actionEvent(
                                    status: "accepted",
                                    courtCaseEventId: cubit.detailsCourtCase!
                                            .data!.allEvents![index].id ??
                                        0,
                                    id: widget.id);
                              },
                              color: AppColors.primary,
                              widget: Center(
                                child: Text(
                                  "accept".tr(),
                                  style: getRegularStyle(
                                    color: AppColors.white,
                                    fontSize: 14.sp * textScaleFactor(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              onTap: () {
                                cubit.actionEvent(
                                    status: "rejected",
                                    courtCaseEventId: cubit.detailsCourtCase!
                                            .data!.allEvents![index].id ??
                                        0,
                                    id: widget.id);
                              },
                              color: AppColors.white,
                              border: Border.all(color: AppColors.redLight),
                              widget: Center(
                                child: Text(
                                  "reject".tr(),
                                  style: getRegularStyle(
                                    color: AppColors.red,
                                    fontSize: 14.sp * textScaleFactor(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          PositionedDirectional(
            start: 12.w,
            child: CircleAvatar(
              radius: 30.r,
              backgroundColor: AppColors.transparent,
              child: Image.network(
                  cubit.detailsCourtCase?.data?.allEvents?[index].lawyerImage ??
                      ""),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(TheCourtsCustomerCubit cubit, int index) {
    return Container(
      alignment: (EasyLocalization.of(context)!.locale.languageCode == 'ar')
          ? Alignment.topLeft
          : Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            cubit.detailsCourtCase?.data?.allEvents?[index].price.toString() ??
                "",
            style: getBoldStyle(
              color: AppColors.greenLight,
              fontSize: 20.sp * textScaleFactor(context),
            ),
          ),
          Text(
            "egp".tr(),
            style: getBoldStyle(
              color: AppColors.black,
              fontSize: 14.sp * textScaleFactor(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdatesAndDetails(TheCourtsCustomerCubit cubit) {
    return Column(
      children: [
        IssueStatus(
          onTap: cubit.detailsCourtCaseChangeIndex,
          currentIndex: cubit.detailsCourtCaseCurrentIndex,
          titles: ["updates_issue".tr(), "details_issue".tr()],
        ),
        cubit.detailsCourtCaseCurrentIndex == 0
            ? _buildUpdatesSection(cubit)
            : _buildDetailsAndClientSection(cubit),
      ],
    );
  }

  Widget _buildUpdatesSection(TheCourtsCustomerCubit cubit) {
    final updates = cubit.detailsCourtCase?.data?.updates;
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

  Widget _buildDetailsAndClientSection(TheCourtsCustomerCubit cubit) {
    return Column(
      children: [
        _buildDetailsSection(cubit),
        _buildAdditionalFilesSection(cubit),
        const SizedBox(height: 20),
      ],
    );
  }
}
