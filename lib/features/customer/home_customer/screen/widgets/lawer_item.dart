import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/home_customer/screen/widgets/Star_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../login/data/models/login_model_lawyer.dart';

class LawyerItem extends StatelessWidget {
  const LawyerItem({super.key, required this.type, this.loginModelLawyer});
  final String type;
  final LoginModelLawyerData? loginModelLawyer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        type == "details"
            ? Navigator.pushNamed(context, Routes.lawyerOfficeRoute,arguments: loginModelLawyer?.id )
            : Navigator.pushNamed(context, Routes.detailsLawyerFromCustomerPartRoute,arguments: loginModelLawyer?.id );
      },
      child: SizedBox(
        width: getWidthSize(context) * 2 / 2.3,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 35.h),
              padding: EdgeInsets.all(
                8.sp * textScaleFactor(context),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.white,
                boxShadow: customShadow,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment:
                        (EasyLocalization.of(context)!.locale.languageCode ==
                                'ar')
                            ? Alignment.topLeft
                            : Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          loginModelLawyer?.attorneyFee.toString() ?? "",
                          style: getRegularStyle(
                            color: AppColors.greenLight,
                            fontSize: 20.sp * textScaleFactor(context),
                          ),
                        ),
                        AutoSizeText(
                          "egp".tr(),
                          style: getRegularStyle(
                            color: AppColors.black,
                            fontSize: 14.sp * textScaleFactor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    loginModelLawyer?.name ?? "",
                    maxLines: 1,
                    style: getRegularStyle(
                      fontSize: 14.sp * textScaleFactor(context),
                    ),
                  ),
                  Text(
                    loginModelLawyer?.level?.title ?? '',
                    maxLines: 1,
                    style: getBoldStyle(
                      color: AppColors.gray,
                      fontSize: 14.sp * textScaleFactor(context),
                    ),
                  ),
                  Row(
                    children: [
                      StarRating(
                        color: AppColors.yellow,
                        onRatingChanged: (rating) {},
                        starCount: 5,
                        rating: loginModelLawyer?.avgRate == null
                            ? 0
                            : double.parse(
                                loginModelLawyer?.avgRate.toString() ?? '0'),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                          "${(loginModelLawyer?.avgRate ?? 0).toStringAsFixed(2)} (${loginModelLawyer?.rateCount ?? 0})",
                          style: getRegularStyle(
                            color: AppColors.gray,
                            fontSize: 14.sp * textScaleFactor(context),
                          ))
                    ],
                  ),
                  5.h.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Column(
                      children: [
                        type == "distress_request"
                            ? Container()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.greenLight
                                            .withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.w,
                                            right: 15.w,
                                            top: 5.h,
                                            bottom: 5.h),
                                        child: Column(
                                          children: [
                                            Text(
                                              loginModelLawyer?.successCase
                                                      .toString() ??
                                                  "",
                                              style: getRegularStyle(
                                                  color: AppColors.greenLight,
                                                  fontSize: 15.sp),
                                            ),
                                            Text(
                                              "success_issue".tr(),
                                              style: getRegularStyle(
                                                  color: AppColors.greenLight,
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  30.w.horizontalSpace,
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.redLight.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.w,
                                            right: 15.w,
                                            top: 5.h,
                                            bottom: 5.h),
                                        child: Column(
                                          children: [
                                            Text(
                                              loginModelLawyer?.failedCase
                                                      .toString() ??
                                                  "",
                                              style: getRegularStyle(
                                                  color: AppColors.redLight,
                                                  fontSize: 15.sp),
                                            ),
                                            Text(
                                              'failure_issue'.tr(),
                                              style: getRegularStyle(
                                                  color: AppColors.redLight,
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 10.h,
                        ),
                        (type == "details" || type == 'lawyers')
                            ? SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.sendOrderToLawyerRoute,
                                        arguments: loginModelLawyer);
                                  },
                                  widget: Center(
                                      child: Text(
                                    "order_lawyer_in_issue".tr(),
                                    style: getRegularStyle(
                                        color: AppColors.white,
                                        fontSize: 15.sp),
                                  )),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            PositionedDirectional(
              start: 12.w,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.transparent),
                child: CircleAvatar(
                  radius: 30.r,
                  foregroundColor: AppColors.primary,
                  backgroundColor: AppColors.primary,
                  backgroundImage:
                      Image.network(loginModelLawyer?.image ?? "").image,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
