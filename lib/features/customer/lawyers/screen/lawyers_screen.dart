import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/dropdown_button_form_field.dart';
import 'package:ataaby/features/customer/home_customer/cubit/state.dart';
import 'package:ataaby/features/customer/lawyers/cubit/state.dart';
import 'package:ataaby/features/customer/lawyers/data/model/type_model.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/exports.dart';
import '../../../../core/widgets/search_text_field.dart';
import '../../../lawyer/market_lawyer/screen/widgets/appbar_home_lawyer.dart';
import '../../home_customer/cubit/cubit.dart';
import '../../home_customer/screen/filter_screen.dart';
import '../../home_customer/screen/widgets/lawer_item.dart';
import '../cubit/cubit.dart';

class LawyersScreen extends StatefulWidget {
  const LawyersScreen({super.key});

  @override
  State<LawyersScreen> createState() => _LawyersScreenState();
}

class _LawyersScreenState extends State<LawyersScreen> {
  @override
  void initState() {
    context.read<LaywersCubit>().getAllLawyers(context);
    super.initState();
  }

  @override
  void dispose() {
    EasyDebounce.cancel('home_lawyer-debouncer');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaywersCubit, LaywersState>(builder: (context, state) {
      var cubit = context.read<LaywersCubit>();
      var cubit2 = context.read<HomeCustomerCubit>();
      return BlocBuilder<HomeCustomerCubit, HomeCustomerState>(
          builder: (context, state) => Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainAppBarHomeWidget(
                      isLawyer: false,
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
                          controller: cubit.searchController,
                          hintText: "search_from_lawyer".tr(),
                          onChanged: (v) async {
                            //!
                            EasyDebounce.debounce(
                                'home_lawyer-debouncer',
                                const Duration(seconds: 1),
                                () async =>
                                    //!cubit.searchController
                                    await cubit.getAllLawyers(context));
                          },
                          suffixIcon: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FilterScreen(
                                          onTap: () {
                                            Navigator.pop(context);
                                            cubit.getAllLawyers(context);
                                          },
                                          screenName: 'main_lawyers_home')));
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
                                          blurRadius:
                                              2, // تأثير التمويه على الظل
                                          offset: const Offset(
                                              0, 2), // إزاحة الظل (لتحريكه)
                                        )
                                      ],
                                      color: AppColors.green,
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
                        ),
                      ),
                      textCenter: Text(
                        "lawyers".tr(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontFamily: AppStrings.fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    10.h.verticalSpace,
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      children: [
                        if (cubit2.selectedLevelController != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 0),
                            child: Chip(
                              label: Text(cubit2.selectedLevelController?.title
                                      ?.toString() ??
                                  ''),
                              backgroundColor: AppColors.white,
                              shadowColor: AppColors.white,
                              side: BorderSide(
                                color: AppColors.grayLite3Color,
                                width: 1,
                              ),
                              deleteIconColor: AppColors.red,
                              onDeleted: () {
                                cubit2.selectedLevelController = null;
                                cubit.getAllLawyers(context);
                              },
                            ),
                          ),
                        if (cubit2.selectedSpecialization != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 0),
                            child: Chip(
                              label: Text(cubit2.selectedSpecialization?.title
                                      ?.toString() ??
                                  ''),
                              backgroundColor: AppColors.white,
                              shadowColor: AppColors.white,
                              side: BorderSide(
                                color: AppColors.grayLite3Color,
                                width: 1,
                              ),
                              deleteIconColor: AppColors.red,
                              onDeleted: () {
                                cubit2.selectedSpecialization = null;
                                cubit.getAllLawyers(context);
                              },
                            ),
                          ),
                      ],
                    ),
                    10.h.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "order_by".tr(),
                              style: TextStyle(
                                color: AppColors.black,
                                fontFamily: AppStrings.fontFamily,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: CustomDropdownButtonFormField<TypeModel>(
                                itemBuilder: (item) {
                                  return item.name ?? '';
                                },
                                value: cubit.currentType,
                                onChanged: (value) {
                                  setState(() {
                                    cubit.currentType = value;
                                    cubit.getAllLawyers(context);
                                  });
                                },
                                items: cubit.typeList,
                              )),
                        ],
                      ),
                    ),
                    Flexible(
                      child: cubit.mainCustomerLawyerModel?.data == null
                          ? Center(
                              child: CustomLoadingIndicator(),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cubit
                                      .mainCustomerLawyerModel?.data?.length,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: 12.0.h, bottom: 5.h),
                                      child: LawyerItem(
                                        type: "lawyers",
                                        loginModelLawyer: cubit
                                            .mainCustomerLawyerModel
                                            ?.data?[index],
                                      ),
                                    );
                                  }),
                            ),
                    )
                  ],
                ),
              ));
    });
  }
}
