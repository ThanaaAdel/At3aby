import 'package:ataaby/core/exports.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/widgets/appbar_with_image.dart';
import '../../../../core/widgets/switch_widget.dart';

class SettingCustomerScreen extends StatelessWidget {
  const SettingCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AppbarContainImage(
          isLawyer: false,
          titleCenter: "setting".tr(),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "alerts".tr(),
                  style: getBoldStyle(
                      color: AppColors.blackLight, fontSize: 15.sp),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 15.h, bottom: 15.h),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: customShadow,
                          borderRadius: BorderRadius.circular(
                            8.sp * textScaleFactor(context),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "تفعيل تنبيهات القضايا",
                              style: getBoldStyle(
                                  color: AppColors.primary, fontSize: 15.sp),
                            ),
                            StyledSwitch(
                              status:true,
                              onToggled: (bool isToggled) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
