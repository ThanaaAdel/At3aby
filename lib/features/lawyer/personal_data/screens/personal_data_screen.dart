import 'dart:developer';

import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/core/widgets/dropdown_button_form_field.dart';
import 'package:ataaby/core/widgets/radio_button.dart';
import 'package:ataaby/features/lawyer/issues_status/screen/issues_status.dart';
import 'package:ataaby/features/lawyer/personal_data/cubit/personal_data_cubit.dart';
import 'package:ataaby/features/lawyer/personal_data/cubit/personal_data_state.dart';
import 'package:ataaby/features/lawyer/personal_data/screens/widget/public_work_radio_button.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/cubit/profile_lawyer_cubit.dart';
import 'package:ataaby/features/login/screens/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import '../../../new_register/data/model/country_model.dart';

File? imageFile;

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key, this.isLawyer});
  final bool? isLawyer;

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  @override
  initState() {
    super.initState();
    context.read<PersonalDataCubit>().fillLawyerInfo(context);
    context.read<ProfileLawyerCubit>().getDataFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PersonalDataCubit, PersonalDataState>(
          builder: (context, state) {
        var cubit = context.read<PersonalDataCubit>();
        return Column(
          children: [
            AppbarContainImage(
              isLawyer: true,
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.mainLawyerRoute,
                    arguments:
                        ChooseTypeRegisterArgs(indexPageClientOrLawyer: 1));
              },
              titleCenter: "personal_data".tr(),
            ),

            IssueStatus(
              onTap: cubit.changeIndex,
              currentIndex: cubit.currentIndex,
              titles: [
                "basic_information".tr(),
                "lawyer_information".tr(),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    cubit.currentIndex == 0
                        ? BasicInformation(
                            isLawyer: widget.isLawyer,
                            personalDataCubit: cubit,
                          )
                        : LawyerInformation(
                            cubit: cubit,
                          ),
                  ],
                ),
              ),
            ),
            //!
            (state is UpdateProfileStateLoading)
                ? Center(
                    child: CustomLoadingIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                          onTap: () {
                            cubit.updateProfileLawyer(context,
                                cityId: cubit.selectedCityController?.id ?? 0,
                                countryId:
                                    cubit.selectedCountryController?.id ?? 0,
                                image: imageFile?.path,
                                numberOfSuccessCases:
                                    cubit.successIssueController.text,
                                name: cubit.nameController.text.isEmpty
                                    ? context
                                        .read<ProfileLawyerCubit>()
                                        .loginModelLawyer
                                        ?.data
                                        ?.name
                                    : cubit.nameController.text,
                                phone: context
                                        .read<ProfileLawyerCubit>()
                                        .loginModelLawyer
                                        ?.data
                                        ?.phone ??
                                    "");
                          },
                          widget: Center(
                              child: Text(
                            "save_information".tr(),
                            style: getRegularStyle(color: AppColors.white),
                          ))),
                    ),
                  )
          ],
        );
      }),
    );
  }
}

class BasicInformation extends StatefulWidget {
  const BasicInformation(
      {super.key, this.isLawyer, required this.personalDataCubit});
  final bool? isLawyer;
  final PersonalDataCubit personalDataCubit;

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  @override
  initState() {
    super.initState();
    widget.personalDataCubit.getCities();
    widget.personalDataCubit.getCountries();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var lawyerData = context.read<ProfileLawyerCubit>().loginModelLawyer?.data;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 30.sp * textScaleFactor(context),
                backgroundImage: imageFile != null
                    ? FileImage(imageFile!) as ImageProvider
                    : NetworkImage(lawyerData?.image ?? ""),
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Text(
                  "change_photo".tr(),
                  style: getUnderLine(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        CustomTextField(
          controller: widget.personalDataCubit.nameController,
          titleFromTextFormField: "full_name".tr(),
          hintText: lawyerData?.name ?? "",
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.changeEmailRoute,
                arguments: widget.isLawyer ?? true);
          },
          child: CustomTextField(
            enabled: false,
            titleFromTextFormField: "email".tr(),
            hintText: lawyerData?.email ?? "",
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "change".tr(),
                style: getUnderLine(color: AppColors.primary),
              ),
            ),
          ),
        ),
        CustomTextField(
          titleFromTextFormField: "phone".tr(),
          hintText: lawyerData?.phone ?? "",
          enabled: false,
        ),
        CustomTextField(
          titleFromTextFormField: "nationality_id".tr(),
          hintText: lawyerData?.nationalId ?? "",
          enabled: false,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomDropdownButtonFormField<Country>(
            items: widget.personalDataCubit.mainCountryModel?.data?.countries ??
                [],
            value: widget.personalDataCubit.selectedCountryController,
            onChanged: (newValue) {
              setState(() {
                widget.personalDataCubit.selectedCountryController = newValue;
                widget.personalDataCubit.getCities();
              });
            },
            itemBuilder: (item) {
              return item.title ?? '';
            },
          ),
        ),
      ],
    );
  }
}

