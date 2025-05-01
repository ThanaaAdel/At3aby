import 'dart:developer';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/custom_show_dialog.dart';
import 'package:ataaby/core/widgets/dropdown_button_form_field.dart';
import 'package:ataaby/features/customer/courts/the_courts/cubit/state.dart';
import 'package:ataaby/features/lawyer/details_issue/cubit/details_issue_cubit.dart';
import 'package:ataaby/features/lawyer/details_issue/cubit/details_issue_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../chat/screens/message_screen.dart';
import '../../../../../lawyer/details_issue/data/models/get_refuse_reasons_model.dart';
import '../../../add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';
import '../../cubit/cubit.dart';

class ConnectFromLawyerOrCancelOrder extends StatefulWidget {
  const ConnectFromLawyerOrCancelOrder({
    super.key,
    required this.courtData,
  });
  final CourtData courtData;

  @override
  State<ConnectFromLawyerOrCancelOrder> createState() =>
      _ConnectFromLawyerOrCancelOrderState();
}

class _ConnectFromLawyerOrCancelOrderState
    extends State<ConnectFromLawyerOrCancelOrder> {
  late TheCourtsCustomerCubit cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<TheCourtsCustomerCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: customShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<DetailsIssueCubit, DetailsIssueState>(
            builder: (context, state) {
              return Column(
                children: [
                  if (widget.courtData.seen == 0) _buildUpdateNotification(),
                  SizedBox(height: 10.h),
                  _buildCourtDetails(),
                  SizedBox(height: 10.h),
                  _buildActionButtons(state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateNotification() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.redLight,
          borderRadius: BorderRadius.circular(6.sp),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "there_is_a_update".tr(),
            style: getRegularStyle(
              fontSize: 14.sp * textScaleFactor(context),
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourtDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(),
        10.verticalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${"num_of_issue".tr()} : ${widget.courtData.caseNumber}",
                style: getRegularStyle(
                  fontSize: 14.sp * textScaleFactor(context),
                  color: AppColors.primary,
                ),
              ),
              AutoSizeText(
                widget.courtData.title ?? "",
                maxLines: 1,
                style: getRegularStyle(
                  fontSize: 14.sp * textScaleFactor(context),
                ),
              ),
              AutoSizeText(
                widget.courtData.details ?? "",
                maxLines: 2,
                style: getRegularStyle(
                  fontSize: 14.sp * textScaleFactor(context),
                  color: AppColors.gray,
                ),
              ),
              _buildStatusAndPrice(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.secondPrimary.withOpacity(0.6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          ImageAssets.lowBalanceIcon,
          width: 30.w,
          height: 30.h,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildStatusAndPrice() {
    return SizedBox(
      width: 230.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                (widget.courtData.eventStatus == "accepted" &&
                        widget.courtData.status == "accepted")
                    ? widget.courtData.caseFinalPrice.toString()
                    : widget.courtData.caseEstimatedPrice.toString(),
                style: getRegularStyle(
                  fontSize: 20.sp * textScaleFactor(context),
                  color: AppColors.greenLight,
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                "egp".tr(),
                style: getRegularStyle(
                  fontSize: 18.sp * textScaleFactor(context),
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildStatusIndicator(),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator() {
    final status = widget.courtData.status;
    final color = status == 'rejected' || status == "cancelled"
        ? AppColors.red.withOpacity(0.2)
        : status == 'offered' || status == 'new' || status == 'private'
            ? AppColors.orangeLight.withOpacity(0.2)
            : status == 'completed' || status == 'accepted'
                ? AppColors.green.withOpacity(0.2)
                : null;

    final text = status == 'offered' || status == 'new' || status == 'private'
        ? "on_hold_until_accepted".tr()
        : status == 'completed'
            ? "completed".tr()
            : status == 'rejected' || status == "cancelled"
                ? "rejected".tr()
                : status == 'accepted'
                    ? "the_case_is_ongoing".tr()
                    : "";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.sp * textScaleFactor(context)),
      ),
      child: Center(
        child: Text(
          text,
          style: getRegularStyle(
            color: status == 'offered' || status == 'new' || status == 'private'
                ? AppColors.orangeLight
                : status == 'completed'
                    ? AppColors.green
                    : status == 'rejected' || status == "cancelled"
                        ? AppColors.red
                        : status == 'accepted'
                            ? AppColors.green
                            : null,
            fontSize: 12.sp * textScaleFactor(context),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(DetailsIssueState state) {
    if (widget.courtData.status == "new" ||
        widget.courtData.status == "private") {
      return _buildCancelOrderButton(state);
    } else if (widget.courtData.status == "accepted" &&
        widget.courtData.eventStatus == "accepted") {
      return _buildFinancialFeesAndEndCaseButtons();
    } else if (widget.courtData.status == 'offered' &&
        widget.courtData.eventStatus == "accepted") {
      return _buildConnectWithLawyerAndCancelOrderButtons();
    } else if (widget.courtData.status == 'completed') {
      return _buildFinancialFeesButton();
    } else {
      return Container();
    }
  }

  Widget _buildCancelOrderButton(DetailsIssueState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: CustomButton(
        shadow: const [],
        color: AppColors.white,
        border: Border.all(color: AppColors.redLight),
        widget: Center(
          child: AutoSizeText(
            'delete_issue'.tr(),
            style: getRegularStyle(
              color: AppColors.redLight,
              fontSize: 14.sp * textScaleFactor(context),
            ),
          ),
        ),
        onTap: () => _showCancelOrderDialog(state),
      ),
    );
  }

  void _showCancelOrderDialog(DetailsIssueState state) {
    setState(() {
      cubit.reasonCancel = null;
    });
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomShowDialog(
          widget: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "send_description_from_cancel_order".tr(),
                  style: getRegularStyle(
                    fontSize: 14.sp * textScaleFactor(context),
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomDropdownButtonFormField<GetRefuseReasonsModelData>(
                  itemBuilder: (item) => item.name ?? '',
                  items: cubit.getCancelModel?.data ?? [],
                  value: cubit.reasonCancel,
                  onChanged: (newValue) =>
                      setState(() => cubit.reasonCancel = newValue),
                  validator: (value) =>
                      value == null ? 'Please select an option' : null,
                ),
                SizedBox(height: 10.h),
                if (state is LoadingCancelCourtCaseData)
                  Center(child: CustomLoadingIndicator())
                else
                  CustomTextField(
                    controller: cubit.cancelNoteController,
                    padding: EdgeInsets.zero,
                    titleFromTextFormField: "reason_of_cancel".tr(),
                    isMessage: true,
                  ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
          titleButton: "ended_issue".tr(),
          onTap: () => cubit.cancelCourtCase(
            context,
            courtCaseId: cubit.detailsCourtCase?.data?.id.toString() ?? "",
          ),
        );
      },
    );
  }

  Widget _buildFinancialFeesAndEndCaseButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            shadow: const [],
            paddingButton:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
            border: Border.all(color: AppColors.primary),
            color: AppColors.white,
            widget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.walletIcon),
                  SizedBox(width: 10.w),
                  Text(
                    'Financial_fees'.tr(),
                    style: getRegularStyle(
                        color: AppColors.primary, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.elAtaabScreen,
                  arguments: cubit.detailsCourtCase?.data?.id);
              log('Financial_fees'.tr());
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomButton(
            shadow: const [],
            color: AppColors.white,
            border: Border.all(color: AppColors.redLight),
            widget: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'ended_issue'.tr(),
                  style: getRegularStyle(
                      color: AppColors.redLight, fontSize: 12.sp),
                ),
              ),
            ),
            onTap: () => _showEndCaseDialog(),
          ),
        ),
      ],
    );
  }

  void _showEndCaseDialog() {
    setState(() {
      cubit.reasonFinish = null;
    });
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomShowDialog(
          widget: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 25.sp,
                    backgroundImage: NetworkImage(cubit
                            .detailsCourtCase?.data?.lawyerEvent?.lawyerImage ??
                        ""),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    cubit.detailsCourtCase?.data?.lawyerEvent?.lawyerName ?? "",
                    style: getRegularStyle(
                        fontSize: 14.sp * textScaleFactor(context)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: cubit.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 10.sp,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() => cubit.rating = rating);
                        log("Rating: $rating");
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  "why_end_case".tr(),
                  style: getRegularStyle(
                      fontSize: 14.sp * textScaleFactor(context),
                      color: AppColors.black),
                ),
                SizedBox(height: 10.h),
                CustomDropdownButtonFormField<GetRefuseReasonsModelData>(
                  itemBuilder: (item) => item.name ?? '',
                  items: cubit.getFinishReasonsModel?.data ?? [],
                  value: cubit.reasonFinish,
                  onChanged: (newValue) =>
                      setState(() => cubit.reasonFinish = newValue),
                  validator: (value) =>
                      value == null ? 'Please select an option' : null,
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: cubit.commentFromLawyerController,
                  padding: EdgeInsets.zero,
                  titleFromTextFormField: "comment_from_lawyer".tr(),
                  isMessage: true,
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
          titleButton: "ended_issue".tr(),
          onTap: () => cubit.finishCourtCase(
            context,
            courtCaseId: cubit.detailsCourtCase?.data?.id.toString() ?? "",
          ),
        );
      },
    );
  }

  Widget _buildConnectWithLawyerAndCancelOrderButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: CustomButton(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageAssets.messageIcon, width: 15.w),
                SizedBox(width: 5.w),
                AutoSizeText(
                  'connect_with_lawyer'.tr(),
                  maxLines: 1,
                  style:
                      getRegularStyle(fontSize: 12.sp, color: AppColors.white),
                ),
              ],
            ),
            onTap: () {
              if (cubit.detailsCourtCase?.data?.lawyerEvent?.id != null) {
                Navigator.pushNamed(context, Routes.messageRoute,
                    arguments: MainUserAndRoomChatModel(
                        isLawyer: true,
                        receiverId: cubit
                            .detailsCourtCase?.data?.lawyerEvent?.lawyerId
                            .toString()));
                print(
                    'hhhhhhhhhhhhhhere: ${cubit.detailsCourtCase?.data?.lawyerEvent?.id}');
              }
            },
          ),
        ),
        SizedBox(width: 10.w),
        CustomButton(
          shadow: const [],
          color: AppColors.white,
          border: Border.all(color: AppColors.redLight),
          widget: Center(
            child: Text(
              'cancel_order'.tr(),
              style:
                  getRegularStyle(color: AppColors.redLight, fontSize: 12.sp),
            ),
          ),
          onTap: () =>
              _showCancelOrderDialog(context.read<DetailsIssueCubit>().state),
        ),
      ],
    );
  }

  Widget _buildFinancialFeesButton() {
    return Expanded(
      child: CustomButton(
        shadow: const [],
        paddingButton: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
        border: Border.all(color: AppColors.primary),
        color: AppColors.white,
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageAssets.walletIcon),
              SizedBox(width: 10.w),
              Text(
                'Financial_fees'.tr(),
                style:
                    getRegularStyle(color: AppColors.primary, fontSize: 12.sp),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.elAtaabScreen,
              arguments: cubit.detailsCourtCase?.data?.id);

          log('Financial_fees'.tr());
        },
      ),
    );
  }
}
