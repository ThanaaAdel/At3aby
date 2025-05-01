import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';
import 'package:easy_localization/easy_localization.dart';

class TheCourtsCustomerWidget extends StatelessWidget {
  const TheCourtsCustomerWidget({
    super.key,
    required this.courtData,
    this.onTap,
  });
  final CourtData courtData;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20.sp * textScaleFactor(context),
          ),
          color: AppColors.white,
          border: Border.all(color: AppColors.grayLite),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h, right: 10.w, left: 5.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      courtData.seen == 1
                          ? Container()
                          : Container(
                          padding: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w,
                              bottom: 3.h,
                              top: 3.h),
                          decoration: BoxDecoration(
                            color: AppColors.redLight,

                            borderRadius: BorderRadius.circular(
                              8.sp * textScaleFactor(context),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "there_is_a_update",
                              style: getRegularStyle(
                                  color: AppColors.white, fontSize: 12.sp),
                            ),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
                        margin: EdgeInsets.only(
                            left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grayLite,
                              offset: const Offset(1, 2),
                              blurRadius: 20,
                              blurStyle: BlurStyle.inner,
                            )
                          ],
                          border: Border.all(color: AppColors.gray),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          ImageAssets.lowBalanceIcon,
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${"num_of_issue".tr()} : ${courtData.caseNumber}",
                              style: getRegularStyle(
                                  fontSize: 14.sp * textScaleFactor(context),
                                  color: AppColors.primary),
                            ),
                            Text(
                              courtData.title ?? "",
                              style: getRegularStyle(
                                fontSize: 14.sp * textScaleFactor(context),
                              ),
                            ),
                            Text(
                              courtData.details ?? "",
                              style: getRegularStyle(
                                  fontSize: 14.sp * textScaleFactor(context),
                                  color: AppColors.gray),
                            ),
                            SizedBox(
                              // width: 230.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        (courtData.eventStatus == "accepted" &&
                                            courtData.status == "accepted")?
                                        courtData.caseFinalPrice.toString():
                                        courtData.caseEstimatedPrice.toString(),
                                        style: getRegularStyle(
                                            fontSize: 20.sp *
                                                textScaleFactor(context),
                                            color: AppColors.greenLight),
                                      ),
                                      SizedBox(width: 5.w),
                                      Text("egp".tr(),
                                          style: getRegularStyle(
                                              fontSize: 18.sp *
                                                  textScaleFactor(context),
                                              color: AppColors.black)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 0.h),
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10.w,
                                                right: 10.w,
                                                bottom: 8.h,
                                                top: 8.h),
                                            // states by colors
                                            decoration: BoxDecoration(
                                              color: (courtData.status ==
                                                  'rejected' ||
                                                  courtData.status == "cancelled")
                                                  ? AppColors.red
                                                  .withOpacity(0.2)
                                                  : (courtData.status ==
                                                  'offered' ||
                                                  courtData.status ==
                                                      'new' ||
                                                  courtData.status ==
                                                      'private')
                                                  ? AppColors.orangeLight
                                                  .withOpacity(0.2)
                                                  : (courtData.status ==
                                                  'completed')
                                                  ? AppColors.green
                                                  .withOpacity(0.2)
                                                  : (courtData.status ==
                                                  'accepted')
                                                  ? AppColors.green
                                                  .withOpacity(
                                                  0.2)
                                                  : null,

                                              borderRadius:
                                              BorderRadius.circular(
                                                8.sp * textScaleFactor(context),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                (courtData.status ==
                                                    'offered' ||
                                                    courtData.status ==
                                                        'new' ||
                                                    courtData.status ==
                                                        'private')
                                                    ? "on_hold_until_accepted".tr()
                                                    : (courtData.status ==
                                                    'completed')
                                                    ? "completed".tr()
                                                    : (courtData.status ==
                                                    'rejected') || courtData.status == "cancelled"
                                                    ? "rejected".tr()
                                                    : (courtData.status ==
                                                    'accepted')
                                                    ? "the_case_is_ongoing".tr()
                                                    : "",
                                                style: getRegularStyle(
                                                    color: (courtData.status ==
                                                        'offered' ||
                                                        courtData.status ==
                                                            'new' ||
                                                        courtData.status ==
                                                            'private')
                                                        ? AppColors.orangeLight
                                                        : (courtData.status ==
                                                        'completed')
                                                        ? AppColors.green
                                                        : (courtData.status ==
                                                        'rejected' || courtData.status == "cancelled")
                                                        ? AppColors.red
                                                        : (courtData.status ==
                                                        'accepted')
                                                        ? AppColors
                                                        .green
                                                        : null,
                                                    fontSize: 12.sp *
                                                        textScaleFactor(
                                                            context)),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                  10.verticalSpace,
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
