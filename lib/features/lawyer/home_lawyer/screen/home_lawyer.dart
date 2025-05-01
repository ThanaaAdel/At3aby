import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/custom_issue.dart';
import 'package:ataaby/core/widgets/search_text_field.dart';
import 'package:ataaby/features/lawyer/home_lawyer/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/home_lawyer/cubit/state.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'filter_of_lawyer.dart';
import 'widgets/appbar_home_lawyer.dart';

class HomeLawyerScreen extends StatefulWidget {
  const HomeLawyerScreen({super.key});

  @override
  State<HomeLawyerScreen> createState() => _HomeLawyerScreenState();
}

class _HomeLawyerScreenState extends State<HomeLawyerScreen> {
  @override
  void initState() {
    context.read<HomeLawyerCubit>().getCourtCaseFromSearch(context);
    context.read<HomeLawyerCubit>().getHomeData();
    context.read<HomeLawyerCubit>().searchController.clear();
    print(
        "name : ${context.read<HomeLawyerCubit>().homeLawyerModel?.data?.lawyerData?.name.toString() ?? ""}");
    super.initState();
  }

  @override
  void dispose() {
    EasyDebounce.cancel('home_lawyer-cases-debouncer');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "request:${context.read<HomeLawyerCubit>().homeLawyerModel?.data?.officeRequests}");
    return Scaffold(
      body: BlocBuilder<HomeLawyerCubit, HomeLawyerState>(
          builder: (context, state) {
        var cubit = context.read<HomeLawyerCubit>();
        return (state is HomeLawyerStateLoading &&
                cubit.homeLawyerModel?.data == null)
            ? Center(
                child: CustomLoadingIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    AppbarHomeLawyer(
                      textCenter: Column(
                        children: [
                          Text(
                            "welcome_to".tr(),
                            style: getBoldStyle(color: AppColors.white),
                          ),
                          Text(
                            cubit.homeLawyerModel?.data?.lawyerData?.name
                                    .toString() ??
                                "",
                            style: getBoldStyle(
                                color: AppColors.white, fontSize: 12.sp),
                          ),
                        ],
                      ),
                      widget: SizedBox(
                        height: 140.h,
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0.sp), // إضافة البادينج باستخدام ScreenUtil
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
                                    InkWell(
                                      focusColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        // وظيفة عند الضغط على الصورة
                                        print("Tapped on image $index");
                                      },
                                      child: ClipRRect(
                                        child: Image.network(
                                          cubit
                                                  .homeLawyerModel
                                                  ?.data
                                                  ?.marketOffers?[index]
                                                  .marketProduct
                                                  ?.image ??
                                              "", // استخدام الصور المحلية من القائمة
                                          fit: BoxFit.cover,
                                          width: double
                                              .infinity, // ضبط الصورة لتغطية الـContainer
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: cubit.homeLawyerModel?.data?.marketOffers
                                    ?.length ??
                                0, // عدد العناصر في الـSwiper
                          ),
                        ),
                      ),
                      bottom: 120.h,
                      heightContainer: 150.h,
                    ),
                    (cubit.homeLawyerModel?.data?.officeRequests == [] ||
                            cubit.homeLawyerModel?.data?.officeRequests == null)
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit
                                .homeLawyerModel?.data?.officeRequests?.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(8.0.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: AppColors.gray2Lite,
                                ),
                                padding: EdgeInsets.all(10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(cubit
                                                  .homeLawyerModel
                                                  ?.data
                                                  ?.officeRequests?[index]
                                                  .office
                                                  ?.image ??
                                              "https://img.freepik.com/premium-vector/vector-flat-illustration-grayscale-avatar-user-profile-person-icon-profile-picture-business-profile-woman-suitable-social-media-profiles-icons-screensavers-as-templatex9_719432-1328.jpg?ga=GA1.1.829643350.1741803815&semt=ais_hybrid"),
                                        ),
                                        10.w.horizontalSpace,
                                        Text(
                                          cubit
                                                  .homeLawyerModel
                                                  ?.data
                                                  ?.officeRequests?[index]
                                                  .office
                                                  ?.name ??
                                              "",
                                          style: getBoldStyle(
                                              color: AppColors.secondPrimary),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            cubit.sendOfficeResponse(
                                                requestId: cubit
                                                        .homeLawyerModel
                                                        ?.data
                                                        ?.officeRequests?[index]
                                                        .requestId
                                                        .toString() ??
                                                    "",
                                                status: 1.toString());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              color: AppColors.green,
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              size: 20.sp,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                        10.w.horizontalSpace,
                                        GestureDetector(
                                          onTap: () {
                                            cubit.sendOfficeResponse(
                                                requestId: cubit
                                                        .homeLawyerModel
                                                        ?.data
                                                        ?.officeRequests?[index]
                                                        .requestId
                                                        .toString() ??
                                                    "",
                                                status: 2.toString());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              color: AppColors.red,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              size: 20.sp,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "new_issue_orders".tr(),
                            style: getBoldStyle(
                              fontSize: 14.sp * textScaleFactor(context),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SearchTextField(
                            onChanged: (v) async {
                              EasyDebounce.debounce(
                                  'home_lawyer-cases-debouncer',
                                  const Duration(seconds: 1),
                                  () async =>
                                      //!cubit.searchController
                                      await cubit
                                          .getCourtCaseFromSearch(context));
                            },
                            controller: cubit.searchController,
                            hintText: "search_from_issue".tr(),
                            suffixIcon: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FilterLawyerScreen(
                                              screenName: 'home_lawyer',
                                              onTap: () {
                                                cubit.getCourtCaseFromSearch(
                                                    context);
                                                Navigator.pop(context);
                                              },
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 2),
                                          )
                                        ],
                                        color: AppColors.greenLight,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          ImageAssets.candleIcon),
                                    )),
                              ),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(ImageAssets.searchIcon),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (cubit.selectedSpecialization != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 0),
                        child: Chip(
                          label: Text(
                              cubit.selectedSpecialization?.title?.toString() ??
                                  ''),
                          backgroundColor: AppColors.white,
                          shadowColor: AppColors.white,
                          side: BorderSide(
                            color: AppColors.grayLite3Color,
                            width: 1,
                          ),
                          deleteIconColor: AppColors.red,
                          onDeleted: () {
                            cubit.selectedSpecialization = null;
                            // cubit.getCourtCaseFromSearch(context);
                          },
                        ),
                      ),
                    (state is HomeLawyerStateLoading &&
                            cubit.homeLawyerModel?.data == null)
                        ? Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomLoadingIndicator(),
                              ],
                            ),
                          )
                        : (cubit.homeLawyerModel?.data?.newCourtCases?.length ==
                                    0 ||
                                cubit.homeLawyerModel?.data == null)
                            ? SingleChildScrollView(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      16.h.verticalSpace,
                                      SvgPicture.asset(
                                          ImageAssets.noUpdateIcon),
                                      10.h.verticalSpace,
                                      Text(
                                        "no_data".tr(),
                                        style: getRegularStyle(
                                            color: AppColors.gray),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    await cubit.getCourtCaseFromSearch(context);
                                  },
                                  child: ListView.builder(
                                    itemCount: cubit.homeLawyerModel?.data
                                        ?.newCourtCases?.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w,
                                          right: 10.w,
                                          top: 0.h,
                                          bottom: 10.h),
                                      child: CustomHomeIssue(
                                        newCourtCase: cubit.homeLawyerModel
                                            ?.data?.newCourtCases?[index],
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              Routes.detailsIssueLawyerRoute,
                                              arguments: cubit
                                                  .homeLawyerModel
                                                  ?.data
                                                  ?.newCourtCases?[index]);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                  ]);
      }),
    );
  }
}
