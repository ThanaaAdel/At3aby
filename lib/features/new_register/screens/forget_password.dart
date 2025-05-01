import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';

import 'package:ataaby/features/login/screens/login.dart';
import 'package:easy_localization/easy_localization.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<NewRegisterCubit, NewRegisterState>(
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
              color: AppColors.black,
              ImageAssets.frameOneFooter,
              width: getWidthSize(context),
              height: getWidthSize(context),
            ),
          ),
          // إضافة العناصر الأساسية مثل الأزرار وحقول النص
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                const CustomAppbar(),
                SizedBox(height: getHeightSize(context) / 9),
                SizedBox(
                  height: 10.h,
                ),
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
                      alignment:
                          EasyLocalization.of(context)!.locale.languageCode ==
                                  'en'
                              ? Alignment.topLeft
                              : Alignment.topRight,
                      child: Text(
                        "do_forget".tr(),
                        style: getBoldStyle(
                            fontSize: 20.sp * textScaleFactor(context),
                            color: AppColors.black.withOpacity(0.8)),
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),

                CustomTextField(
                  controller: cubit.emailController,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(ImageAssets.emailIcon),
                  ),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "enter_valid_email".tr();
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(p0)) {
                      return "enter_valid_email".tr();
                    } else {
                      return null;
                    }
                  },
                  enabled: state is! LoadingOtpState,
                  hintText: "email".tr(),
                  titleFromTextFormField: "email".tr(),
                ),
                SizedBox(
                  height: 10.h,
                ),
                state is LoadingOtpState
                    ? Center(
                        child: CustomLoadingIndicator(),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // 0 موكل لكن 1 محامي

                            CustomButton(
                                widget: Row(
                                  children: [
                                    Text(
                                      "send_code".tr(),
                                      style: getRegularStyle(
                                          color: AppColors.white),
                                    ),
                                    10.w.horizontalSpace,
                                    Icon(Icons.arrow_forward,
                                        color: AppColors.white),
                                  ],
                                ),
                                onTap: () {
                                  cubit.sendOtp(
                                      context,
                                      ChooseTypeRegisterArgs(
                                          indexPageClientOrLawyer: widget
                                              .args.indexPageClientOrLawyer,
                                          typeOfVerification:
                                              'forget_password'),
                                      isResetpassword: true);
                                })
                          ],
                        ),
                      ),
                // const Spacer(),
              ],
            ),
          ),
        ],
      );
    }));
  }
}
