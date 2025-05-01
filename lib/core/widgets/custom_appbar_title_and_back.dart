import '../exports.dart';

class CustomAppBarTitleAndbackButton extends StatelessWidget {
  const CustomAppBarTitleAndbackButton({
    super.key,
    required this.isLawyer,
    required this.title,
  });

  final bool isLawyer;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidthSize(context),
      margin: EdgeInsets.only(bottom: 0.h),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            child: Image.asset(
              isLawyer
                  ? ImageAssets.appbarImage
                  : ImageAssets.appbarHomeCustomerImage,
              height: 100.h,
              fit: BoxFit.cover,
              width: getWidthSize(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: 10.0.h, top: 30.0.h, right: 5.w, left: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.white.withOpacity(0.2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: getBoldStyle(color: AppColors.white),
                ),
                Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
