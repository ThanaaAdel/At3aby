import 'package:ataaby/core/exports.dart';

class IssueStatus extends StatelessWidget {
  IssueStatus({
    super.key,
    required this.titles,
    required this.currentIndex,
    required this.onTap,
  });
  void Function(int) onTap;

  List<String> titles;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // var cubit = context.read<IssueStatusCubit>();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(
              8.sp * textScaleFactor(context),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.grayLite, // لون الظل
                spreadRadius: 1, // تمدد الظل
                blurRadius: 5, // تأثير التمويه على الظل
                offset: const Offset(0, 4),
                blurStyle: BlurStyle.outer, //إزاحة الظل (لتحريكه)
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 10.sp * textScaleFactor(context),
                right: 10.sp * textScaleFactor(context),
                top: 5.h,
                bottom: 5.h),
            child: SizedBox(
              height: 50.h,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: titles.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CustomButton(
                    color: currentIndex == index
                        ? AppColors.primary
                        : AppColors.white,
                    shadow: const [],
                    widget: Center(
                        child: Text(
                      titles[index],
                      style: getRegularStyle(
                        color: currentIndex == index
                            ? AppColors.white
                            : AppColors.gray,
                        fontSize: 14.sp * textScaleFactor(context),
                      ),
                    )),
                    onTap: () {
                      onTap(index);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        20.h.verticalSpace,
      ],
    );
  }
}
