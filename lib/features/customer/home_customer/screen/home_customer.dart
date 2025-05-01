import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/customer/home_customer/cubit/cubit.dart';
import 'package:ataaby/features/customer/home_customer/cubit/state.dart';
import 'package:ataaby/features/customer/home_customer/screen/widgets/lawer_item.dart';
import 'package:ataaby/features/lawyer/market_lawyer/screen/widgets/appbar_home_lawyer.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/search_text_field.dart';
import '../../personal_data_customer/cubit/personal_customer_data_cubit.dart';
import '../../personal_data_customer/cubit/personal_customer_data_state.dart';
import 'all_lawyer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'filter_screen.dart';

class HomeCustomerScreen extends StatefulWidget {
  const HomeCustomerScreen({super.key});

  @override
  State<HomeCustomerScreen> createState() => _HomeCustomerScreenState();
}

class _HomeCustomerScreenState extends State<HomeCustomerScreen> {
  @override
  void initState() {
    context
        .read<PersonalCustomerDataCubit>()
        .getDataFromSharedPreferences(context);

    setState(() {});
    context.read<HomeCustomerCubit>().getHomeDataCustomer(context);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalCustomerDataCubit, PersonalCustomerDataState>(
        builder: (context, state) {
      return Scaffold(
        body: BlocBuilder<HomeCustomerCubit, HomeCustomerState>(
          builder: (context, state) {
            var cubit = context.read<HomeCustomerCubit>();
            var userModelCubit = context.read<PersonalCustomerDataCubit>();
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 50.verticalSpace,
                MainAppBarHomeWidget(
                  isLawyer: false,
                  textCenter: Column(
                    children: [
                      Text(
                        "welcome_to".tr(),
                        style: getBoldStyle(color: AppColors.white),
                      ),
                      Text(
                        userModelCubit.loginModel?.data?.name ?? "",
                        style: getBoldStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                  isSearchWidget: true,
                  widget: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grayLite,
                            offset: const Offset(1, 2),
                            blurRadius: 20,
                            blurStyle: BlurStyle.inner,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: getWidthSize(context),
                    child: SearchTextField(
                      hintText: "search_from_lawyer".tr(),
                      suffixIcon: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilterScreen(
                                      onTap: () {
                                        //!
                                        Navigator.pop(context);
                                        cubit.getHomeDataCustomer(context);
                                        //!
                                      },
                                      screenName: 'home_customer')));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary
                                          .withOpacity(0.2), // لون الظل
                                      spreadRadius: 1, // تمدد الظل
                                      blurRadius: 2, // تأثير التمويه على الظل
                                      offset: const Offset(
                                          0, 2), // إزاحة الظل (لتحريكه)
                                    )
                                  ],
                                  color: AppColors.green,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(ImageAssets.candleIcon),
                              )),
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(ImageAssets.searchIcon),
                      ),
                    ),
                  ),
                ),

                (state is LoadingGetDataCustomer)
                    ? Center(
                        child: CustomLoadingIndicator(),
                      )
                    : Expanded(
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 120.h,
                              child: Padding(
                                padding: EdgeInsets.all(8.0
                                    .sp), // إضافة البادينج باستخدام ScreenUtil
                                child: Swiper(
                                  autoplayDelay: 3000,
                                  autoplay: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: Stack(
                                        fit: StackFit
                                            .loose, // جعل النص يظهر فوق الصورة
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              if (cubit
                                                      .homeDataCustomer
                                                      ?.data
                                                      ?.lawyerOffers?[index]
                                                      .link !=
                                                  null) {
                                                await launch(cubit
                                                        .homeDataCustomer
                                                        ?.data
                                                        ?.lawyerOffers?[index]
                                                        .link ??
                                                    "");
                                              }
                                            },
                                            child: ClipRRect(
                                              child: Image.network(
                                                cubit
                                                        .homeDataCustomer
                                                        ?.data
                                                        ?.lawyerOffers?[index]
                                                        .image ??
                                                    "",
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: cubit.homeDataCustomer?.data
                                          ?.lawyerOffers?.length ??
                                      0,
                                  //! عدد العناصر في الـSwiper
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.sendADistressRequestRoute,
                                    arguments: userModelCubit
                                        .loginModel?.data?.id
                                        .toString());
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0.h),
                                child: Container(
                                  padding: EdgeInsets.all(8.0.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.yellow,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        ImageAssets.phone24Icon,
                                        height: 30.h,
                                        width: 30.w,
                                      ),
                                      Flexible(
                                        child: Text(
                                          "lawyer_for_help_immediately".tr(),
                                          style:
                                              getRegularStyle(fontSize: 15.sp),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          color:
                                              AppColors.white.withOpacity(0.2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0.w, vertical: 5.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "top_rated_lawyers".tr(),
                                    style: getRegularStyle(
                                      fontSize:
                                          14.sp * textScaleFactor(context),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllLawyerScreen(
                                                    title: "top_rated_lawyers"
                                                        .tr(),
                                                    loginModelLawyer: cubit
                                                        .homeDataCustomer
                                                        ?.data
                                                        ?.topRateLawyers,
                                                  )));
                                    },
                                    child: Text(
                                      "see_all".tr(),
                                      style: getUnderLine(
                                        color: AppColors.primary,
                                        fontSize:
                                            14.sp * textScaleFactor(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 280.h),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics:
                                    const ClampingScrollPhysics(), // للسماح فقط بالتمرير الأفقي
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: LawyerItem(
                                    type: 'home',
                                    loginModelLawyer: cubit.homeDataCustomer
                                        ?.data?.topRateLawyers?[index],
                                  ),
                                ),
                                itemCount: cubit.homeDataCustomer?.data
                                    ?.topRateLawyers?.length,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0.w, vertical: 5.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "lawyer_near_from_you".tr(),
                                    style: getRegularStyle(
                                      fontSize:
                                          14.sp * textScaleFactor(context),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      ///!
                                      ///
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllLawyerScreen(
                                                    title:
                                                        "lawyer_near_from_you"
                                                            .tr(),
                                                    loginModelLawyer: cubit
                                                        .homeDataCustomer
                                                        ?.data
                                                        ?.nearLawyers,
                                                  )));
                                    },
                                    child: Text(
                                      "see_all".tr(),
                                      style: getUnderLine(
                                        color: AppColors.primary,
                                        fontSize:
                                            14.sp * textScaleFactor(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 280.h),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: LawyerItem(
                                    type: 'home',
                                    loginModelLawyer: cubit.homeDataCustomer
                                        ?.data?.nearLawyers?[index],
                                  ),
                                ),
                                itemCount: cubit.homeDataCustomer?.data
                                    ?.nearLawyers?.length,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            );
          },
        ),
      );
    });
  }
}