class LawyerInformation extends StatefulWidget {
  const LawyerInformation({super.key, required this.cubit});
  final PersonalDataCubit cubit;

  @override
  State<LawyerInformation> createState() => _LawyerInformationState();
}

class _LawyerInformationState extends State<LawyerInformation> {
  @override
  Widget build(BuildContext context) {
    var lawyerData = context.read<ProfileLawyerCubit>().loginModelLawyer?.data;
    var cubit = context.read<PersonalDataCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          enabled: false,
          titleFromTextFormField: "lawyer_membership_number".tr(),
          hintText: lawyerData?.lawyerId ?? "",
          suffixIcon: Padding(
            padding: EdgeInsets.all(12.0.sp),
            child: SvgPicture.asset(ImageAssets.idendificationNumberIcon),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: widget.cubit.successIssueController,
                keyboardType: TextInputType.number,
                titleFromTextFormField: "success_issue".tr(),
                hintText: "success_issue".tr(),
                padding: EdgeInsets.all(10.sp),
              ),
            ),
            Expanded(
              child: CustomTextField(
                controller: widget.cubit.failureIssueController,
                keyboardType: TextInputType.number,
                titleFromTextFormField: "failure_issue".tr(),
                hintText: "failure_issue".tr(),
                padding: EdgeInsets.all(10.sp),
              ),
            ),
          ],
        ),
        CustomTextField(
          controller: widget.cubit.aboutMeController,
          keyboardType: TextInputType.text,
          titleFromTextFormField: "about_me".tr(),
          hintText: "about_me".tr(),
          padding: EdgeInsets.all(10.sp),
          isMessage: true,
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: cubit.consultationPriceController,
                titleFromTextFormField: "consultation_price".tr(),
                hintText: "0",
              ),
            ),
            Expanded(
              child: CustomTextField(
                controller: cubit.priceInTheCaseController,
                titleFromTextFormField: "price_in_the_case".tr(),
                hintText: "0",
              ),
            ),
          ],
        ),
        RadioExample(
          onChanged: (value) {
            log(value.toString());
            setState(() {
              widget.cubit.typeSelectedValue = value;
            });
          },
          selectedValue:
              widget.cubit.typeSelectedValue ?? SingingCharacter.individual,
          headerTitle: "profile_size".tr(),
          titleFromRadioButtonSecond: "law_office".tr(),
          descriptionSecond: "multiple_lawyer".tr(),
          titleFromRadioButtonFirst: "lawyer_for_account".tr(),
        ),
        PublicWorkRadioExample(
          onChanged: (value) {
            setState(() {
              widget.cubit.publicWorkTypeSelectedValue = value;
            });
          },
          selectedValue: widget.cubit.publicWorkTypeSelectedValue ??
              PublicWorkCharacter.active,
          headerTitle: "do_share_from_public_work".tr(),
          titleFromRadioButtonFirst: "yes".tr(),
          titleFromRadioButtonSecond: "no".tr(),
        ),
      ],
    );
  }
}
