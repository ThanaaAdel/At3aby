import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/courts/the_courts/screen/the_courts_customer_screen.dart';
import 'package:ataaby/features/customer/home_customer/screen/home_customer.dart';
import 'package:ataaby/features/customer/main_customer/cubit/cubit.dart';
import 'package:ataaby/features/customer/main_customer/cubit/state.dart';
import 'package:ataaby/features/customer/profile_customer/Screen/profile_customer_screen.dart';
import 'package:ataaby/features/login/screens/login.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../lawyers/screen/lawyers_screen.dart';

class MainCustomerScreen extends StatefulWidget {
  const MainCustomerScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;
  @override
  State<MainCustomerScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainCustomerScreen> {
  int _currentIndex = 0;
  final List<Widget> _buildScreens = [
    const HomeCustomerScreen(),
    const LawyersScreen(),
    const TheCourtsCustomerScreen(),
    const ProfileCustomerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCustomerCubit, MainCustomerState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildScreens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: AppColors.white,
              unselectedItemColor: AppColors.gray,
              selectedItemColor: AppColors.black.withOpacity(0.9),
              unselectedLabelStyle: getRegularStyle(fontSize: 12.sp),
              selectedLabelStyle: getRegularStyle(fontSize: 12.sp),
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageAssets.homeIcon,
                    color:
                        _currentIndex == 0 ? AppColors.primary : AppColors.gray,
                  ),
                  label: ("home".tr()),
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      ImageAssets.lawyersMenuIcon,
                      color: _currentIndex == 1
                          ? AppColors.primary
                          : AppColors.gray,
                    ),
                    label: "lawyers".tr()),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      ImageAssets.marketIcon,
                      color: _currentIndex == 2
                          ? AppColors.primary
                          : AppColors.gray,
                    ),
                    label: "issues".tr()),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      ImageAssets.userIcon,
                      color: _currentIndex == 3
                          ? AppColors.primary
                          : AppColors.gray,
                    ),
                    label: "my_profile".tr()),
              ]),
        );
      },
    );
  }
}
