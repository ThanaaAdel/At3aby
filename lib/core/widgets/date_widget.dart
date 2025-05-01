import 'package:ataaby/core/exports.dart';

String getCurrentFormattedDate() {
  final now = DateTime.now();
  return "${now.day}/${now.month}/${now.year}";
}

class DatePickerField extends StatelessWidget {
  final Function()? onTab;
  final DateTime? selectedDate;
  final String title;
  final bool isWithTime;
  const DatePickerField({
    super.key,
    this.onTab,
    this.selectedDate,
    this.isWithTime = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.sp * textScaleFactor(context),
          ),
          Text(
            title,
            style:
                getRegularStyle(fontSize: 16.sp, color: AppColors.blackLight),
          ),
          SizedBox(
            height: 10.sp * textScaleFactor(context),
          ),
          GestureDetector(
            onTap: onTab,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grayLite),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate != null
                        ? isWithTime
                            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}\n${selectedDate!.hour}:${selectedDate!.minute}'
                            : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        : "يوم / شهر / سنه",
                    style:
                        getRegularStyle(fontSize: 16.sp, color: AppColors.gray),
                  ),
                  SvgPicture.asset(ImageAssets.dateIcon),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
