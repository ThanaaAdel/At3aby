import '../exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.widget,
    this.paddingButton,
    this.color,
    this.border,
    this.width,
    this.shadow,
  });

  final void Function()? onTap;
  final EdgeInsetsGeometry? paddingButton;
  final Widget widget;
  final Color? color;
  final Border? border;
  final double? width;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(getWidthSize(context) / 50),
      child: Container(
        width: width,
        padding: paddingButton ??
            EdgeInsets.only(
              top: 15.h,
              bottom: 15.h,
              right: 20.w,
              left: 20.w,
            ),
        decoration: BoxDecoration(
          border: border,
          shape: BoxShape.rectangle,
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: shadow ??
              [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2), // لون الظل
                  blurStyle: BlurStyle.inner,
                  spreadRadius: 1, // تمدد الظل
                  blurRadius: 5, // تأثير التمويه على الظل
                  offset: const Offset(0, 2), // إزاحة الظل (لتحريكه)
                ),
              ],
        ),
        child: widget,
      ),
    );
  }
}
