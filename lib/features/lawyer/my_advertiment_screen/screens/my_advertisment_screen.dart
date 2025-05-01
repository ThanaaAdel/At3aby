import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/lawyer/packages/screens/widget/custom_container_package.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/custom_appbar_title_and_back.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class MyAdvertismentScreen extends StatefulWidget {
  const MyAdvertismentScreen({super.key, required this.idFromPackage});
  final String idFromPackage;

  @override
  State<MyAdvertismentScreen> createState() => _MyAdvertismentScreenState();
}

class _MyAdvertismentScreenState extends State<MyAdvertismentScreen> {
  @override
  initState() {
    super.initState();
    context
        .read<MyAdvertismentCubit>()
        .getLawyerAdPackagesDetails(idFromPackage: widget.idFromPackage);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MyAdvertismentCubit>();
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.addAdvertismentRoute,
              arguments:widget.idFromPackage);
        },
        child: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text("+",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      body: BlocBuilder<MyAdvertismentCubit, MyAdvertismentState>(
          builder: (context, state) {
        var cubit = context.read<MyAdvertismentCubit>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarTitleAndbackButton(
                title: 'my_advertisment'.tr(), isLawyer: true),
            SizedBox(
              height: 40.h,
            ),
            (state is LoadingLawyerPackageAdsState)
                ? Center(
                    child: CustomLoadingIndicator(),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        ContainerOfPackage(
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
                                        'من : ${cubit.getLawyerPackageAdsModelDetails?.data?.package?.fromDate.toString()}',
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
                                    'monthly_package'.tr(),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: AppStrings.fontFamily,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${cubit.getLawyerPackageAdsModelDetails?.data?.package?.numberOfAds??0} اعلانات فى الشهر',
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
                                        '   الي : ${cubit.getLawyerPackageAdsModelDetails?.data?.package?.toDate.toString()}',
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
                                  "${cubit.getLawyerPackageAdsModelDetails?.data?.package?.numberOfBumps??0} اعلانات",
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
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.getLawyerPackageAdsModelDetails
                                ?.data?.ads?.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  cubit.getLawyerPackageAdsModelDetails?.data
                                              ?.ads?[index].image ==
                                          null
                                      ? Image.asset(
                                          "assets/images/test_swiper.png",
                                          height: 120.h,
                                          width: double.infinity,
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.w,
                                              right: 5.w,
                                              top: 10.h,
                                              bottom: 10.h),
                                          child: Image.network(
                                            cubit.getLawyerPackageAdsModelDetails
                                                    ?.data?.ads?[index].image
                                                    .toString() ??
                                                "",
                                            height: 120.h,
                                            width: double.infinity,
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.date_range,
                                              size: 15.sp,
                                              color: AppColors.primary,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              "تاريخ الانتهاء : ${cubit.getLawyerPackageAdsModelDetails?.data?.ads?[index].toDate.toString().substring(0, 10)}",
                                              style: TextStyle(
                                                  color: AppColors.gray,
                                                  fontSize: 13.sp,
                                                  fontFamily:
                                                      AppStrings.fontFamily),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(5.sp)),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 5.w,
                                                right: 5.w,
                                                top: 2.h,
                                                bottom: 2.h),
                                            child: Center(
                                              child: Text(
                                                cubit
                                                        .getLawyerPackageAdsModelDetails
                                                        ?.data
                                                        ?.ads?[index]
                                                        .status ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: AppColors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        );
      }),
    );
  }
}
