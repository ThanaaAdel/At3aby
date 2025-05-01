import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/choose_type_registeration/cubit/state.dart';
import 'package:ataaby/features/choose_type_registeration/screens/widgets/kind_from_register_container.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../login/screens/login.dart';
import '../cubit/cubit.dart';

class ChooseTypeRegisterScreen extends StatefulWidget {
  const ChooseTypeRegisterScreen({super.key});
  @override
  State<ChooseTypeRegisterScreen> createState() =>
      _ChooseTypeRegisterScreenState();
}

class _ChooseTypeRegisterScreenState extends State<ChooseTypeRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChooseTypeRegisterCubit, ChooseTypeRegisterState>(
          builder: (context, state) {
        var cubit = context.read<ChooseTypeRegisterCubit>();
        return Stack(
          alignment: Alignment.center,
          children: [
            // خلفية أو صورة SVG في الأعلى
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(
                ImageAssets.headerLoginIcon,
                width: 300.w,
                height: 462.h,
              ),
            ),
            // إضافة SplashFrameOne في الأسفل
            Positioned(
              bottom: -70,
              child: Image.asset(
                color: AppColors.black,
                ImageAssets.frameOneFooter,
                width: getWidthSize(context),
                height: getWidthSize(context),
              ),
            ),
            // إضافة العناصر الأساسية مثل الأزرار وحقول النص
            Center(
              child: SingleChildScrollView(
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 20.h.verticalSpace,
                      Image.asset(ImageAssets.coloredLogoImage,
                          height: isMobileDevice(context) ? 180.h : 90.h,
                          width: isMobileDevice(context) ? 200.h : 100.w),
                      30.h.verticalSpace,
                      Text(
                        "choose_type_register".tr(),
                        style: getMediumStyle(
                            fontSize: isMobileDevice(context) ? 40.h : 20.sp,
                            color: AppColors.black.withOpacity(0.8)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            KindFromRegisterContainer(
                              cubit: cubit,
                              color: cubit.currentIndex == 0
                                  ? AppColors.primary
                                  : AppColors.secondPrimary.withOpacity(0.9),
                              titleFromKindFromRegister: "client".tr(),
                              iconFromKindFromRegister:
                                  ImageAssets.myProfileGrayIcon,
                              onTapFromContainer: () {
                                cubit.changeIndex(0);
                              },
                              onTapFromArrow: () {
                                cubit.changeIndex(0);
                                Navigator.pushNamed(context, Routes.loginRoute,
                                    arguments: ChooseTypeRegisterArgs(
                                        indexPageClientOrLawyer: 0));
                              },
                            ),
                            KindFromRegisterContainer(
                              cubit: cubit,
                              color: cubit.currentIndex == 1
                                  ? AppColors.primary
                                  : AppColors.secondPrimary.withOpacity(0.9),
                              titleFromKindFromRegister: "lawyer".tr(),
                              iconFromKindFromRegister:
                                  ImageAssets.lowBalanceIcon,
                              onTapFromContainer: () {
                                cubit.changeIndex(1);
                              },
                              onTapFromArrow: () {
                                cubit.changeIndex(1);
                                Navigator.pushNamed(context, Routes.loginRoute,
                                    arguments: ChooseTypeRegisterArgs(
                                        indexPageClientOrLawyer: 1));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
