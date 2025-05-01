import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/login/screens/login.dart';
import 'package:ataaby/features/new_register/cubit/state.dart';
import '../cubit/cubit.dart';

import 'package:easy_localization/easy_localization.dart';
import '../../../core/utils/custom_loading.dart';
import '../../../core/utils/password_valdation.dart';

class NewRegisterScreen extends StatefulWidget {
  const NewRegisterScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;

  @override
  State<NewRegisterScreen> createState() => _NewRegisterScreenState();
}

class _NewRegisterScreenState extends State<NewRegisterScreen> {
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
                    100.h.verticalSpace,
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImageAssets.coloredLogoImage,
                          height: 90.h,
                          width: 100.w,
                        )),
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
                            "new_account".tr(),
                            style: getBoldStyle(
                                fontSize: 20.sp * textScaleFactor(context),
                                color: AppColors.black.withOpacity(0.8)),
                          )),
                    ),
                    CustomTextField(
                      enabled: state is! LoadingOtpState,
                      controller: cubit.fullNameController,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(ImageAssets.userIcon),
                      ),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "full_name".tr();
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      hintText: "full_name".tr(),
                      titleFromTextFormField: "full_name".tr(),
                    ),
                    CustomTextField(
                      enabled: state is! LoadingOtpState,
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
                      keyboardType: TextInputType.emailAddress,
                      hintText: "email".tr(),
                      titleFromTextFormField: "email".tr(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      enabled: state is! LoadingOtpState,
                      controller: cubit.passwordController,
                      isPassword: true,
                      validator: (value) {
                        return passwordValidator(value);
                      },
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(ImageAssets.passwordIcon),
                      ),
                      hintText: "password".tr(),
                      titleFromTextFormField: "password".tr(),
                    ),
                    SizedBox(
                      height: 30.h,
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
                                CustomButton(
                                    widget: Row(
                                      children: [
                                        Text(
                                          "register_now".tr(),
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
                                        cubit.sendOtp(context, widget.args);
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
