import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/details_lawyer_from_customer/cubit/details_lawyer_from_customer_partener_cubit.dart';
import 'package:ataaby/features/customer/details_lawyer_from_customer/cubit/details_lawyer_from_customer_partener_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_popup/flutter_popup.dart';
import '../../../../core/widgets/appbar_with_image.dart';
import '../../home_customer/screen/widgets/lawer_item.dart';

class LawyerOfficeScreen extends StatelessWidget {
  const LawyerOfficeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DetailsLawyerFromCustomerPartCubit>();
    var lawyer = cubit.detailsDataLawyerModel?.data?.lawyer;
    return Scaffold(
      body: BlocBuilder<DetailsLawyerFromCustomerPartCubit,
          DetailsLawyerFromCustomerPartState>(builder: (context, state) {
        return Column(
          children: [
            AppbarContainImage(
              isLawyer: false,
              titleCenter: "Lawyer_office".tr(),
              widget: Row(
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //
                  //   },
                  //   child: Container(
                  //       decoration: BoxDecoration(
                  //         color: AppColors.white.withOpacity(0.2),
                  //         borderRadius: BorderRadius.circular(
                  //           10.sp * textScaleFactor(context),
                  //         ),
                  //       ),
                  //       child: Padding(
                  //         padding: EdgeInsets.all(5.0.sp),
                  //         child: SvgPicture.asset(ImageAssets.shareIcon),
                  //       )),
                  // ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(
                          10.sp * textScaleFactor(context),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0.sp),
                        child: CustomPopup(
                            showArrow: true,
                            arrowColor: Colors.white,
                            backgroundColor: Colors.white,
                            content: SizedBox(
                              // height: getHeightSize(context) / 2,
                              width: getWidthSize(context) / 2.6,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return BlocBuilder<
                                          DetailsLawyerFromCustomerPartCubit,
                                          DetailsLawyerFromCustomerPartState>(
                                        builder: (context, state) {
                                          var cubit = context.read<
                                              DetailsLawyerFromCustomerPartCubit>();
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0.w),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12.0.h),
                                                    child: Text(
                                                      "report_lawyer".tr(),
                                                      style: getBoldStyle(
                                                          fontSize: 18.sp *
                                                              textScaleFactor(
                                                                  context),
                                                          color: AppColors
                                                              .redLight),
                                                    ),
                                                  ),
                                                  CustomTextField(
                                                    controller: cubit
                                                        .reportLaywerController,
                                                    titleFromTextFormField:
                                                        "report_lawyer".tr(),
                                                    hintText:
                                                        "report_lawyer".tr(),
                                                  ),
                                                  CustomTextField(
                                                    controller: cubit
                                                        .reportLaywerController,
                                                    titleFromTextFormField:
                                                        "issue_description"
                                                            .tr(),
                                                    isMessage: true,
                                                    hintText:
                                                        "issue_description"
                                                            .tr(),
                                                  ),
                                                  CustomButton(
                                                    widget: Text(
                                                      'send'.tr(),
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.white),
                                                    ),
                                                    paddingButton:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 22.w,
                                                            vertical: 8.h),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "report_lawyer".tr(),
                                          style: getBoldStyle(
                                              fontSize: 14.sp *
                                                  textScaleFactor(context),
                                              color: AppColors.redLight),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            child: Icon(
                              Icons.more_vert_sharp,
                              color: AppColors.white,
                            )),
                      )),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                      child: SizedBox(
                        width: double.infinity,
                        child: LawyerItem(
                          type: 'details',
                          loginModelLawyer:
                              cubit.detailsDataLawyerModel?.data?.lawyer,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: customShadow,
                          borderRadius: BorderRadius.circular(12.sp),
                          color: AppColors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                ImageAssets.dollarIcon,
                                height: 30.h,
                                width: 30.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "consultation_price".tr(),
                                    style: getBoldStyle(
                                        color: AppColors.gray, fontSize: 13.sp),
                                  ),
                                  Text(
                                    "${lawyer?.consultationFee ?? ""} ${"egp".tr()}",
                                    style: getBoldStyle(
                                        color: AppColors.greenLight,
                                        fontSize: 13.sp),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "power_of_attorney".tr(),
                                    style: getBoldStyle(
                                        color: AppColors.gray, fontSize: 13.sp),
                                  ),
                                  Text(
                                    "${lawyer?.attorneyFee ?? ""} ${"egp".tr()}",
                                    style: getBoldStyle(
                                        color: AppColors.greenLight,
                                        fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(height: 150.h, child: const SwiperWidget()),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "info_lawyer".tr(),
                            style: getRegularStyle(
                                color: AppColors.blackLight, fontSize: 15.sp),
                          ),
                          Text(
                            lawyer?.about ?? "",
                            style: getRegularStyle(
                              fontSize: 15.sp,
                              color: AppColors.gray,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.sp),
                          boxShadow: customShadow,
                        ),
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "connect_with_lawyer".tr(),
                              style: getRegularStyle(
                                  color: AppColors.blackLight, fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.emailIcon,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                AutoSizeText(
                                  lawyer?.email ?? "",
                                  style: getUnderLine(
                                    color: AppColors.primary,
                                    fontSize: 14.sp * textScaleFactor(context),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.phoneIcon,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                AutoSizeText(
                                  lawyer?.phone ?? "",
                                  style: getUnderLine(
                                    color: AppColors.primary,
                                    fontSize: 14.sp * textScaleFactor(context),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.addressIcon,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                AutoSizeText(
                                  lawyer?.officeAddress ?? "",
                                  maxLines: 2,
                                  style: getRegularStyle(
                                    color: AppColors.primary,
                                    fontSize: 14.sp * textScaleFactor(context),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    lawyer?.officeTeamWork?.length == 0 ? Container() :
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "list_of_lawyers".tr(),
                            style: getRegularStyle(
                                color: AppColors.blackLight, fontSize: 15.sp),
                          ),
                          ListView.builder(
                            itemCount: lawyer?.officeTeamWork?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(
                                bottom: 20.sp * textScaleFactor(context),
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  width: getWidthSize(context) * 2 / 2.3,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 35.h,
                                        ),
                                        padding: EdgeInsets.all(
                                          8.sp * textScaleFactor(context),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: AppColors.white,
                                          boxShadow: customShadow,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment:
                                                  (EasyLocalization.of(context)!
                                                              .locale
                                                              .languageCode ==
                                                          'ar')
                                                      ? Alignment.topLeft
                                                      : Alignment.topRight,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    lawyer
                                                            ?.officeTeamWork?[
                                                                index]
                                                            .level
                                                            ?.salary
                                                            .toString() ??
                                                        "",
                                                    style: getBoldStyle(
                                                      color:
                                                          AppColors.greenLight,
                                                      fontSize: 14.sp *
                                                          textScaleFactor(
                                                              context),
                                                    ),
                                                  ),
                                                  Text(
                                                    "egp".tr(),
                                                    style: getBoldStyle(
                                                      color: AppColors.black,
                                                      fontSize: 14.sp *
                                                          textScaleFactor(
                                                              context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              lawyer?.officeTeamWork?[index]
                                                      .name ??
                                                  "",
                                              style: getRegularStyle(
                                                fontSize: 14.sp *
                                                    textScaleFactor(context),
                                              ),
                                            ),
                                            Text(
                                              lawyer?.officeTeamWork?[index]
                                                      .type ??
                                                  "",
                                              style: getBoldStyle(
                                                color: AppColors.gray,
                                                fontSize: 14.sp *
                                                    textScaleFactor(context),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomButton(
                                                    color: AppColors.primary,
                                                    widget: Center(
                                                      child: Text(
                                                        "accept".tr(),
                                                        style: getRegularStyle(
                                                          color: AppColors.white,
                                                          fontSize:
                                                          14.sp * textScaleFactor(context),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Expanded(
                                                  child: CustomButton(
                                                    color: AppColors.white,
                                                    border: Border.all(color: AppColors.redLight),
                                                    widget: Center(
                                                      child: Text(
                                                        "reject".tr(),
                                                        style: getRegularStyle(
                                                          color: AppColors.red,
                                                          fontSize:
                                                          14.sp * textScaleFactor(context),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      PositionedDirectional(
                                        start: 12.w,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.transparent,
                                          ),
                                          child: CircleAvatar(
                                            radius: 25.r,
                                            backgroundColor:
                                                AppColors.transparent,
                                            child: Image.network(lawyer
                                                    ?.officeTeamWork?[index]
                                                    .image ??
                                                ""),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
