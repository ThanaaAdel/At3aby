import 'package:easy_localization/easy_localization.dart';

import '../../../../core/exports.dart';
import '../../../../core/widgets/dropdown_button_form_field.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../data/model/city_model.dart';
import '../../data/model/country_model.dart';

class CompleteYourProfileData extends StatefulWidget {
  CompleteYourProfileData(
      {required this.cubit, super.key, required this.isLawyer});
  NewRegisterCubit cubit;
  bool isLawyer;
  @override
  State<CompleteYourProfileData> createState() =>
      _CompleteYourProfileDataState();
}

class _CompleteYourProfileDataState extends State<CompleteYourProfileData> {
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRegisterCubit, NewRegisterState>(
      builder: (context, state) {
        var cubit = context.read<NewRegisterCubit>();
        return Form(
          key: key,
          child: Expanded(

            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "complete_profile_info".tr(),
                        style: getBoldStyle(
                          fontSize: 20.sp * textScaleFactor(context),
                          color: AppColors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
              
                  // TextFields and Dropdowns
                  CustomTextField(
                    enabled: !(state is LoadingLawyerRegisterState ||
                        state is LoadingClientRegisterState),
                    controller: cubit.nationalityNumberController,
                                    keyboardType: TextInputType.number,
              
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(ImageAssets.nationalityIdIcon),
                    ),
                    hintText: "nationality_id".tr(),
                    titleFromTextFormField: "nationality_id".tr(),
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "nationality_id".tr();
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomTextField(
                    enabled: !(state is LoadingLawyerRegisterState ||
                        state is LoadingClientRegisterState),
                    controller: cubit.phoneNumberController,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(ImageAssets.phoneNumberIcon),
                    ),
                    hintText: "phone".tr(),
                    keyboardType: TextInputType.phone,
                    titleFromTextFormField: "phone".tr(),
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "phone".tr();
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Text(
                      "country".tr(),
                      style:
                          getRegularStyle(fontSize: 16.sp, color: AppColors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  (state is LoadingGetCountriesState)
                      ? Container()
                      : (cubit.mainCountryModel?.data?.countries == [] &&
                              cubit.mainCountryModel != null)
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                              child: CustomDropdownButtonFormField<Country>(
                                items:
                                    cubit.mainCountryModel?.data?.countries ?? [],
                                value: cubit.selectedCountryController,
                                onChanged: (newValue) {
                                  setState(() {
                                    cubit.selectedCountryController = newValue;
                                    cubit.getCities();
                                  });
                                },
                                itemBuilder: (item) {
                                  return item.title ?? '';
                                },
                              ),
                            ),
                  10.h.verticalSpace,
                  (state is LoadingGetCitiesState)
                      ? Container()
                      : (cubit.mainCityModel?.data?.cities?.length == 0)
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Text(
                                    'city'.tr(),
                                    style: getRegularStyle(fontSize: 15.sp),
                                  ),
                                ),
                                10.h.verticalSpace,
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: CustomDropdownButtonFormField<City>(
                                    items: cubit.mainCityModel?.data?.cities ?? [],
                                    value: cubit.selectedCityController,
                                    onChanged: (newValue) {
                                      setState(() {
                                        cubit.selectedCityController = newValue;
                                      });
                                    },
                                    itemBuilder: (item) {
                                      return item.title ?? '';
                                    },
                                  ),
                                ),
                                //!
                                30.h.verticalSpace,
                              ],
                            ),
                  10.h.verticalSpace,
              
                  widget.isLawyer
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              cubit.currentStep == 1
                                  ? SizedBox(height: 5.h)
                                  : CustomButton(
                                      widget: Row(
                                        children: [
                                          Text(
                                            "next".tr(),
                                            style: getRegularStyle(
                                                color: AppColors.white),
                                          ),
                                          SizedBox(width: 10.w),
                                          Icon(Icons.arrow_forward,
                                              color: AppColors.white),
                                        ],
                                      ),
                                      onTap: () {
                                        if (key.currentState!.validate()) {
                                          cubit.goToNextStep();
                                        }
                                      },
                                    )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
