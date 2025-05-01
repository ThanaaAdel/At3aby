import 'package:ataaby/core/exports.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.title,
    this.centerText,
    this.onTap,
  });

  final String title;
  final String? centerText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
            boxShadow: customShadow,
          ),
          child: Padding(
            padding:
                EdgeInsets.only(top: 5.h, bottom: 5.h, left: 0.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: 14.sp * textScaleFactor(context),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      centerText ?? "",
                      style: getUnderLine(
                        color: AppColors.primary,
                        fontSize: 14.sp * textScaleFactor(context),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14.sp * textScaleFactor(context),
                          color: AppColors.gray,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
