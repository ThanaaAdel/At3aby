import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/main_lawyer/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/main_lawyer/cubit/state.dart';
import 'package:ataaby/features/login/screens/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class MainLawyerScreen extends StatefulWidget {
  const MainLawyerScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;
  @override
  State<MainLawyerScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainLawyerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLawyerCubit, MainLawyerState>(
      builder: (context, state) {
        var cubit = context.read<MainLawyerCubit>();
        return WillPopScope(
          onWillPop: () async {
            if (cubit.currentIndex == 0) {
              SystemNavigator.pop();
            } else {
              setState(() {
                cubit.currentIndex = 0;
              });
            }
            return false;
          },
          child: Scaffold(
            body: cubit.buildScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: AppColors.white,
              unselectedItemColor: AppColors.gray,
              selectedItemColor: AppColors.black.withOpacity(0.9),
              unselectedLabelStyle: getRegularStyle(fontSize: 12.sp),
              selectedLabelStyle: getRegularStyle(fontSize: 12.sp),
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                setState(() {
                  cubit.currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageAssets.homeIcon,
                    color: cubit.currentIndex == 0
                        ? AppColors.primary
                        : AppColors.gray,
                  ),
                  label: 'published_issues'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageAssets.lowBalanceIcon,
                    height: 20.h,
                    color: cubit.currentIndex == 1
                        ? AppColors.primary
                        : AppColors.gray,
                  ),
                  label: 'current_issues'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageAssets.marketIcon,
                    color: cubit.currentIndex == 2
                        ? AppColors.primary
                        : AppColors.gray,
                  ),
                  label: 'super_market_bliss'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageAssets.myProfileGrayIcon,
                    color: cubit.currentIndex == 3
                        ? AppColors.primary
                        : AppColors.gray,
                  ),
                  label: 'my_profile'.tr(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
