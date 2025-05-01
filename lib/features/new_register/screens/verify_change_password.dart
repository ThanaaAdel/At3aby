import 'dart:developer';

import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/widgets/appbar_with_image.dart';
import '../../login/screens/login.dart';
import '../../login/screens/widgets/custom_pin_code.dart';
import 'package:ataaby/features/new_register/cubit/state.dart';
import '../cubit/cubit.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewRegisterCubit, NewRegisterState>(
          builder: (context, state) {
        var cubit = context.read<NewRegisterCubit>();

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarContainImage(
                isLawyer: args.indexPageClientOrLawyer == 1,
                titleCenter: "verify_email".tr(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(height: 20.h),
                    Text("activate_account".tr(),
                        style: getBoldStyle(
                          fontSize: 20.sp * textScaleFactor(context),
                        )),
                    SizedBox(height: 20.h),
                    Text(
                      'message_of_activate'.tr(),
                      style: getRegularStyle(fontSize: 15.sp),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                        child:
                            CustomPinCode(controller: cubit.verifyController)),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${cubit.minutes.toString()}:${cubit.seconds.toString()}',
                          style: getRegularStyle(
                              color: AppColors.blackLight, fontSize: 15.sp),
                        ),
                        TextButton(
                          onPressed: () {
                            if (cubit.minutes == 0 && cubit.seconds == 0) {
                              cubit.sendOtp(context, args,
                                  isResetpassword:
                                      args.typeOfVerification == 'change_email'
                                          ? false
                                          : true,
                                  sendOtp: true);
                              log('===>> || <<===');
                            } else {
                              errorGetBar('expire_msg'.tr());
                            }

                            //!
                          },
                          child: Text(
                            'resend'.tr(),
                            style: getRegularStyle(
                                color: AppColors.primary, fontSize: 15.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    (state is LoadingVOtpState || state is LoadingOtpState)
                        ? Center(
                            child: CustomLoadingIndicator(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  widget: Center(
                                      child: Text(
                                    "activate".tr(),
                                    style:
                                        getRegularStyle(color: AppColors.white),
                                  )),
                                  onTap: () {
                                    if (cubit.verifyController.text.isEmpty ||
                                        cubit.verifyController.text.length <
                                            6) {
                                      errorGetBar('Invalid_Pin_Code'.tr());
                                    } else {
                                      cubit.verifyOtp(
                                          context,
                                          ChooseTypeRegisterArgs(
                                            indexPageClientOrLawyer:
                                                args.indexPageClientOrLawyer,
                                            typeOfVerification:
                                                args.typeOfVerification ==
                                                        'change_email'
                                                    ? "change_email"
                                                    : 'forget_password',
                                          ));
                                      log('===>> || <<===');
                                      //! Verify and nav to login of user or laywer
                                    }
                                  },
                                )),
                          ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
