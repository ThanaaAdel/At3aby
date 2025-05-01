import 'package:ataaby/core/exports.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/widgets/appbar_with_image.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key, required this.isLawyer});
  final bool isLawyer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppbarContainImage(
            isLawyer: isLawyer ? true : false,
            titleCenter: "about_app_Ataaby".tr(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Image.asset(
                    ImageAssets.coloredLogoImage,
                    width: 120.w,
                    height: 100.h,
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "about_app_Ataaby".tr(),
                          textAlign: TextAlign.center,
                          style: getRegularStyle(
                              color: AppColors.black, fontSize: 25.sp),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "محامي بالنقض العام خبره اكتر من ١٥ سنة في جميع انواع القضايا الجنائية والجنح والاسره وغيرها من التحديات التي تواجهه عملائنا في جميع نواحي حياتهم اليومية سوف نصل الي بر الامان سويا. محامي بالنقض العام خبره اكتر من ١٥ سنة في جميع انواع القضايا الجنائية والجنح والاسره وغيرها من التحديات التي تواجهه عملائنا في جميع نواحي حياتهم اليومية سوف نصل الي بر الامان سويا."
                              .tr(),
                          style: getRegularStyle(
                            color: AppColors.gray,
                            fontSize: 14.sp * textScaleFactor(context),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "what_we_do".tr(),
                          style: getRegularStyle(
                              color: AppColors.black, fontSize: 25.sp),
                        ),
                        Text(
                          "محامي بالنقض العام خبره اكتر من ١٥ سنة في جميع انواع القضايا الجنائية والجنح والاسره وغيرها من التحديات التي تواجهه عملائنا في جميع نواحي حياتهم اليومية سوف نصل الي بر الامان سويا. محامي بالنقض العام خبره اكتر من ١٥ سنة في جميع انواع القضايا الجنائية والجنح والاسره وغيرها من التحديات التي تواجهه عملائنا في جميع نواحي حياتهم اليومية سوف نصل الي بر الامان سويا.",
                          style: getRegularStyle(
                            color: AppColors.gray,
                            fontSize: 14.sp * textScaleFactor(context),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
