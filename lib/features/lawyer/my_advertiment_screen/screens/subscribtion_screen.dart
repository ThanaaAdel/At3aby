import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/lawyer/my_advertiment_screen/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/my_advertiment_screen/cubit/state.dart';
import 'package:ataaby/features/lawyer/packages/screens/widget/custom_container_package.dart';
import 'package:ataaby/features/login/screens/login.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/custom_appbar_title_and_back.dart';

class SubscribtionScreen extends StatefulWidget {
  const SubscribtionScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;

  @override
  State<SubscribtionScreen> createState() => _SubscribtionScreenState();
}

class _SubscribtionScreenState extends State<SubscribtionScreen> {
  @override
  initState() {
    super.initState();
    context.read<MyAdvertismentCubit>().getLawyerAdPackages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyAdvertismentCubit, MyAdvertismentState>(
          builder: (context, state) {
        var cubit = context.read<MyAdvertismentCubit>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarTitleAndbackButton(
                title: 'subscribtion'.tr(),
                isLawyer: widget.args.indexPageClientOrLawyer == 1),
            SizedBox(
              height: 40.h,
            ),
            (state is LoadingLawyerAdPackagesState)?
                Center(child: CustomLoadingIndicator(),):
            (cubit.getLawyerAdPackagesModel?.data?.length == 0)?
                Center(child: Text("no_subscribtion".tr()),):
            Flexible(
              child: ListView.builder(
                itemCount: cubit.getLawyerAdPackagesModel?.data?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.myAdvertismentRoute,
                          arguments: cubit.getLawyerAdPackagesModel?.data?[index].packageId.toString());
                    },
                    child:  ContainerOfPackage(
                      height: 125.h,
                      widgetOne: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MySvgWidget(
                                    path: ImageAssets.calendarIcon,
                                    imageColor: AppColors.primary,
                                    size: 20.w),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 8.0.w,
                                    bottom: 12.h,
                                  ),
                                  child: Text(
                                    'من : ${cubit.getLawyerAdPackagesModel?.data?[index].startDate}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: AppStrings.fontFamily,
                                      color: AppColors.textGreyColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Text(
                               "monthly_package".tr(),
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: AppStrings.fontFamily,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            Text(
                              '${cubit.getLawyerAdPackagesModel?.data?[index].numberOfAds??0} اعلانات فى الشهر ',
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: AppStrings.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.textGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      widgetTwo: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MySvgWidget(
                                    path: ImageAssets.calendarIcon,
                                    imageColor: AppColors.primary,
                                    size: 20.w),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 8.0.w,
                                    bottom: 12.h,
                                  ),
                                  child: Text(
                                    '   الي : ${cubit.getLawyerAdPackagesModel?.data?[index].endDate}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: AppStrings.fontFamily,
                                      color: AppColors.textGreyColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Text(
                                'reset_advertisment'.tr(),
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: AppStrings.fontFamily,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            Text(
                              "${cubit.getLawyerAdPackagesModel?.data?[index].numberOfBumps??0} اعلانات",
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: AppStrings.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.textGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  );
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
