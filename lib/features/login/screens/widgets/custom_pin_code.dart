import 'package:ataaby/core/exports.dart';
import 'package:pinput/pinput.dart';

class CustomPinCode extends StatefulWidget {
  CustomPinCode({super.key, this.enabled = true, required this.controller});
  TextEditingController controller;
  bool enabled;
  @override
  State<CustomPinCode> createState() => _CustomPinCodeState();
}

class _CustomPinCodeState extends State<CustomPinCode> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Directionality(
        textDirection: TextDirection.ltr, // Force left-to-right layout

        child: Pinput(
          enabled: widget.enabled,
          controller: widget.controller,
          length: 6,
          animationCurve: Curves.easeInOut,
          pinAnimationType: PinAnimationType.fade,
          animationDuration: const Duration(milliseconds: 0),
          showCursor: true,
          keyboardType: TextInputType.number,
          closeKeyboardWhenCompleted: true,
          submittedPinTheme: PinTheme(
              width: 50.w,
              height: 50.h,
              textStyle: TextStyle(
                color: AppColors.white,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primary),
              )),
          defaultPinTheme: PinTheme(
              width: 50.w,
              height: 50.h,
              textStyle: TextStyle(
                color: AppColors.white,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.grayLiteColor),
              )),
          focusedPinTheme: PinTheme(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primary),
              )),
        ),
      ),
    );
  }
}
