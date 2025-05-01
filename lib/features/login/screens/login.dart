import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/login/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';

import '../cubit/cubit.dart';

class ChooseTypeRegisterArgs {
  final int indexPageClientOrLawyer;
  final String? typeOfVerification;
  ChooseTypeRegisterArgs(
      {required this.indexPageClientOrLawyer, this.typeOfVerification = ''});
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
        var cubit = context.read<LoginCubit>();
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
            Form(
              key: key,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    const CustomAppbar(),
                    SizedBox(height: getHeightSize(context) / 9),
                    SizedBox(height: 10.h),
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImageAssets.coloredLogoImage,
                          height: isMobileDevice(context) ? 120.h : 50.sp,
                        )),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Align(
                          alignment: EasyLocalization.of(context)!
                                      .locale
                                      .languageCode ==
                                  'en'
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Text(
                            "login".tr(),
                            style: getBoldStyle(
                                fontSize: 20.sp * textScaleFactor(context),
                                color: AppColors.black.withOpacity(0.8)),
                          )),
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
                      hintText: "email".tr(),
                      titleFromTextFormField: "email".tr(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: cubit.passwordController,
                      isPassword: true,
                      validator: (value) {
                        return null;
                      
                        //return passwordValidator(value);
                      },
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(ImageAssets.passwordIcon),
                      ),
                      hintText: "password".tr(),
                      titleFromTextFormField: "password".tr(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.forgetPasswordRoute,
                            arguments: widget.args);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "forget_password".tr(),
                              style: getUnderLine(),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    (state is LoadingLoginState)
                        ? CustomLoadingIndicator()
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // 0 موكل
                                // 1 محامي
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.newRegisterRoute,
                                          arguments: widget.args);
                                    },
                                    child: RichText(
                                        text: TextSpan(
                                      children: [
                                        widget.args.indexPageClientOrLawyer == 0
                                            ? TextSpan(
                                                text: "register_by_client".tr(),
                                                style: getRegularStyle(
                                                    color: AppColors.gray,
                                                    fontSize: 15.sp),
                                              )
                                            : TextSpan(
                                                text: "register_by_lawyer".tr(),
                                                style: getRegularStyle(
                                                    color: AppColors.gray,
                                                    fontSize: 15.sp),
                                              ),
                                        TextSpan(
                                          text: "register_now".tr(),
                                          style: getRegularStyle(
                                              color: AppColors.primary,
                                              fontSize: 15.sp),
                                        )
                                      ],
                                    )),
                                  ),
                                ),
                                CustomButton(
                                    widget: Row(
                                      children: [
                                        Text(
                                          "enter".tr(),
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
                                      if (key.currentState!.validate()) {
                                        cubit.mainLogin(context, widget.args);
                                      }
                                    })
                              ],
                            ),
                          ),
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
