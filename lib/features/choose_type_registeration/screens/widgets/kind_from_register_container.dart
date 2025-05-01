import 'package:ataaby/core/exports.dart';

import '../../cubit/cubit.dart';

class KindFromRegisterContainer extends StatelessWidget {
  const KindFromRegisterContainer({
    super.key,
    required this.titleFromKindFromRegister,
    required this.iconFromKindFromRegister,
    this.onTapFromArrow,
    this.color,
    required this.cubit,
    this.onTapFromContainer,
  });
  final String titleFromKindFromRegister;
  final String iconFromKindFromRegister;
  final void Function()? onTapFromContainer;
  final void Function()? onTapFromArrow;
  final Color? color;
  final ChooseTypeRegisterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFromContainer,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12.r,
            ),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.grayLite,
                offset: const Offset(1, 4),
                blurRadius: 10,
                blurStyle: BlurStyle.outer,
              )
            ]),
        child: Column(
          children: [
            SvgPicture.asset(
              iconFromKindFromRegister,
              height: isMobileDevice(context) ? 80.h : 50.sp,
              color: color,
            ),
            SizedBox(height: 10.h),
            Text(titleFromKindFromRegister),
            SizedBox(height: 10.h),
            CustomButton(
                paddingButton: EdgeInsets.only(
                    left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
                onTap: onTapFromArrow,
                widget: Icon(
                  Icons.arrow_forward,
                  color: AppColors.white,
                  size: isMobileDevice(context) ? 30.h : 18.h,
                )),
          ],
        ),
      ),
    );
  }
}
