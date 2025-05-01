import 'package:ataaby/core/exports.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    this.titleCenter,
    this.widget,
    this.onTap,
  });
  final String? titleCenter;
  final Widget? widget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap ??
                () {
                  Navigator.pop(context);
                },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: AppColors.white.withOpacity(0.2)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Text(
            titleCenter ?? "",
            style: getBoldStyle(
              color: AppColors.white,
              fontSize: 16.sp * textScaleFactor(context),
            ),
          ),
          widget ?? Container(),
        ],
      ),
    );
  }
}
