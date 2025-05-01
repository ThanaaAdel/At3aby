import 'package:ataaby/core/exports.dart';

class DetailsIssueWidget extends StatelessWidget {
  const DetailsIssueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          boxShadow: customShadow,
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "تفاصيل عن القضية",
              style: getBoldStyle(fontSize: 13.sp, color: AppColors.blackLight),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "محامي بالنقض العام خبره اكتر من ١٥ سنة في جميع انواع القضايا الجنائية والجنح والاسره وغيرها من التحديات التي تواجهه عملائنا في جميع نواحي حياتهم اليومية سوف نصل الي بر الامان سويا.",
              style: getBoldStyle(
                  fontSize: 14.sp * textScaleFactor(context),
                  color: AppColors.gray),
            )
          ],
        ),
      ),
    );
  }
}
