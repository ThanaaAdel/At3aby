
import 'package:ataaby/core/exports.dart';

createProgressDialog(BuildContext context, String msg) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        content: Row(
          children: [
            CircularProgressIndicator(
              color: AppColors.primary,
            ),
            SizedBox(
              width: 16.0.w,
            ),
            Text(
              msg,
              style: TextStyle(color: AppColors.black, fontSize: 15.0),
            )
          ],
        ),
      );
    },
  );
}
