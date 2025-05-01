import 'dart:developer';

import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/login/screens/widgets/custom_pin_code.dart';
import 'package:easy_localization/easy_localization.dart' as tr;

import '../../../core/exports.dart';
import '../../login/screens/login.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class ActivateAccountScreen extends StatefulWidget {
  const ActivateAccountScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;

  @override
  State<ActivateAccountScreen> createState() => _ActivateAccountScreenState();
}

class _ActivateAccountScreenState extends State<ActivateAccountScreen> {
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewRegisterCubit, NewRegisterState>(
          builder: (context, state) {
        var cubit = context.read<NewRegisterCubit>();
        return Stack(
          children: [
            // خلفية أو صورة SVG في الأعلى
            Positioned(
                top: 0,
                right: 0,
                child: widget.args.indexPageClientOrLawyer == 0
                    ? SvgPicture.asset(
                        ImageAssets.headerLoginIcon,
                        width: 300.w,
                        height: 462.h,
                      )
                    : SvgPicture.asset(
                        ImageAssets.headerDarkBlueIcon,
                        width: 300.w,
                        height: 462.h,
                      )),
            // إضافة SplashFrameOne في الأسفل
            Positioned(
              bottom: -70,
              child: Image.asset(
                ImageAssets.frameOneFooter,
                color: AppColors.black,
                width: getWidthSize(context),
                height: getWidthSize(context),
              ),
            ),
            // إضافة العناصر الأساسية مثل الأزرار وحقول النص
            Form(
              key: key,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
                    const CustomAppbar(),
                    SizedBox(height: getHeightSize(context) / 9),
                    SizedBox(height: 10.h),
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImageAssets.coloredLogoImage,
                          height: 90.h,
                          width: 100.w,
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Align(
                          alignment: tr.EasyLocalization.of(context)!
                                      .locale
                                      .languageCode ==
                                  'ar'
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Text(
                            "activate_account".tr(),
                            style: getMediumStyle(
                                fontSize: 20.sp * textScaleFactor(context),
                                color: AppColors.black.withOpacity(0.8)),
                          )),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Align(
                          alignment: tr.EasyLocalization.of(context)!
                                      .locale
                                      .languageCode ==
                                  'ar'
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Text(
                            "message_of_activate".tr(),
                            style: getMediumStyle(
                                fontSize: 15.sp,
                                color: AppColors.black.withOpacity(0.8)),
                          )),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                        child: CustomPinCode(
                            enabled: state is! LoadingVOtpState,
                            controller: cubit.verifyController)),
                    SizedBox(height: 20.h),
                    state is LoadingVOtpState
                        ?  Center(
                            child: CustomLoadingIndicator(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Row(
                                    children: [
                                      Text(
                                          '${cubit.minutes.toString()}:${cubit.seconds.toString()}'),
                                      TextButton(
                                        onPressed: () {
                                          if (cubit.minutes == 0 &&
                                              cubit.seconds == 0) {
                                            cubit.sendOtp(context, widget.args,
                                                isResetpassword: widget.args
                                                            .typeOfVerification ==
                                                        'change_email'
                                                    ? false
                                                    : true,
                                                sendOtp: true);
                                            log('===>> || <<===');
                                          } else {
                                            errorGetBar('expire_msg'.tr());
                                          }
                                          //!
                                        },
                                        child: Text('resend'.tr()),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomButton(
                                    widget: Row(
                                      children: [
                                        Text(
                                          "activate".tr(),
                                          style: getRegularStyle(
                                              color: AppColors.white),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Icon(Icons.arrow_forward,
                                            color: AppColors.white),
                                      ],
                                    ),
                                    onTap: () {
                                      if (cubit.verifyController.text.isEmpty ||
                                          cubit.verifyController.text.length <
                                              6) {
                                        errorGetBar('Invalid_Pin_Code'.tr());
                                      } else {
                                        cubit.verifyOtp(context, widget.args);
                                      }
                                    })
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
