import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/exports.dart';
import '../../data/model/main_sos_court.dart';

class SosCartWidget extends StatelessWidget {
  final MainSosCourtCasesModelDatum? sosCourt;

  const SosCartWidget({super.key, required this.sosCourt});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMEd('en')
                      .format(sosCourt?.createdAt ?? DateTime.now()),
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.secondPrimary,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, bottom: 8.h, top: 8.h),
                    // states by colors
                    decoration: BoxDecoration(
                      color: AppColors.textGreyColor.withOpacity(0.2),
                      boxShadow: customShadow,
                      borderRadius: BorderRadius.circular(
                          8.sp * textScaleFactor(context)),
                    ),
                    child: Center(
                      child: Text(
                        sosCourt?.status ?? '',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp * textScaleFactor(context)),
                      ),
                    )),
              ],
            ),
            8.h.verticalSpace,
            Text(
              sosCourt?.problem ?? '',
              style: TextStyle(fontSize: 14.sp),
            ),
            // 8.h.verticalSpace,
            // Text(
            //   '${'phone'.tr()}: ${sosCourt?.phone ?? ''}',
            //   style: TextStyle(fontSize: 14.sp),
            // ),
            // 8.h.verticalSpace,
            // Text(
            //   '${'address'.tr()}: ${sosCourt?.address}',
            //   style: TextStyle(fontSize: 14.sp),
            // ),
            // 8.h.verticalSpace,
            // Text(
            //   '${'Created_At'.tr()}: ${formatDate(sosCourt?.createdAt ?? DateTime.now())}',
            //   style: TextStyle(fontSize: 14.sp),
            // ),
          ],
        ),
      ),
    );
  }
}

String formatDate(DateTime parsedDate) {
  // Format the date for better readability
  // DateTime parsedDate = DateTime.parse(dateTime);
  return "${parsedDate.year}-${parsedDate.month}-${parsedDate.day} ${parsedDate.hour}:${parsedDate.minute}";
}
