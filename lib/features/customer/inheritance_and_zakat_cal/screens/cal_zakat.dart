import 'package:ataaby/features/customer/inheritance_and_zakat_cal/cubit/inheritance_and_zakat_calculator_cubit.dart';
import 'package:ataaby/features/customer/inheritance_and_zakat_cal/cubit/inheritance_and_zakat_calculator_customer_state.dart';
import 'package:ataaby/features/lawyer/market_lawyer/screen/widgets/appbar_home_lawyer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/exports.dart';

class CalZakatScreen extends StatefulWidget {
  CalZakatScreen({super.key, required this.title});
  String title;
  @override
  State<CalZakatScreen> createState() => _CalZakatScreenState();
}

class _CalZakatScreenState extends State<CalZakatScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceAndZakatCalculatorCubit,
        InheritanceAndZakatCalculatorState>(
      builder: (context, state) {
        var cubit = context.read<InheritanceAndZakatCalculatorCubit>();
        return Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                MainAppBarHomeWidget(
                  isLawyer: false,
                  widget: Container(),
                  isBackButton: true,
                  textCenter: Text(
                    widget.title,
                    style: TextStyle(
                      color: AppColors.white,
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  isSearchWidget: true,
                  actionWidget: Container(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'zakat_type'.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        20.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ...cubit.zakatTypeModel.map((item) {
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.onItemSelected(item); // Handle selection
                                    },
                                    child: Container(
                                      margin: EdgeInsetsDirectional.only(start: 8.0.w),
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional.only(
                                                end: 8.0),
                                            child: SvgPicture.asset(
                                              width: 25.w,
                                              cubit.currentZakatType?.id.toString() ==
                                                      item.id.toString()
                                                  ? 'assets/icons/circle_done.svg'
                                                  : 'assets/icons/circle.svg',
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              item.title,
                                              style:  TextStyle(fontSize: 15.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        cubit.currentZakatType?.id == 1
                            ? Padding(
                                padding: EdgeInsets.all(12.0.w),
                                child: CustomTextField(
                                  controller: cubit.totalWealth,
                                  titleStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  hintText: 'sum_of_money_you_have'.tr(),
                                  titleFromTextFormField: 'sum_of_money_you_have'.tr(),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'you_must_enter_total_money'.tr();
                                    }
                    
                                    return null;
                                  },
                                  suffix: Text(
                                    'currency'.tr(),
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 18.sp * textScaleFactor(context),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.all(12.0.w),
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      controller: cubit.totalCrop,
                                      titleStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      hintText: 'totalCrop'.tr(),
                                      titleFromTextFormField: 'totalCrop'.tr(),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'you_must_enter_total_crop'.tr();
                                        }
                    
                                        return null;
                                      },
                                      suffix: Text(
                                        'kg'.tr(),
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 18.sp * textScaleFactor(context),
                                        ),
                                      ),
                                    ),
                                    CustomTextField(
                                      controller: cubit.wasteCrop,
                                      titleStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      hintText: 'wasteCrop'.tr(),
                                      titleFromTextFormField: 'wasteCrop'.tr(),
                                      keyboardType: TextInputType.number,
                                      suffix: Text(
                                        'kg'.tr(),
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 18.sp * textScaleFactor(context),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'you_must_enter_total_crop2'.tr();
                                        }
                                        final waste = double.tryParse(value);
                                        if (waste == null || waste < 0) {
                                          return 'you_must_enter_total_crop2'.tr();
                                        }
                    
                                        return null;
                                      },
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 20.w),
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(
                                        'type_of_irrigation'.tr(),
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 18.sp * textScaleFactor(context),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ...cubit.zakatTypeElzaraModel.map((item) {
                                          return Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                cubit.onItemSelectedZakatElzara(
                                                    item, context); // Handle selection
                                              },
                                              child: Container(
                                                margin: EdgeInsetsDirectional.only(
                                                    start: 8.0.w),
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .only(end: 8.0),
                                                      child: SvgPicture.asset(
                                                        cubit.currentZakatElzaraType?.id
                                                                    .toString() ==
                                                                item.id.toString()
                                                            ? 'assets/icons/circle_done.svg'
                                                            : 'assets/icons/circle.svg',
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        item.title,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ],
                                )),
                        20.h.verticalSpace,
                        (state is LoadingOnCalculateZakatCalculatorInitial)
                            ? const Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: EdgeInsets.all(12.0.w),
                                child: CustomButton(
                                  onTap: () {
                                    if (cubit.currentZakatType?.id == 1) {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.calculateZakat();
                                      }
                                    } else {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.calculateCropZakat(context);
                                      }
                                    }
                                  },
                                  widget: Center(
                                      child: Text(
                                    "cal_zakat".tr(),
                                    style: getRegularStyle(
                                      color: AppColors.white,
                                      fontSize: 14.sp * textScaleFactor(context),
                                    ),
                                  )),
                                ),
                              ),
                        30.h.verticalSpace,
                        Center(
                          child: Text(
                            'result'.tr(),
                            style: TextStyle(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(12.0.w),
                              width: double.infinity,
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: AppColors.grayLite,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                cubit.currentZakatType?.id == 1
                                    ? '${cubit.zakat.toStringAsFixed(1)} ${'currency'.tr()}'
                                    : '${cubit.zakatElzaraa.toStringAsFixed(1)} ${'kg'.tr()}',
                                style: TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
