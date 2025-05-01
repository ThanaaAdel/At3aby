import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/utils/password_valdation.dart';
import '../../login/screens/login.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
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
                    height: 30.h,
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
                    controller: cubit.passwordController,
                    isPassword: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(ImageAssets.passwordIcon),
                    ),
                    validator: (value) {
                      return passwordValidator(value);
                    },
                    hintText: "new_password".tr(),
                    titleFromTextFormField: "new_password".tr(),
                  ),
                  CustomTextField(
                    controller: cubit.confirmPasswordController,
                    isPassword: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(ImageAssets.passwordIcon),
                    ),
                    validator: (value) {
                      return passwordValidator(value);
                    },
                    hintText: "confirm_password".tr(),
                    titleFromTextFormField: "confirm_password".tr(),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  state is LoadingResetPassword
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
                                        "reset_password".tr(),
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
                                    if (cubit.passwordController.text ==
                                        cubit.confirmPasswordController.text) {
                                      cubit.resetPassword(context, widget.args);
                                      //!Apply change password [ send email and password]
                                    } else {
                                      errorGetBar(
                                          'password_and_confirm_not_identical'
                                              .tr());
                                    }
                                  })
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
