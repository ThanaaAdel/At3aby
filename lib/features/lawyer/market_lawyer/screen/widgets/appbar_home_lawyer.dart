import 'package:ataaby/core/exports.dart';

class MainAppBarHomeWidget extends StatelessWidget {
  MainAppBarHomeWidget({
    super.key,
    required this.widget,
    this.actionWidget,
    required this.textCenter,
    this.isLawyer = false,
    this.isSearchWidget = false,
    this.isBackButton,
  });
  final Widget widget;
  Widget? actionWidget;

  final Widget textCenter;
  final bool? isLawyer;
  final bool isSearchWidget;
  bool? isBackButton;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidthSize(context),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: getWidthSize(context),
            margin: EdgeInsets.only(bottom: 25.h),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                  child: Image.asset(
                    isLawyer!
                        ? ImageAssets.appbarImage
                        : ImageAssets.appbarHomeCustomerImage,
                    height: isBackButton != null ? 100.h : 150.h,
                    fit: isLawyer! ? BoxFit.cover : BoxFit.cover,
                    width: getWidthSize(context),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 10.0.h, top: 30.0.h, right: 5.w, left: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isBackButton == true
                          ? GestureDetector(
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
                            )
                          : Image.asset(
                              ImageAssets.coloredLogoImage,
                              height: 60.h,
                              width: 60.w,
                              color: AppColors.white,
                            ),
                      textCenter,
                      actionWidget ??
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.chatRoom,
                                      arguments: false);
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
                                      arguments: isLawyer);
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
          isSearchWidget == true
              ? widget
              : Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0.w,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        8.sp * textScaleFactor(context),
                      )),
                  width: getWidthSize(context),
                  height: 70.h,
                  child: widget,
                ),
        ],
      ),
    );
  }
}
