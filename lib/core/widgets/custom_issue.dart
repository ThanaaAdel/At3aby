import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/home_lawyer/data/model/home_Laywer_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomHomeIssue extends StatelessWidget {
  CustomHomeIssue({
    super.key,
    this.newCourtCase,
    this.onTap,
  });
  NewCourtCase? newCourtCase;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                            color: (newCourtCase?.status ==
                                'rejected' ||
                                newCourtCase?.status == "cancelled")
                                ? AppColors.red
                                .withOpacity(0.2)
                                : (newCourtCase?.status ==
                                'offered' ||
                                newCourtCase?.status ==
                                    'new' ||
                                newCourtCase?.status ==
                                    'private')
                                ? AppColors.orangeLight
                                .withOpacity(0.2)
                                : (newCourtCase?.status ==
                                'completed')
                                ? AppColors.green
                                .withOpacity(0.2)
                                : (newCourtCase?.status ==
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
                              (newCourtCase?.status ==
                                  'offered' ||
                                  newCourtCase?.status ==
                                      'new' ||
                                  newCourtCase?.status ==
                                      'private')
                                  ? "on_hold_until_accepted".tr()
                                  : (newCourtCase?.status ==
                                  'completed')
                                  ? "completed".tr()
                                  : (newCourtCase?.status ==
                                  'rejected') || newCourtCase?.status == "cancelled"
                                  ? "rejected".tr()
                                  : (newCourtCase?.status ==
                                  'accepted')
                                  ? "the_case_is_ongoing".tr()
                                  : "",
                              style: getRegularStyle(
                                  color: (newCourtCase?.status ==
                                      'offered' ||
                                      newCourtCase?.status ==
                                          'new' ||
                                      newCourtCase?.status ==
                                          'private')
                                      ? AppColors.orangeLight
                                      : (newCourtCase?.status ==
                                      'completed')
                                      ? AppColors.green
                                      : (newCourtCase?.status ==
                                      'rejected' || newCourtCase?.status == "cancelled")
                                      ? AppColors.red
                                      : (newCourtCase?.status ==
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
                            "${"num_of_issue".tr()} : ${newCourtCase?.caseNumber ?? ''}",
                            style: getRegularStyle(
                                fontSize: 14.sp * textScaleFactor(context),
                                color: AppColors.primary),
                          ),
                          Text(
                            newCourtCase?.title ?? '',
                            style: getRegularStyle(
                              fontSize: 14.sp * textScaleFactor(context),
                            ),
                          ),
                          Text(
                            newCourtCase?.details ?? "",
                            style: getRegularStyle(
                                fontSize: 14.sp * textScaleFactor(context),
                                color: AppColors.gray),
                          ),
                          SizedBox(
                            // width: 230.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        ImageAssets.dateIcon,
                                        color: AppColors.primary,
                                      ),
                                      Flexible(
                                        child: Text(
                                          newCourtCase?.createdAt
                                                  ?.toIso8601String()
                                                  .substring(0, 10) ??
                                              '',
                                          style: getRegularStyle(
                                              fontSize: 14.sp *
                                                  textScaleFactor(context),
                                              color: AppColors.gray),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: AutoSizeText(
                                          (newCourtCase?.caseFinalPrice ?? 0) == 0
                                              ? (newCourtCase?.caseEstimatedPrice?.toString() ?? '')
                                              : (newCourtCase?.caseFinalPrice?.toString() ?? ''),
                                          style: getRegularStyle(
                                              fontSize: 20.sp *
                                                  textScaleFactor(context),
                                              color: AppColors.greenLight),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "egp".tr(),
                                        style: getRegularStyle(
                                            fontSize: 18.sp *
                                                textScaleFactor(context),
                                            color: AppColors.black),
                                      ),
                                    ],
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
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.grayLite,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r)),
            ),
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.sp,
                        backgroundColor: AppColors.grayLite,
                        backgroundImage:
                            NetworkImage(newCourtCase?.client?.image ?? ''),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                newCourtCase?.client?.name ?? '',
                                maxLines: 1,
                                style: getRegularStyle(
                                  fontSize: 14.sp * textScaleFactor(context),
                                ),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                      "4.00 (120)",
                                      maxLines: 1,
                                      style: getRegularStyle(
                                        fontSize:
                                            14.sp * textScaleFactor(context),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.star_outlined,
                                    color: AppColors.yellow,
                                    size: 20.w,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                    paddingButton: EdgeInsets.only(
                        left: 30.w, right: 30.w, top: 10.h, bottom: 10.h),
                    onTap: onTap,
                    widget: Text(
                      "check_details".tr(),
                      style: TextStyle(
                          fontSize: 14.sp * textScaleFactor(context),
                          color: AppColors.white),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
