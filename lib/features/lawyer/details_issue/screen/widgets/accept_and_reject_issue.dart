import 'dart:developer';
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/custom_show_dialog.dart';
import 'package:ataaby/core/widgets/dropdown_button_form_field.dart';
import 'package:ataaby/features/lawyer/details_issue/cubit/details_issue_cubit.dart';
import 'package:ataaby/features/lawyer/details_issue/cubit/details_issue_state.dart';
import 'package:ataaby/features/lawyer/details_issue/data/models/get_court_by_id_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../data/models/get_refuse_reasons_model.dart';


class AcceptAndRejectIssue extends StatefulWidget {
  const AcceptAndRejectIssue({
    super.key,
    required this.getCourtCaseByIdModel,
  });
  final GetCourtCaseByIdModel getCourtCaseByIdModel;
  @override
  State<AcceptAndRejectIssue> createState() => _AcceptAndRejectIssueState();
}

//! commit
class _AcceptAndRejectIssueState extends State<AcceptAndRejectIssue> {
  @override
  void initState() {
    if (context.read<DetailsIssueCubit>().getRefuseReasonsModel == null) {
      context.read<DetailsIssueCubit>().getRefuseReasons(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DetailsIssueCubit>();
    return Padding(
      padding: EdgeInsets.only(
          left: 10.0.w, right: 10.0.w, top: 20.0.h, bottom: 20.0.h),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: customShadow),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<DetailsIssueCubit, DetailsIssueState>(
              builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: const [],
                          border: Border.all(
                              color: AppColors.secondPrimary.withOpacity(0.6))),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.getCourtCaseByIdModel.data?.client?.image ??
                              '',
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${"num_of_issue".tr()} : ${widget.getCourtCaseByIdModel.data?.caseNumber ?? ""}",
                            style: getRegularStyle(
                                fontSize: 14.sp * textScaleFactor(context),
                                color: AppColors.primary),
                          ),
                          Text(
                            widget.getCourtCaseByIdModel.data?.title ?? "",
                            style: getRegularStyle(
                              fontSize: 14.sp * textScaleFactor(context),
                            ),
                          ),
                          Text(
                            widget.getCourtCaseByIdModel.data?.details ?? "",
                            style: getRegularStyle(
                                fontSize: 14.sp * textScaleFactor(context),
                                color: AppColors.gray),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(end: 22.w),
                            // width: 350.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  // fit: FlexFit.tight,
                                  child: Row(
                                    children: [
                                      Flexible(
                                          child: Text(
                                            (widget.getCourtCaseByIdModel.data?.caseFinalPrice ?? 0) == 0
                                                ? (widget.getCourtCaseByIdModel.data?.caseEstimatedPrice?.toString() ?? '')
                                                : (widget.getCourtCaseByIdModel.data?.caseFinalPrice?.toString() ?? ''),
                                            style: getRegularStyle(
                                              fontSize: 20.sp * textScaleFactor(context),
                                              color: AppColors.greenLight,
                                            ),
                                          ),),
                                      SizedBox(width: 5.w),
                                      Text("egp".tr(),
                                          style: getRegularStyle(
                                              fontSize: 18.sp *
                                                  textScaleFactor(context),
                                              color: AppColors.black))
                                    ],
                                  ),
                                ),
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
                                        color: (widget.getCourtCaseByIdModel.data?.status ==
                                            'rejected' ||
                                            widget.getCourtCaseByIdModel.data?.status == "cancelled")
                                            ? AppColors.red
                                            .withOpacity(0.2)
                                            : (widget.getCourtCaseByIdModel.data?.status ==
                                            'offered' ||
                                            widget.getCourtCaseByIdModel.data?.status ==
                                                'new' ||
                                            widget.getCourtCaseByIdModel.data?.status ==
                                                'private')
                                            ? AppColors.orangeLight
                                            .withOpacity(0.2)
                                            : (widget.getCourtCaseByIdModel.data?.status ==
                                            'completed')
                                            ? AppColors.green
                                            .withOpacity(0.2)
                                            : (widget.getCourtCaseByIdModel.data?.status ==
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
                                          (widget.getCourtCaseByIdModel.data?.status ==
                                              'offered' ||
                                              widget.getCourtCaseByIdModel.data?.status ==
                                                  'new' ||
                                              widget.getCourtCaseByIdModel.data?.status ==
                                                  'private')
                                              ? "on_hold_until_accepted".tr()
                                              : (widget.getCourtCaseByIdModel.data?.status ==
                                              'completed')
                                              ? "completed".tr()
                                              : (widget.getCourtCaseByIdModel.data?.status ==
                                              'rejected') || widget.getCourtCaseByIdModel.data?.status == "cancelled"
                                              ? "rejected".tr()
                                              : (widget.getCourtCaseByIdModel.data?.status ==
                                              'accepted')
                                              ? "the_case_is_ongoing".tr()
                                              : "",
                                          style: getRegularStyle(
                                              color: (widget.getCourtCaseByIdModel.data?.status ==
                                                  'offered' ||
                                                  widget.getCourtCaseByIdModel.data?.status ==
                                                      'new' ||
                                                  widget.getCourtCaseByIdModel.data?.status ==
                                                      'private')
                                                  ? AppColors.orangeLight
                                                  : (widget.getCourtCaseByIdModel.data?.status ==
                                                  'completed')
                                                  ? AppColors.green
                                                  : (widget.getCourtCaseByIdModel.data?.status ==
                                                  'rejected' || widget.getCourtCaseByIdModel.data?.status == "cancelled")
                                                  ? AppColors.red
                                                  : (widget.getCourtCaseByIdModel.data?.status ==
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
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                //   new   (تقديم العرض و رفض )
                //  private   (قبول ورفض)
                //    (الاتعاب و انهاء القضية) جارية
                (widget.getCourtCaseByIdModel.data?.status == "new" &&
                        widget.getCourtCaseByIdModel.data?.lawyerEvent == null)
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: CustomButton(
                          width: double.infinity,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Center(
                              child: Text(
                                'make_an_offer'.tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white,
                                  fontSize: 14.sp * textScaleFactor(context),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            //!
                            showDialog(
                              anchorPoint: Offset.fromDirection(0, 0),
                              context: context,
                              barrierDismissible:
                                  true, // Allows to dismiss the dialog by tapping outside
                              builder: (BuildContext context) {
                                return BlocBuilder<DetailsIssueCubit,
                                    DetailsIssueState>(
                                  builder: (context, state) {
                                    return CustomShowDialog(
                                      widget: SizedBox(
                                        width: double.infinity,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                10.h.verticalSpace,
                                                CustomTextField(
                                                  controller: cubit
                                                      .priceForOfferIssueController,
                                                  hintText: "enter_price".tr(),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  titleFromTextFormField:
                                                      "enter_price".tr(),
                                                ),
                                                30.h.verticalSpace,
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      isLoading: state
                                          is LoadingAddEventCourtCaseState,
                                      titleButton: "make_an_offer".tr(),
                                      onTap: () {
                                        cubit.addEventCourtCase(context);
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      )
                    : widget.getCourtCaseByIdModel.data?.status == "private"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                widget: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.w),
                                  child: Text(
                                    'accept'.tr(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white,
                                      fontSize:
                                          14.sp * textScaleFactor(context),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.acceptIssueRoute,
                                      arguments: false);
                                },
                              ),
                              CustomButton(
                                color: AppColors.white,
                                border: Border.all(color: AppColors.redLight),
                                widget: Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.w, right: 25.w),
                                  child: Text(
                                    'reject'.tr(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.redLight,
                                      fontSize:
                                          14.sp * textScaleFactor(context),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  //! Show Dialog when button is tapped
                                  showDialog(
                                    anchorPoint: Offset.fromDirection(0, 0),
                                    context: context,
                                    barrierDismissible:
                                        true, // Allows to dismiss the dialog by tapping outside
                                    builder: (BuildContext context) {
                                      return BlocBuilder<DetailsIssueCubit,
                                          DetailsIssueState>(
                                        builder: (context, state) {
                                          return CustomShowDialog(
                                            isLoading: state
                                                is LoadingActionCourtCaseState,
                                            widget: SizedBox(
                                              width: double.infinity,
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "refuse_reason".tr(),
                                                        style: getRegularStyle(
                                                          fontSize: 14.sp *
                                                              textScaleFactor(
                                                                  context),
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      CustomDropdownButtonFormField<
                                                          GetRefuseReasonsModelData>(
                                                        itemBuilder: (item) {
                                                          return item.name ??
                                                              '';
                                                        },
                                                        items: cubit
                                                                .getRefuseReasonsModel
                                                                ?.data ??
                                                            [],
                                                        value: cubit
                                                            .selectedRefusedController,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            cubit.selectedRefusedController =
                                                                newValue;
                                                          });
                                                        },
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Please select an option';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      CustomTextField(
                                                        controller: cubit
                                                            .notesController,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        titleFromTextFormField:
                                                            "notes".tr(),
                                                        isMessage: true,
                                                      ),
                                                      SizedBox(
                                                        height: 30.h,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            titleButton: "reject".tr(),
                                            onTap: () {
                                              cubit.lawyerActionCourtCase(
                                                  context);
                                              // Navigator.pushNamed(
                                              //     context, Routes.mainLawyerRoute,
                                              //     arguments: ChooseTypeRegisterArgs(
                                              //         indexPageClientOrLawyer: 1));
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        : (widget.getCourtCaseByIdModel.data?.status == "new" &&
                                widget.getCourtCaseByIdModel.data?.lawyerEvent
                                        ?.status ==
                                    'offer')
                            ? state is LoadingDeleteEventCourtCaseState
                                ? Center(
                                    child: CustomLoadingIndicator(),
                                  )
                                : CustomButton(
                                    shadow: const [],
                                    color: AppColors.white,
                                    border:
                                        Border.all(color: AppColors.redLight),
                                    widget: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Text(
                                          'cancel_court_case'.tr(),
                                          style: getRegularStyle(
                                            color: AppColors.redLight,
                                            fontSize: 14.sp *
                                                textScaleFactor(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      AwesomeDialog(
                                              context: context,
                                              showCloseIcon: false,
                                              dialogType: DialogType.question,
                                              animType: AnimType.rightSlide,
                                              padding: EdgeInsets.all(10.w),
                                              title: "ended_issue_sure".tr(),
                                              btnOkOnPress: () {
                                                cubit.deleteEventCourtCase(
                                                  context: context,
                                                );
                                                log('end ${'cancel_court_case'.tr()}');
                                              },
                                              btnOkText: "sure".tr(),
                                              btnCancelOnPress: () {},
                                              btnCancelText: 'cancel'.tr())
                                          .show();
                                    },
                                  )
                            : Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      shadow: const [],
                                      paddingButton: EdgeInsets.only(
                                        top: 12.h,
                                        bottom: 12.h,
                                        right: 10.w,
                                        left: 10.w,
                                      ),
                                      border: Border.all(
                                        color: AppColors.primary,
                                      ),
                                      color: AppColors.white,
                                      widget: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                ImageAssets.walletIcon),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              'Financial_fees'.tr(),
                                              style: getRegularStyle(
                                                color: AppColors.primary,
                                                fontSize: 14.sp *
                                                    textScaleFactor(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        log('[[[]]]');
                                        Navigator.pushNamed(
                                            context, Routes.acceptIssueRoute,
                                            arguments: true);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: CustomButton(
                                      shadow: const [],
                                      color: AppColors.white,
                                      border:
                                          Border.all(color: AppColors.redLight),
                                      widget: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          child: Text(
                                            'ended_issue'.tr(),
                                            style: getRegularStyle(
                                              color: AppColors.redLight,
                                              fontSize: 14.sp *
                                                  textScaleFactor(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Fluttertoast.showToast(
                                          msg: 'جاري العمل عليها',
                                          backgroundColor: AppColors.black,
                                        );
                                        log('end ${'ended_issue'.tr()}');
                                      },
                                    ),
                                  ),
                                ],
                              )
              ],
            );
          }),
        ),
      ),
    );
  }
}
