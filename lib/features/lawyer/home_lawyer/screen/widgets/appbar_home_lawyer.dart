import 'package:ataaby/core/exports.dart';

class AppbarHomeLawyer extends StatelessWidget {
  const AppbarHomeLawyer({
    super.key,
    required this.widget,
    required this.textCenter,
    required this.heightContainer,
    required this.bottom,
  });
  final Widget widget;
  final Widget textCenter;
  final double heightContainer;
  final double bottom;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: Stack(
            children: [
              Image.asset(
                ImageAssets.appbarImage,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 10.0.h, top: 30.0.h, right: 5.w, left: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      ImageAssets.coloredLogoImage,
                      height: 60.h,
                      width: 60.w,
                      color: AppColors.white,
                    ),
                    textCenter,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.chatRoom,
                                arguments: true);
                          },
                          child: SvgPicture.asset(
                            ImageAssets.messageIcon,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.notificationRoute,
                                arguments: true);
                          },
                          child: SvgPicture.asset(
                            ImageAssets.notificationIcon,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 12.0.w,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1, 1),
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                8.sp * textScaleFactor(context),
              )),
          width: getWidthSize(context),
          height: heightContainer,
          child: widget,
        ),
      ],
    );
  }
}
