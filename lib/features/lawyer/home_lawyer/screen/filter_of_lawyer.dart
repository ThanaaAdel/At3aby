import 'package:easy_localization/easy_localization.dart';

import '../../../../core/exports.dart';
import '../../../../core/utils/custom_loading.dart';
import '../../market_lawyer/screen/widgets/appbar_home_lawyer.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../data/model/specialist_model.dart';

class FilterLawyerScreen extends StatefulWidget {
  FilterLawyerScreen({
    super.key,
    required this.screenName,
    this.onTap,
  });
  String screenName;
  void Function()? onTap;
  @override
  State<FilterLawyerScreen> createState() => _FilterLawyerScreenState();
}

class _FilterLawyerScreenState extends State<FilterLawyerScreen> {
  @override
  void initState() {
    if (context.read<HomeLawyerCubit>().mainSpecialitiesModel == null) {
      context.read<HomeLawyerCubit>().getFilterSpecialist();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLawyerCubit, HomeLawyerState>(
      builder: (context, state) {
        var cubit = context.read<HomeLawyerCubit>();

        return Scaffold(
          body: Column(
            children: [
              //! title
              MainAppBarHomeWidget(
                widget: Container(),
                isBackButton: true,
                actionWidget: TextButton(
                    onPressed: () {
                      cubit.onCancelFilter(context,
                          isCurrentcases: widget.screenName == 'home_lawyer'
                              ? false
                              : true);
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
                isLawyer: true,
                isSearchWidget: true,
              ),

              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                  child: state is LoadingGetFilterSpecialist
                      ? Center(child: CustomLoadingIndicator())
                      : SingleChildScrollView(
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

                              // Specialization Expansion Section (dummy content for now)
                              ExpandableSection(
                                  isExpanded: cubit.isExpandedSpecialization,
                                  title: "select_specialization".tr(),
                                  items: cubit.mainSpecialitiesModel?.data
                                          ?.specialities ??
                                      [],
                                  onItemSelected: (value) {
                                    cubit.onSelectItem(value);
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
                  color: AppColors.secondPrimary,
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

class ExpandableSection extends StatefulWidget {
  final String title; // Section title
  final List<Speciality> items; // List of selectable items
  final Speciality? selectedItem; // Currently selected item
  final ValueChanged<Speciality> onItemSelected; // Callback for item selection
  final Color? backgroundColor; // Optional background color
  final EdgeInsets contentPadding; // Content padding
  bool isExpanded;

  ExpandableSection({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    this.backgroundColor,
    this.isExpanded = false,
    this.contentPadding = const EdgeInsets.all(16.0),
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      color: widget.backgroundColor ??
          Colors.white, // Background color with fallback
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              widget.isExpanded = value;
            });
            print(widget.isExpanded);
          },
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 16.0), // Title padding
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          trailing: SvgPicture.asset(
            widget.isExpanded
                ? 'assets/icons/remove.svg'
                : 'assets/icons/add.svg',
          ),
          children: [
            Padding(
              padding: widget.contentPadding,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 4.0,
                      left: 8.0,
                      right: 8.0,
                    ),
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  ...widget.items.map((item) {
                    return GestureDetector(
                      onTap: () {
                        widget.onItemSelected(item); // Handle selection
                      },
                      child: Container(
                        margin: EdgeInsetsDirectional.only(start: 8.0.w),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 8.0),
                              child: SvgPicture.asset(
                                widget.selectedItem?.id.toString() ==
                                        item.id.toString()
                                    ? 'assets/icons/rectangle_done.svg'
                                    : 'assets/icons/rectangle.svg',
                              ),
                            ),
                            Flexible(
                              child: Text(
                                item.title ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
