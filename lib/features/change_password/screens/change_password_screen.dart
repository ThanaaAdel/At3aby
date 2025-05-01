import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/change_password/cubit/change_password_cubit.dart';
import 'package:ataaby/features/change_password/cubit/change_password_state.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/widgets/appbar_with_image.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key, required this.isLawyer});
  final bool isLawyer;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ChangePasswordCubit>();
    return Scaffold(
      body: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              AppbarContainImage(
                isLawyer: isLawyer,
                titleCenter: "change_password".tr(),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                controller: cubit.oldPasswordController,
                titleFromTextFormField: "old_password".tr(),
                isPassword: true,
                hintText: "old_password".tr(),
              ),
              CustomTextField(
                controller: cubit.newPasswordController,
                titleFromTextFormField: "new_password".tr(),
                isPassword: true,
                hintText: "new_password".tr(),
              ),
              CustomTextField(
                controller: cubit.confirmPasswordController,
                titleFromTextFormField: "confirm_password".tr(),
                isPassword: true,
                hintText: "confirm_password".tr(),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
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
                        cubit.changePasswordFromLawyer(context);
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
