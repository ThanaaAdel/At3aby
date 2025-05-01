import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';

class CustomShowDialog extends StatelessWidget {
  CustomShowDialog(
      {super.key,
      required this.widget,
      required this.titleButton,
      this.isLoading = false,
      this.onTap});
  final Widget widget;
  final String titleButton;
  bool? isLoading;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // clipBehavior: Clip.none,
          children: [
            widget,
            InkWell(
              onTap: onTap,
              child: Center(
                child: CustomButton(
                  paddingButton: EdgeInsets.symmetric(
                    horizontal: 10.0.w,
                    vertical: 10.h,
                  ),
                  widget: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: isLoading == true
                        ? Center(
                            child: CustomLoadingIndicator(
                              color: AppColors.white,
                            ),
                          )
                        : Text(
                            titleButton,
                            style: getRegularStyle(color: AppColors.white),
                          ),
                  ),
                  onTap: onTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
