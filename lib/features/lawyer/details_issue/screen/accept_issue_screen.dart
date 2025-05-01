import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/lawyer/details_issue/cubit/details_issue_cubit.dart';
import 'package:ataaby/features/lawyer/details_issue/cubit/details_issue_state.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/custom_show_dialog.dart';
import '../../../../core/widgets/date_widget.dart';
import '../../../login/screens/login.dart';

class AcceptIssueScreen extends StatefulWidget {
  AcceptIssueScreen({
    super.key,
    this.isShowAt3aby = false,
  });
  bool isShowAt3aby;
  @override
  _AcceptIssueScreenState createState() => _AcceptIssueScreenState();
}

class _AcceptIssueScreenState extends State<AcceptIssueScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsIssueCubit, DetailsIssueState>(
        builder: (context, state) {
      var cubit = context.read<DetailsIssueCubit>();

      return Scaffold(
        body: Column(
          children: [
            AppbarContainImage(
              isLawyer: true,
              titleCenter: "accept_issue".tr(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "case_payments_due".tr(),
                        style: getRegularStyle(
                          fontSize: 14.sp * textScaleFactor(context),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: cubit.getCourtCaseByIdModel?.data?.lawyerEvent
                              ?.dues?.length ??
                          0,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    cubit.getCourtCaseByIdModel?.data
                                            ?.lawyerEvent?.dues?[index].title ??
                                        '',
                                    maxLines: 2,
                                    style: getRegularStyle(fontSize: 15.sp),
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMd().format(cubit
                                              .getCourtCaseByIdModel
                                              ?.data
                                              ?.lawyerEvent
                                              ?.dues?[index]
                                              .date ??
                                          DateTime.now()) ??
                                      "",
                                  style: getRegularStyle(
                                      fontSize:
                                          14.sp * textScaleFactor(context),
                                      color: AppColors.gray),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              cubit.getCourtCaseByIdModel?.data?.lawyerEvent
                                      ?.dues?[index].price
                                      .toString() ??
                                  "",
                              style: getBoldStyle(
                                  fontSize: 16.sp, color: AppColors.primary),
                            ),
                            Divider(
                              color: AppColors.grayLite,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomButton(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.primary),
                            paddingButton: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              bottom: 10.h,
                              top: 10.h,
                            ),
                            widget: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppColors.primary,
                                  size: 13.sp,
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Text(
                                  "new_payment".tr(),
                                  style: getRegularStyle(
                                      color: AppColors.primary,
                                      fontSize: 13.sp),
                                ),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                anchorPoint: Offset.fromDirection(0, 0),
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return BlocBuilder<DetailsIssueCubit,
                                          DetailsIssueState>(
                                      builder: (context, state) {
                                    var cubit =
                                        context.read<DetailsIssueCubit>();
                                    return CustomShowDialog(
                                      widget: SizedBox(
                                        width: double.infinity,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                DatePickerField(
                                                  title: "update_date".tr(),
                                                  onTab: () {
                                                    cubit.onSelectedDate(
                                                        context);
                                                  },
                                                  selectedDate:
                                                      cubit.selectedDate,
                                                ),
                                                CustomTextField(
                                                  controller:
                                                      cubit.addressController,
                                                  titleFromTextFormField:
                                                      "address".tr(),
                                                  hintText:
                                                      "enter_address".tr(),
                                                ),
                                                CustomTextField(
                                                  controller: cubit
                                                      .paymentMoneyController,
                                                  suffixIcon: Text(
                                                    "pound".tr(),
                                                    style: getRegularStyle(
                                                        color:
                                                            AppColors.primary),
                                                  ),
                                                  titleFromTextFormField:
                                                      "payment_money".tr(),
                                                ),
                                                SizedBox(
                                                  height: 30.h,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      isLoading:
                                          state is AddCourtCaseDuesLoading,
                                      titleButton: "start_now".tr(),
                                      onTap: () {
                                        cubit.addCourtCaseDues(context);
                                      },
                                    );
                                  });
                                },
                              );
                            }, // Add a new payment field
                          ),
                        ],
                      ),
                    ),
                    40.h.verticalSpace,
                    if (widget.isShowAt3aby == false)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                showCloseIcon: false,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                padding: EdgeInsets.all(10.w),
                                title: "done_accept".tr(),
                                btnOkOnPress: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, Routes.mainLawyerRoute,
                                      arguments: ChooseTypeRegisterArgs(
                                          indexPageClientOrLawyer: 1));
                                },
                                btnOkText: "start_now".tr(),
                              ).show();
                            },
                            widget: Center(
                              child: Text(
                                "accept_issue".tr(),
                                style: getRegularStyle(color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
