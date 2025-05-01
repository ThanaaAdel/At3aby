import 'package:ataaby/core/exports.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingIndicator extends StatelessWidget {
  CustomLoadingIndicator({super.key, this.color});
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30.w,
        width: 30.w,
        child: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            strokeWidth: 4,
            colors: [
              color ?? AppColors.primary,
            ],
            backgroundColor: AppColors.transparent,
            pathBackgroundColor: AppColors.transparent),
      ),
    );
  }
}
