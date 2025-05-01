import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/customer/home_customer/cubit/cubit.dart';
import 'package:ataaby/features/customer/home_customer/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/exports.dart';
import '../../../lawyer/home_lawyer/data/model/specialist_model.dart';
import '../../../lawyer/market_lawyer/screen/widgets/appbar_home_lawyer.dart';
import 'widgets/custom_expansion_widget.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({
    super.key,
    required this.screenName,
    required this.onTap,
  });
  String screenName;
  void Function()? onTap;
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    if (context.read<HomeCustomerCubit>().mainSpecialitiesModel == null ||
        context.read<HomeCustomerCubit>().mainLevelsModel == null) {
      context.read<HomeCustomerCubit>().getFilterLevels();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCustomerCubit, HomeCustomerState>(
      builder: (context, state) {
        var cubit = context.read<HomeCustomerCubit>();

        return Scaffold(
          body: Column(
            children: [
              //! title
              MainAppBarHomeWidget(
                widget: Container(),
                isBackButton: true,
                actionWidget: TextButton(
                    onPressed: () {
                      cubit.onCancelFilter(context);
                      setState(() {});
                    },
                    child: Text(
                      'cancel_filter'.tr(),
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.white,
                        fontSize: 18.sp * textScaleFactor(context),
                        fontWeight: FontWeight.w400,
                        fontFamily: AppStrings.fontFamily,
                        color: AppColors.white,
                      ),
                    )),
                textCenter: Text(
                  'filter_by'.tr(),
                  style: TextStyle(
                    fontSize: 18.sp * textScaleFactor(context),
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                    fontFamily: AppStrings.fontFamily,
                  ),
                ),
                isLawyer: false,
                isSearchWidget: true,
              ),

              Flexible(
                fit: FlexFit.tight,
                child: (state is LoadingGetFilterSpecialist ||
                        state is LoadingGetLevelsState)
                    ? Center(child: CustomLoadingIndicator())
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'filter_by'.tr(),
                                style: TextStyle(
                                  fontSize: 18.sp * textScaleFactor(context),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.gray,
                                  fontFamily: AppStrings.fontFamily,
                                ),
                              ),

                              // Degree Expansion Section

                              CustomerExpandableSection<Level>(
                                  isExpanded: cubit.isExpandedDegree,
                                  title: "degree_of_restriction".tr(),
                                  items:
                                      cubit.mainLevelsModel?.data?.levels ?? [],
                                  onItemSelected: (value) {
                                    cubit.onSelectLevelItem(value);
                                  },
                                  idExtractor: (p0) {
                                    return p0.id.toString();
                                  },
                                  titleExtractor: (p0) {
                                    return p0.title.toString();
                                  },
                                  selectedItem: cubit.selectedLevelController,
                                  backgroundColor: AppColors.white),
                              16.verticalSpace,

                              // Specialization
                              CustomerExpandableSection<Speciality>(
                                  isExpanded: cubit.isExpandedSpecialization,
                                  title: "select_specialization".tr(),
                                  items: cubit.mainSpecialitiesModel?.data
                                          ?.specialities ??
                                      [],
                                  onItemSelected: (value) {
                                    cubit.onSelectSpecialityItem(value);
                                  },
                                  idExtractor: (p0) {
                                    return p0.id.toString();
                                  },
                                  titleExtractor: (p0) {
                                    return p0.title.toString();
                                  },
                                  selectedItem: cubit.selectedSpecialization,
                                  backgroundColor: AppColors.white),
                            ],
                          ),
                        ),
                      ),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.all(8.h),
                width: double.infinity,
                height: 50.h,
                child: CustomButton(
                  onTap: widget.onTap,
                  widget: Center(
                      child: Text(
                    "filter_results".tr(),
                    style: getRegularStyle(
                        color: AppColors.white, fontSize: 15.sp),
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
