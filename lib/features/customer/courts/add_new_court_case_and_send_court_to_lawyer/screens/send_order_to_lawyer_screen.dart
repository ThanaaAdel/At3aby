import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/login/data/models/login_model_lawyer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/add_new_court_case_and_send_court_to_lawyer_cubit.dart';
import '../cubit/add_new_court_case_and_send_court_to_lawyer_state.dart';
import 'add_new_court_case_screen.dart';

class SendOrderToLawyerScreen extends StatefulWidget {
  const SendOrderToLawyerScreen({super.key, required this.lawyer});
 final LoginModelLawyerData lawyer;

  @override
  State<SendOrderToLawyerScreen> createState() => _SendOrderToLawyerScreenState();
}

class _SendOrderToLawyerScreenState extends State<SendOrderToLawyerScreen> {
 @override
  void initState() {
   context.read<AddNewCourtCaseAndSendCourtToLawyerCubit>().getFilterSpecialist();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<AddNewCourtCaseAndSendCourtToLawyerCubit, AddNewCourtCaseAndSendCourtToLawyerState>(
        builder: (context, state) {
          var cubit = context.read<AddNewCourtCaseAndSendCourtToLawyerCubit>();

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appbar with Image
              AppbarContainImage(
                isLawyer: false,
                titleCenter: "send_order_to_lawyer".tr(),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 10.h,
                            right: 20.w,
                            top: 10.h,
                            left: 20.w,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.sp),
                            boxShadow: customShadow,
                            color: AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.lawyer.name ?? "",
                                style: getRegularStyle(
                                  fontSize: 14.sp * textScaleFactor(context),
                                ),
                              ),
                              Text(
                                widget.lawyer.type ?? "",
                                style: getRegularStyle(
                                    fontSize: 14.sp * textScaleFactor(context),
                                    color: AppColors.gray),
                              ),
                            ],
                          ),
                        ),

                        ///!
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomAddNewIssueData(
                          cubit: cubit,
                          isSendOrderToLawyer: true,),

                        SizedBox(height: 20.h),
                        (state is AddPrivateCaseLoading)?

                            Center(child: CustomLoadingIndicator(),):
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              widget: Center(
                                child: Text(
                                  "send_order_to_lawyer".tr(),
                                  style: getRegularStyle(
                                    color: AppColors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                              onTap: () {
                              cubit.addPrivateCase(context,lawyerId: widget.lawyer.id!);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
