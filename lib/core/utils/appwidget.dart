import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';

class AppWidget {
  static createProgressDialog(
    BuildContext context,
  ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.transparent,
            content: CustomLoadingIndicator(),
          );
        });
  }
}
