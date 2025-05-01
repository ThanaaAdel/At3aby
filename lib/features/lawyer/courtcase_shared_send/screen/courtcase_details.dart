import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/exports.dart';
import '../../../../core/utils/custom_loading.dart';
import '../../../../core/widgets/appbar_with_image.dart';

import '../../../../core/widgets/image_view.dart';
import '../../../customer/contract_and_doc/data/model/contracts_model.dart';
import '../../../pdf_view/screen/pdf_view.dart';
import '../../issues_status/screen/issues_status.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../data/models/send_courtcase_details_model.dart';
import 'widget/header_of_courtcase.dart';

class CourtCaseDetailsSharedAndSendScreen extends StatefulWidget {
  const CourtCaseDetailsSharedAndSendScreen({super.key, required this.model});
  final CourtCaseDetailsSharedAndSendModel model;
  @override
  State<CourtCaseDetailsSharedAndSendScreen> createState() =>
      _CourtCaseDetailsSharedAndSendScreenState();
}

class _CourtCaseDetailsSharedAndSendScreenState
    extends State<CourtCaseDetailsSharedAndSendScreen> {
  @override
  void initState() {
    context
        .read<CourtcaseSharedandSendCubit>()
        .getDetailsOfCourtcase(widget.model.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourtcaseSharedandSendCubit,
        CourtcaseSharedandSendState>(
      builder: (context, state) {
        var cubit = context.read<CourtcaseSharedandSendCubit>();
        return Scaffold(
            body: Column(
          children: [
            // ! Appbar with Image
            AppbarContainImage(
              isLawyer: true,
              titleCenter: widget.model.title ?? '',
            ),
            state is LoadingGetDetailsOfTransferById
                ? Center(child: CustomLoadingIndicator())
                : Expanded(
                    child: SingleChildScrollView(
                      child: (state is LoadingGetDetailsOfTransferById)
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
                                10.h.verticalSpace,
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: HeaderOfCourtCaseWidget(
                                        isShared: false,
                                        model: cubit.getSharedCourtCaseByIdModel
                                            ?.data)),
                                10.h.verticalSpace,
                                _buildExistingIssueContent(
                                    cubit.currentIndex, cubit),
                              ],
                            ),
                    ),
                  ),

            SizedBox(height: 20.h),
          ],
        ));
      },
    );
  }

  /// Content for new issues (status == "جديدة")
  Widget _buildExistingIssueContent(
      int index, CourtcaseSharedandSendCubit cubit) {
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

  Widget _buildUpdatesSection(CourtcaseSharedandSendCubit cubit) {
    final updates = cubit.getSharedCourtCaseByIdModel?.data?.courtCase?.updates;
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
          List<UpdateDetailsData>? updatesList = updates[dateKey] ?? [];
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
                  UpdateDetailsData update = updatesList[index];
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

  /// Widget with detailed case view
  Widget _buildDetailedCaseView(CourtcaseSharedandSendCubit cubit) {
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
                        backgroundImage: NetworkImage(cubit
                                .getSharedCourtCaseByIdModel
                                ?.data
                                ?.courtCase
                                ?.client
                                ?.image ??
                            ''),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.getSharedCourtCaseByIdModel?.data?.courtCase
                                    ?.client?.name ??
                                '',
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
                                "${(cubit.getSharedCourtCaseByIdModel?.data?.courtCase?.client?.rates.toStringAsFixed(2)) ?? '0'} (${(cubit.getSharedCourtCaseByIdModel?.data?.courtCase?.client?.ratesCount ?? '0')})",
                                style: getRegularStyle(
                                  color: AppColors.blackLight,
                                  fontSize: 14.sp * textScaleFactor(context),
                                ),
                              ),
                              SizedBox(width: 5.w),
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
                  cubit.getSharedCourtCaseByIdModel?.data?.courtCase?.details ??
                      '',
                  style: getBoldStyle(
                      fontSize: 14.sp * textScaleFactor(context),
                      color: AppColors.gray),
                ),
              ],
            ),
          ),
        ),
        (cubit.getSharedCourtCaseByIdModel?.data?.courtCase?.files?.length == 0)
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
                                  itemCount: cubit.getSharedCourtCaseByIdModel
                                          ?.data?.courtCase?.files?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    var item = cubit.getSharedCourtCaseByIdModel
                                        ?.data?.courtCase?.files?[index];
                                    return InkWell(
                                      onTap: () {
                                        (item!.name!.contains('.png') ||
                                                item.name!.contains('.jpg'))
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageView(
                                                          image: item.file,
                                                          isAsset: false,
                                                        )))
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PDFViewScreen(
                                                            pdfModel:
                                                                PDFFileElement(
                                                          id: 1,
                                                          fileName:
                                                              item.name ?? '',
                                                          filePath: item.file,
                                                        ))));
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  item?.name ?? '',
                                                  style: getUnderLine(
                                                      color:
                                                          AppColors.primary)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ]))
                  ],
                ),
              ),
        20.verticalSpace,
      ],
    );
  }
}

class CourtCaseDetailsSharedAndSendModel {
  final int id;
  final String title;
  final bool isShared;
  CourtCaseDetailsSharedAndSendModel(
      {required this.id, required this.title, required this.isShared});
}
