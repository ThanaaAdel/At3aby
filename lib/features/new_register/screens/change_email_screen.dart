import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/login/screens/login.dart';
import 'package:ataaby/features/new_register/cubit/cubit.dart';
import 'package:ataaby/features/new_register/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/widgets/appbar_with_image.dart';

class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({super.key, required this.isLawyer});
  final bool isLawyer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewRegisterCubit, NewRegisterState>(
          builder: (context, state) {
        var cubit = context.read<NewRegisterCubit>();

        return SingleChildScrollView(
          child: Column(
            children: [
              AppbarContainImage(
                  isLawyer: isLawyer, titleCenter: "change_email".tr()),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                  controller: cubit.emailController,
                  titleFromTextFormField: "email".tr(),
                  isPassword: false,
                  enabled:
                      !(state is LoadingVOtpState || state is LoadingOtpState),
                  hintText: "email".tr(),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "enter_valid_email".tr();
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(p0)) {
                      return "enter_valid_email".tr();
                    } else {
                      return null;
                    }
                  }),
              SizedBox(
                height: 20.h,
              ),
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
                              "change".tr(),
                              style: getRegularStyle(color: AppColors.white),
                            )),
                            onTap: () {
                              context.read<NewRegisterCubit>().sendOtp(
                                  context,
                                  ChooseTypeRegisterArgs(
                                      indexPageClientOrLawyer:
                                          isLawyer == true ? 1 : 0,
                                      typeOfVerification: 'change_email'),
                                  isResetpassword: false);
                            },
                          )),
                    )
            ],
          ),
        );
      }),
    );
  }
}
