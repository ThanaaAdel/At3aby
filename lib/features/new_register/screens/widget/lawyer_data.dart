import 'package:easy_localization/easy_localization.dart';
import '../../../../core/exports.dart';
import '../../../../core/utils/custom_loading.dart';
import '../../../../core/widgets/dropdown_button_form_field.dart';
import '../../../../core/widgets/radio_button.dart';
import '../../../lawyer/home_lawyer/data/model/specialist_model.dart';
import '../../../login/screens/login.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class LawyerData extends StatefulWidget {
  LawyerData({required this.args, super.key});
  ChooseTypeRegisterArgs args;
  @override
  State<LawyerData> createState() => _LawyerDataState();
}

class _LawyerDataState extends State<LawyerData> {
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRegisterCubit, NewRegisterState>(
      builder: (context, state) {
        var cubit = context.read<NewRegisterCubit>();
        return Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "lawyer_data".tr(),
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
                controller: cubit.lawyerIdController,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(ImageAssets.nationalityIdIcon),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "lawyer_membership_number".tr();
                  } else {
                    return null;
                  }
                },
                hintText: "lawyer_membership_number".tr(),
                titleFromTextFormField: "lawyer_membership_number".tr(),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Text(
                  "degree".tr(),
                  style:
                      getRegularStyle(fontSize: 16.sp, color: AppColors.black),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: CustomDropdownButtonFormField<Level>(
                  items: cubit.mainLevelsModel?.data?.levels ?? [],
                  value: cubit.selectedLevelController,
                  onChanged: (newValue) {
                    setState(() {
                      cubit.selectedLevelController = newValue;
                      cubit.getSpecialities();
                    });
                  },
                  itemBuilder: (item) {
                    return item.title ?? '';
                  },
                ),
              ),
              10.h.verticalSpace,
              // ignore: prefer_is_empty
              cubit.mainSpecialitiesModel?.data?.specialities?.length == 0
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Text(
                        "specialist".tr(),
                        style: getRegularStyle(
                            fontSize: 16.sp, color: AppColors.black),
                      ),
                    ),
              SizedBox(
                height: 10.h,
              ),
              (state is LoadingGetSpecialityState ||
                      // ignore: prefer_is_empty
                      cubit.mainSpecialitiesModel?.data?.specialities?.length ==
                          0)
                  ? Container()
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: CustomDropdownButtonFormField<Speciality>(
                            items: cubit.mainSpecialitiesModel?.data
                                    ?.specialities ??
                                [],
                            value: cubit.selectedSpecialitController,
                            onChanged: (newValue) {
                              setState(() {
                                cubit.addOrRemoveUser(newValue!);

                                cubit.selectedSpecialitController = newValue;
                              });
                            },
                            itemBuilder: (item) {
                              return item.title ?? '';
                            },
                          ),
                        ),
                        //! show selected list here

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Wrap(
                                children: cubit.selectedSpecialityList
                                    .map((item) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: Chip(
                                            deleteIconColor: AppColors.red,
                                            label: Text(item.title?? ''),
                                            onDeleted: () {
                                              cubit.addOrRemoveUser(item);
                                            })))
                                    .toList()),
                          ],
                        ),
                      ],
                    ),
              SizedBox(height: 10.h),
              RadioExample(
                onChanged: (value) {
                  setState(() {
                    cubit.typeSelectedValue = value;
                  });
                },
                selectedValue:
                    cubit.typeSelectedValue ?? SingingCharacter.individual,
                headerTitle: "profile_size".tr(),
                titleFromRadioButtonSecond: "law_office".tr(),
                descriptionSecond: "multiple_lawyer".tr(),
                titleFromRadioButtonFirst: "lawyer_for_account".tr(),
              ),
              SizedBox(height: 30.h),
              cubit.currentStep == 0
                  ? SizedBox(height: 5.h)
                  : (state is LoadingLawyerRegisterState ||
                          state is LoadingClientRegisterState)
                      ? Center(child: CustomLoadingIndicator())
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cubit.goToBackStep();
                                },
                                child: Text("previous".tr(),
                                    style: getBoldStyle(
                                      fontSize: 15.sp,
                                      color: AppColors.gray,
                                    )),
                              ),
                              CustomButton(
                                widget: Row(
                                  children: [
                                    Text(
                                      "register".tr(),
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
                                    setState(() {
                                      cubit.currentStep = 1;
                                    });
                                    if (cubit.selectedSpecialityList.isEmpty) {
                                      errorGetBar('select_speciality'.tr());
                                    } else {
                                      cubit.mainRegister(context, widget.args);
                                    }
                                  }
                                },
                              )
                            ],
                          ),
                        ),
            ],
          ),
        );
      },
    );
  }
}
