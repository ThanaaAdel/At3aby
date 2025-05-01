import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/market_lawyer/screen/widgets/appbar_home_lawyer.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import '../../../../core/widgets/search_text_field.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class CommunityServicesScreen extends StatefulWidget {
  const CommunityServicesScreen({super.key});

  @override
  State<CommunityServicesScreen> createState() =>
      _CommunityServicesScreenState();
}

class _CommunityServicesScreenState extends State<CommunityServicesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CommunityServicesCubit>().getCommunityServiceCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityServicesCubit, CommunityServicesState>(
      builder: (context, state) {
        var cubit = context.read<CommunityServicesCubit>();

        return Scaffold(
          body: Column(
            children: [
              //! Appbar
              MainAppBarHomeWidget(
                widget: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: getWidthSize(context),
                  child: SearchTextField(
                    controller: cubit.searchController,
                    hintText: "search".tr(),
                    onChanged: (value) {
                      cubit.getCommunityServiceCategories();

                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(ImageAssets.searchIcon),
                    ),
                  ),
                ),
                isLawyer: false,
                isBackButton: true,
                actionWidget: Container(),
                isSearchWidget: true,
                textCenter: Text(
                  'community_services'.tr(),
                  style: getBoldStyle(color: AppColors.white),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.mainCommunityService?.data?.length ?? 0,
                  itemBuilder: (context, indexMain) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.0.h),
                        child: Text(
                          cubit.mainCommunityService?.data?[indexMain].title ??
                              "",
                          style: TextStyle(
                            color: AppColors.darkGray,
                            fontSize: 14.sp * textScaleFactor(context),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 16.w),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubit.mainCommunityService?.data?[indexMain]
                                .subCategories?.length ??
                            0,
                        itemBuilder: (context, index2) {
                          bool isExpanded =
                              cubit.expandedIndexes[index2] ?? false;

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cubit.getCommunityServiceDetailsFromCategoriesModel?.data == [] || cubit.getCommunityServiceDetailsFromCategoriesModel?.data == null ?
                                  const SizedBox():
                                  cubit.toggleExpand(index2);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10.0.h, top: 10.0.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: customShadow,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 15.h),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Text(
                                              cubit
                                                      .mainCommunityService
                                                      ?.data?[indexMain]
                                                      .subCategories?[index2]
                                                      .title ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 14.sp *
                                                      textScaleFactor(context),
                                                  color: AppColors.blackLight,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Icon(
                                            isExpanded
                                                ? Icons.keyboard_arrow_down
                                                : Icons.arrow_forward_ios_sharp,
                                            size: 15.sp,
                                            color: AppColors.gray,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (isExpanded)

                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10.0.h, top: 10.0.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: customShadow,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 15.h),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Text(
                                              cubit.getCommunityServiceDetailsFromCategoriesModel?.data?[index2].body ?? "",
                                              style: TextStyle(
                                                  fontSize: 14.sp *
                                                      textScaleFactor(context),
                                                  color: AppColors.blackLight,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Icon(
                                            isExpanded
                                                ? Icons.keyboard_arrow_down
                                                : Icons.arrow_forward_ios_sharp,
                                            size: 15.sp,
                                            color: AppColors.gray,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
